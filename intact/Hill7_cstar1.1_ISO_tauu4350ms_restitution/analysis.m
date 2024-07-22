
data = dlmread('linescan.txt');
Time_Stable=4000;
NadirThreshold = 682;
SparkThreshold = 170; % assume spark size is related to SR load


%%%%%%%%% Secondly, I get the ratio for consecutive sparks' SR depletion.
cjsr_ratio = zeros(30000,10); % record the restitution, the last 2 are
index=1;
for zz=16:25
    for yy=1:62
        cjsr = data( yy:62:(size(data,1)-62+yy), zz );

        cjsmooth = -smooth(cjsr,20,'loess'); % smooth the data
        [cjsr_nadir,t_nadir] = findpeaks(cjsmooth,...
            'MinPeakDistance',20,'MinPeakHeight',-NadirThreshold);

        t_nadir = t_nadir + 5;
        % the nadir is not good enough, so I refine it.
        for k=1:length(t_nadir)
            lb = t_nadir(k)-5; 
            ub = t_nadir(k)+5;
            if ub>size(data,1)/62
                ub=size(data,1)/62;
            end

            cjsr_nadir(k) = min(cjsr((lb):(ub)));
            t_nadir(k) = find( min(cjsr((lb):(ub)))...
                            == cjsr((lb):(ub)),1)+t_nadir(k)-6;
        end

        % find the beginning of each blink
        cjsrdiff = diff(cjsr);
        start_blink = zeros(length(t_nadir),2)+500;
        nadir1st = zeros(50,2)+500; % indicate the big blink position
        nadir1st_index = 1; % index for "nadir1st"
        for i=1:length(t_nadir)
            if i==1
                left = 100;
            else
                left = max([t_nadir(i)-70,t_nadir(i-1)+5]);
            end


            % find the beginning of blink, based on the slope
            for k=left:t_nadir(i)
                if cjsrdiff(k)<-1 && cjsrdiff(k-1)>=-1 ...
                        && cjsr(k)>cjsr_nadir(i)
                    start_blink(i,1) = k;
                    break;
                end
            end
            start_blink(i,2) = cjsr(start_blink(i,1)); % SR load

            % get the restitution data
            if i>1 && t_nadir(i-1)>Time_Stable

                fall2nd = start_blink(i,2)-cjsr_nadir(i);
                fall1st = start_blink(i-1,2)-cjsr_nadir(i-1);

                if fall1st > SparkThreshold %&& t_nadir(i)-t_nadir(i-1)>=30%(cc,kk)

                    cjsr_ratio(index,1)=t_nadir(i)-t_nadir(i-1); 
                    cjsr_ratio(index,2)=fall2nd/fall1st; % restitution
                    cjsr_ratio(index,3)=zz;
                    cjsr_ratio(index,4)=yy;
                    cjsr_ratio(index,5)=t_nadir(i-1);
                    cjsr_ratio(index,6)=fall1st;
                    cjsr_ratio(index,7)=t_nadir(i);
                    cjsr_ratio(index,8)=fall2nd;
                    cjsr_ratio(index,9)=start_blink(i-1,1);
                    cjsr_ratio(index,10)=start_blink(i-1,2);
                    index = index+1;

                    nadir1st(nadir1st_index,1) = t_nadir(i-1);
                    nadir1st(nadir1st_index,2) = cjsr_nadir(i-1);
                    nadir1st_index = nadir1st_index + 1;
                end
            end

        end

        
    end

end

yy=20; % index of CRU in x direction, [1,62]
zz=16; % column index in "data", cjsr is in [16,25]
temp = cjsr_ratio;
temp(temp(:,3)~=zz,:) = [];
temp(temp(:,4)~=yy,:) = [];

figure(2);
clf(2);
hold on
    plot(data(yy:62:(size(data,1)-62+yy),1), data(yy:62:(size(data,1)-62+yy),zz));
    plot(temp(:,9),temp(:,10),'ro','MarkerFaceColor','r');
    plot(data(temp(:,5)*62+yy,1),data(temp(:,5)*62+yy,zz),'go','MarkerFaceColor','g');
    plot(data(temp(:,7)*62+yy,1),data(temp(:,7)*62+yy,zz),'bo','MarkerFaceColor','b');
hold off

% There are some negative values, convert them to 0, 
% and then remove the 0's
index = cjsr_ratio(:,2)<0;
cjsr_ratio(index,:)=0;
cjsr_ratio( ~any(cjsr_ratio,2), : ) = [];  %rows
cjsr_ratio( :, ~any(cjsr_ratio,1) ) = [];  %columns

% group the data by 20ms
[N,x,idx]=histcounts(cjsr_ratio(:,1),'BinWidth',20);
restitution = zeros(max(idx),3);
restitution(:,1) = x(2:end).'-10; % t
for i=1:max(idx)
    restitution(i,2) = mean(cjsr_ratio(idx==i,8)); % ratio
    restitution(i,3) = std(cjsr_ratio(idx==i,8)); % error
end

% remove the values that are NaN
index = isnan(restitution(:,2));
restitution(index,:)=0;
restitution( ~any(restitution,2), : ) = [];  %rows
restitution( :, ~any(restitution,1) ) = [];  %columns

% fit the restitution curve
cjsr_ratio = sortrows(cjsr_ratio);
fo = fitoptions('Method','NonlinearLeastSquares',...
                   'Lower',[0,0,0],...
                   'Upper',[400,1000,1000],...
                   'StartPoint',[200,30,100]);
    ft = fittype('a-a*exp(-(x-b)/c)','options',fo);
    [par,~] = fit(restitution(3:20,1),restitution(3:20,2),ft);
    % [line,statistics] = fit(cjsr_ratio(1:length(cjsr_ratio(:,1))*1,1),...
    %             cjsr_ratio(1:length(cjsr_ratio(:,1))*1,2),ft);
    [restitution(6,1), restitution(6,2)]

parameter = zeros(2,1);
parameter(1) = par.a;
parameter(2) = par.b;
parameter(3) = par.c;

display(size(cjsr_ratio,1));
figure(1);
clf(1);
    hold on
    plot(cjsr_ratio(:,1),cjsr_ratio(:,8),'ro',...
        'MarkerFaceColor','r','MarkerSize',1.5);
    errorbar(restitution(:,1),restitution(:,2),restitution(:,3),'bo'...
            ,'MarkerFaceColor','b','MarkerSize',1.5);
    fh = @(x) par.a-par.a*exp(-(x-par.b)/par.c);
    plot(1:max(restitution(:,1)),fh(1:max(restitution(:,1))),...
        'k','LineWidth',1);
    hold off
    xlim([0 1000]);
    % ylim([-0.2 2]);
    title(sprintf('%.2f-%.2f*exp(-(x-%.2f)/%.2f), %.2f',parameter(1),parameter(1),parameter(2),parameter(3),parameter(2)+parameter(3)));

%% plot
set(findobj('type','axes'),'FontSize',12);
set(gcf, 'PaperPosition', [0 0 7 5]); 
set(gcf, 'PaperSize', [7 5]); 
saveas(gcf, 'restitution', 'pdf');

%% output
dlmwrite('ratio_vs_t.txt', cjsr_ratio, 'delimiter', '\t');
dlmwrite('ratio_vs_t_avg.txt', restitution, 'delimiter', '\t');

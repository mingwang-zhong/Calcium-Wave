% This code is to calculate the spark properties using linescan.txt
% and fluoxt.txt

function spark_ci01_avg()
    global  total_time_linescan total_time_fluo stable_time Tgap Tmax Xgap Xmax SparkThreshold
    
    total_time_linescan = 11000; 
    total_time_fluo = 11000;
    stable_time = 4001;
    Tgap = 20; % minimum total_time between sparks (half peak is the spark boundary)
    Tmax = 600; % big enogh to contain a spark.
    Xgap = 2; % minimum space between sparks 
    Xmax = 20; % big enough to contain a spark
    SparkThreshold = 2000;

    [spark_avg, nonspark_avg, total_spark, total_nonspark, nonspark_I, start_pos] = linescan();
    [spark_profile, total_spark_fluo, spark_image_avg, spark_image_avg_2] = SparkProfile(start_pos);

    sparkrate = total_spark/(total_time_linescan-Tmax-stable_time)*1000;
    nonsparkrate = total_nonspark/(total_time_linescan-Tmax-stable_time)*1000;
    sparkrate_fluo = total_spark_fluo/(total_time_fluo-Tmax-stable_time)*1000/3;

    data = dlmread('ci0.1/wholecell.txt');
    ci = mean(data(stable_time:(total_time_fluo-Tmax),2));
    cj = mean(data(stable_time:(total_time_fluo-Tmax),8));
    
%     [x,y] = meshgrid(-9:0.9:9, -100:100);
%     [xf,yf] = meshgrid(-9:0.1:9, -100:0.2:100);
%     spark_image_avg_fine = interp2(x, y, spark_image_avg_2, xf, yf);%, 'cubic', 1);
%     spark_image_avg_fine = spark_image_avg_fine'/fluo_basal;
%     spark_image_avg_fine(~spark_image_avg_fine) = fluo_basal;

    % dlmwrite('spark.txt', spark_avg, 'delimiter', '\t');
    % dlmwrite('spark_ci01_avg_linescan_2.txt', spark_image_avg, 'delimiter', '\t');
    dlmwrite('spark_ci01_avg_fluoxt.txt', spark_image_avg_2.', 'delimiter', '\t');

    basal = mean(spark_image_avg_2(1:200,1));
    peak = max(max(spark_image_avg_2(1:200,:)));
    [j i] = find(spark_image_avg_2(1:200,:)==peak,1);
    FF0 = peak/basal;
    array = spark_image_avg_2(j, :);
    FWHM = EachSparkSize(array, i, basal, 5)*0.1;
    array = spark_image_avg_2(1:200, i);
    FDHM = EachSparkSize(array, j, basal, 5)*0.2;
    [FF0 FWHM FDHM]


    figure(1);
        subplot(3,3,1)
            plot(1:100,spark_avg(1:100,1),'-o');
            xlabel('Time (ms)');
            title('I_{rel} (pA)');
        subplot(3,3,4)
            plot(1:Tmax, spark_avg(:,2), '-o');
            xlabel('Time (ms)');
            title('[Ca^{2+}]_{JSR} (\muM)');
        subplot(3,3,2)
            plot(1:100, spark_avg(1:100,4), '-o');
            xlabel('Time (ms)');
            title('nou');
        subplot(3,3,3)
            plot(1:100, spark_avg(1:100,5), '-o');
            xlabel('Time (ms)');
            title('nob');
        subplot(3,3,5)
            plot(1:Tmax, spark_avg(:,6), '-o');
            xlabel('Time (ms)');
            title('ncu');
        subplot(3,3,6)
            plot(1:Tmax, spark_avg(:,7), '-o');
            xlabel('Time (ms)');
            title('ncb');

        subplot(3,3,7);
            histogram(spark_profile(:,1));
            xlabel('F/F_0');
        subplot(3,3,8);
            histogram(spark_profile(:,2));
            xlabel('FWHM (\mum)');
            xlim([1 inf]);
        subplot(3,3,9);
            histogram(spark_profile(:,3));
            xlabel('FDHM (ms)');
        
        dim = [.19 .61 .3 .3];
        str={'Mean current over',sprintf('20 ms: %.2f pA', sum(spark_avg(:,1))/20)};
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'FontSize', 12, 'EdgeColor','none');
        dim = [.24 0 .3 .3];
        str = strcat(sprintf('%.2f', mean(spark_profile(:,1))),'\pm',...
            sprintf('%.2f', std(spark_profile(:,1))));
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'FontSize', 12, 'EdgeColor','none');
        dim = [.5 0 .3 .3];
        str = strcat(sprintf('%.2f', mean(spark_profile(:,2))),'\pm',...
            sprintf('%.2f ', std(spark_profile(:,2))), '\mum');
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'FontSize', 12, 'EdgeColor','none');
        dim = [.77 0 .3 .3];
        str = strcat(sprintf('%.1f', mean(spark_profile(:,3))),'\pm',...
            sprintf('%.1f ms', std(spark_profile(:,3))));
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'FontSize', 12, 'EdgeColor','none');
        
        dim = [0 .41 .3 .3];
        s1=sprintf('Time range:\n%d ms\n',total_time_fluo-Tmax-stable_time);
        s2=sprintf('\n\nSpark rate:\n%.1f/s\n',sparkrate);
        s3=sprintf('\n\nAvg c_i:\n%.2f uM\n',ci);
        s4=sprintf('\n\nAvg c_j:\n%.0f uM\n',cj);
        s5=sprintf('\n\nc_p before\nsparks:\n%.2f uM\n',spark_avg(10,3));
        s6=sprintf('\n\nc_j before\nsparks:\n%.0f uM\n',spark_avg(10,2));
        s7=sprintf('\n\nSpark rate\n(fluo):\n%.1f/s\n',sparkrate_fluo);
        str = strcat(s1,s2,s3,s4,s5,s6,s7);
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'EdgeColor','none','FontSize',9);
        
        set(findobj('type','axes'),'FontSize',11);
        set(gcf, 'PaperPosition', [0.2 0 10 8]);
        set(gcf, 'PaperSize', [10 8]);
        % saveas(gcf, 'SparkAnalysis', 'pdf');

        clf(1);

    figure(1);
        subplot(3,3,1)
            plot(5:25,nonspark_avg(5:25,1),'-o');
            xlabel('Time (ms)');
            title('I_{rel} (pA)');
            xlim([5 25]);
        subplot(3,3,4)
            plot(5:25, nonspark_avg(5:25,2), '-o');
            xlabel('Time (ms)');
            title('[Ca^{2+}]_{JSR} (\muM)');
            xlim([5 25]);
        subplot(3,3,2)
            plot(5:25, nonspark_avg(5:25,4), '-o');
            xlabel('Time (ms)');
            title('nou');
            xlim([5 25]);
        subplot(3,3,3)
            plot(5:25, nonspark_avg(5:25,5), '-o');
            xlabel('Time (ms)');
            title('nob');
            xlim([5 25]);
        subplot(3,3,5)
            plot(5:25, nonspark_avg(5:25,6), '-o');
            xlabel('Time (ms)');
            title('ncu');
            xlim([5 25]);
        subplot(3,3,6)
            plot(5:25, nonspark_avg(5:25,7), '-o');
            xlabel('Time (ms)');
            title('ncb');
            xlim([5 25]);
        subplot(3,3,7)
            bar([total_spark total_nonspark]);
            ax = gca;
            ax.XTick = [1,2];
            ax.XTickLabel = {'Spark','Non-spark'};
            ylabel('# of events');
        subplot(3,3,8);
            histogram(nonspark_I(1:total_nonspark,1));
            xlabel('I_{rel} (pA)');
            title('Non-spark current peak');
            % xlim([inf inf]);
        subplot(3,3,9);
            histogram(nonspark_I(1:total_nonspark,2));
            xlabel('Time (ms)');
            title('Non-spark current duration');
            % xlim([inf inf]);

        
        dim = [.19 .61 .3 .3];
        str={'Mean current over',sprintf('1 ms: %.2f pA', sum(nonspark_avg(:,1)))};
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'FontSize', 12, 'EdgeColor','none');
        
        dim = [0 .41 .3 .3];
        s1=sprintf('\n\nnon-spark rate:\n%.1f/s\n',nonsparkrate);
        s2=sprintf('\n\nc_p before\nnon-sparks:\n%.2f uM\n',nonspark_avg(10,3));
        s3=sprintf('\n\nc_j before\nnon-sparks:\n%.0f uM\n',nonspark_avg(10,2));
        str = strcat(s1,s2,s3);
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'EdgeColor','none','FontSize',9);
        
        set(findobj('type','axes'),'FontSize',11);
        set(gcf, 'PaperPosition', [0.2 0 10 8]);
        set(gcf, 'PaperSize', [10 8]);
        % saveas(gcf, 'SparkAnalysis_nonSpark', 'pdf');

        clf(1);

end

function [spark_avg, nonspark_avg, total_spark, total_nonspark, nonspark_I, start_pos] = linescan()

    global  stable_time total_time_linescan Tgap Tmax SparkThreshold
    
    data = dlmread('ci0.1/linescan.txt');
    num_CRU = 62;
    linescan = zeros(num_CRU, 20, total_time_linescan);
    for t=1:total_time_linescan
        linescan(:,:,t) = data( ( (t-1)*num_CRU+1 ):( t*num_CRU ), :);
    end
    
    % Tmax:maximum open time, 5000: maximum number of releases
    spark = zeros(Tmax, 5000, 7); % 1:I, 2:cjsr, 3:cp, 4:nou, 5:nob, 6:ncu, 7:ncb
    nonspark = zeros(Tmax, 5000, 7);
    nonspark_I = zeros(5000,2); % 1:peak, 2:duration

    num_spark = 1; % number of sparks
    num_nonspark = 1; % number of non-sparks

    start_pos = zeros(10000, 2); % t, 1:64

    for i=1:num_CRU
        current_binary = reshape(linescan(i, 8, stable_time:(total_time_linescan-Tmax)),[],1);
        current_binary(current_binary>0) = 1;
        current_binary([1 end]) = 1; % filled with 1
        increase = find(diff(current_binary) == 1);
        decrease = find(diff(current_binary) == -1);
        pos = find( increase - decrease >= Tgap ); % index of increase or decrease
        if size(pos,1) >= 2
            spark_start = increase(pos(1:(end-1)))+1; % start of the sparks
            spark_end = decrease(pos(2:end)); % end of the sparks

            % feed the matrix line by line
            for k=1:size(spark_start)

                temp_start = stable_time+spark_start(k)-1-10;
                current_end = spark_end(k)-spark_start(k)+1+10;

                if any( linescan(i, 8, temp_start:(temp_start+current_end-1)) > SparkThreshold )

                    spark(1:current_end, num_spark,1) = ...
                        linescan(i, 8, temp_start:(temp_start+current_end-1))/100.0*2.0*9.648533*0.00126;
                    spark(:,num_spark,2) = linescan(i,6,temp_start:(temp_start+Tmax-1)); % cjsr
                    spark(:,num_spark,3) = linescan(i,4,temp_start:(temp_start+Tmax-1)); % cp
                    spark(:,num_spark,4) = linescan(i,13,temp_start:(temp_start+Tmax-1)); % nou
                    spark(:,num_spark,5) = linescan(i,14,temp_start:(temp_start+Tmax-1)); % nob
                    spark(:,num_spark,6) = linescan(i,15,temp_start:(temp_start+Tmax-1)); % ncu
                    spark(:,num_spark,7) = linescan(i,16,temp_start:(temp_start+Tmax-1)); % ncb

                    start_pos(num_spark,1) = temp_start;
                    start_pos(num_spark,2) = i;
                    num_spark = num_spark + 1;

                else

                    nonspark(1:current_end, num_nonspark, 1) = ...
                        linescan(i, 8, temp_start:(temp_start+current_end-1))/100.0*2.0*9.648533*0.00126;
                    nonspark(:,num_nonspark, 2) = linescan(i,6,temp_start:(temp_start+Tmax-1));
                    nonspark(:,num_nonspark, 3) = linescan(i,4,temp_start:(temp_start+Tmax-1));
                    nonspark(:,num_nonspark, 4) = linescan(i,13,temp_start:(temp_start+Tmax-1));
                    nonspark(:,num_nonspark, 5) = linescan(i,14,temp_start:(temp_start+Tmax-1));
                    nonspark(:,num_nonspark, 6) = linescan(i,15,temp_start:(temp_start+Tmax-1));
                    nonspark(:,num_nonspark, 7) = linescan(i,16,temp_start:(temp_start+Tmax-1));

                    nonspark_I(num_nonspark,1) = max(nonspark(1:current_end, num_nonspark, 1)); % peak current of non-spark
                    nonspark_I(num_nonspark,2) = spark_end(k) - spark_start(k) + 1; % duration of non-spark current

                    num_nonspark = num_nonspark+1;

                end

            end
        end
    end
    
    spark_avg = zeros(Tmax,7);
    spark_avg(:,1) = mean(spark(:,1:(num_spark-1),1), 2);
    spark_avg(:,2) = mean(spark(:,1:(num_spark-1),2), 2);
    spark_avg(:,3) = mean(spark(:,1:(num_spark-1),3), 2);
    spark_avg(:,4) = mean(spark(:,1:(num_spark-1),4), 2);
    spark_avg(:,5) = mean(spark(:,1:(num_spark-1),5), 2);
    spark_avg(:,6) = mean(spark(:,1:(num_spark-1),6), 2);
    spark_avg(:,7) = mean(spark(:,1:(num_spark-1),7), 2);
    total_spark = num_spark - 1;
    start_pos(total_spark:end,:) = [];

    nonspark_avg = zeros(Tmax,7);
    nonspark_avg(:,1) = mean(nonspark(:,1:(num_nonspark-1),1), 2);
    nonspark_avg(:,2) = mean(nonspark(:,1:(num_nonspark-1),2), 2);
    nonspark_avg(:,3) = mean(nonspark(:,1:(num_nonspark-1),3), 2);
    nonspark_avg(:,4) = mean(nonspark(:,1:(num_nonspark-1),4), 2);
    nonspark_avg(:,5) = mean(nonspark(:,1:(num_nonspark-1),5), 2);
    nonspark_avg(:,6) = mean(nonspark(:,1:(num_nonspark-1),6), 2);
    nonspark_avg(:,7) = mean(nonspark(:,1:(num_nonspark-1),7), 2);
    total_nonspark = num_nonspark - 1;
end

function [spark_profile, total_spark, spark_image_avg, spark_image_avg_2] = SparkProfile(start_pos)
    global  total_time_fluo stable_time Tgap Tmax Xgap Xmax 
    
    % start_pos

    FluoSizeX = 128;
    fluo_basal = 4.3;
    fluo_threshold = fluo_basal*1.7;

    fluoxt = dlmread('ci0.1/fluoxt.txt');
    fluo = zeros(total_time_fluo+Tmax, FluoSizeX+Xmax, 7); %It is larger because of boudary.
    for t = 1:total_time_fluo
        fluo(t+Tmax/2, (Xmax/2+1):(FluoSizeX+Xmax/2), :) = ...
                            fluoxt( ( (t-1)*FluoSizeX+1 ):( t*FluoSizeX ), :);
    end


    % find the spark peaks
    mask = ones(200, 10);
    mask(100, 5) = 0;
    num_spark = 1;

    for j=3:5
        slice = fluo(stable_time:end, :, j);
        slice( slice < fluo_threshold ) = 0;
        slice2 = slice > ordfilt2(slice,sum(sum(mask)),mask); % only peaks are 1
        [row, col] = find(slice2==1);

        if numel(row)>=1
            peak(num_spark:(num_spark+numel(row)-1), 1) = row + stable_time-1;
            peak(num_spark:(num_spark+numel(row)-1), 2) = col;
            peak(num_spark:(num_spark+numel(row)-1), 3) = j;
            peak(num_spark:(num_spark+numel(row)-1), 4) = ...
                fluo(sub2ind(size(fluo),row+stable_time-1,col,ones(numel(row),1)*j));
            num_spark = num_spark + numel(row);
        end
    end


    % get the spark profile
    spark_profile = zeros(num_spark-1,3); % FWHM, FDHM, F/F_0
    for ii = 1:(num_spark-1)

        % F/F_0
        spark_profile(ii, 1) = peak(ii,4)/fluo_basal;

        % FWHM
        spark_x = fluo( peak(ii,1), (peak(ii,2)-Xmax/2):(peak(ii,2)+Xmax/2), ...
                        peak(ii,3) );
        spark_profile(ii, 2)=EachSparkSize(spark_x, Xmax/2+1, fluo_basal, Xgap);

        % FDHM
        spark_time = fluo( (peak(ii,1)-Tmax/2):(peak(ii,1)+Tmax/2), ...
                            peak(ii,2), peak(ii,3) );
        spark_profile(ii, 3)=EachSparkSize(spark_time, Tmax/2+1, fluo_basal,Tgap);
    end

    total_spark = num_spark - 1;

    % align the peaks
    spark_image_all = zeros(Tmax+1, Xmax+1, total_spark);
    for k = 1:total_spark
        spark_image_all(:,:,k) = fluo( (peak(k,1)-Tmax/2):(peak(k,1)+Tmax/2), ...
            (peak(k,2)-Xmax/2):(peak(k,2)+Xmax/2), peak(k,3) );
    end
    spark_image_avg = mean( spark_image_all, 3 );

    % align the starting position
    % start_pos(start_pos(:,1)<=10000,:)=[];
    % start_pos(:,1) = start_pos(:,1) - 10000;

    spark_image_all_2 = zeros(Tmax*5+1, Xmax*10+1, size(start_pos,1));
    [x,y] = meshgrid(-(Xmax/2*0.76):0.76:(Xmax/2*0.76), -(Tmax/2):(Tmax/2));
    [xf,yf] = meshgrid(-(Xmax/2*0.76):0.076:(Xmax/2*0.76), -(Tmax/2):0.2:(Tmax/2));
    
    for k = 1:(size(start_pos,1))
        temp = fluo( (start_pos(k,1)+Tmax/2):(start_pos(k,1)+Tmax/2+Tmax),...
            (start_pos(k,2)*2+1):(start_pos(k,2)*2+1+Xmax), 3 );
        temp(~temp) = fluo_basal;
        spark_image_all_2(:,:,k) = interp2(x, y, temp, xf, yf, 'cubic', 1);
    end
    spark_image_avg_2 = mean( spark_image_all_2, 3 );

    % CaDye
    spark_image_all_CaDye = zeros(Tmax*5+1, Xmax*10+1, size(start_pos,1));
    for k = 1:(size(start_pos,1))
        temp = fluo( (start_pos(k,1)+Tmax/2):(start_pos(k,1)+Tmax/2+Tmax),...
            (start_pos(k,2)*2+1):(start_pos(k,2)*2+1+Xmax), 6 );
        temp(~temp) = fluo_basal;
        spark_image_all_CaDye(:,:,k) = interp2(x, y, temp, xf, yf, 'linear', 1);
    end
    dlmwrite('spark_ci01_avg_CaDye.txt', mean( spark_image_all_CaDye, 3 ).', 'delimiter', '\t');

    % CaATP
    spark_image_all_CaATP = zeros(Tmax*5+1, Xmax*10+1, size(start_pos,1));
    for k = 1:(size(start_pos,1))
        temp = fluo( (start_pos(k,1)+Tmax/2):(start_pos(k,1)+Tmax/2+Tmax),...
            (start_pos(k,2)*2+1):(start_pos(k,2)*2+1+Xmax), 7 );
        temp(~temp) = fluo_basal;
        spark_image_all_CaATP(:,:,k) = interp2(x, y, temp, xf, yf, 'linear', 1);
    end
    dlmwrite('spark_ci01_avg_CaATP.txt', mean( spark_image_all_CaATP, 3 ).', 'delimiter', '\t');

end

% The following function is to detect the start and end of a spark.
% Input: 
%   Array
%   peak_pos: position of the spark maximum
%   basal: basal of the original array
%   min_gap: minimum number of 0 between two sparks of 1
% Output:
%   FWHM: full width at half maximum

function FWHM = EachSparkSize(Array, peak_pos, basal, min_gap)
    
    Half_Peak = (basal+Array(peak_pos))/2;
    Array_Binary = Array;
    Array_Binary( Array_Binary < Half_Peak ) = 0;
    Array_Binary( Array_Binary >= Half_Peak ) = 1;
    Array_Binary([1 end]) = 1;
    
    increase = find(diff(Array_Binary) == 1);
    decrease = find(diff(Array_Binary) == -1);
    num_large_space = find( increase - decrease >= min_gap );
    
    spark_start = 0;
    spark_end = 0;
    
    if numel(num_large_space) == 2
        
        spark_start = increase(num_large_space(1))+1;
        spark_end = decrease(num_large_space(2));
   
    elseif numel(num_large_space) > 2
        
        for i=2:numel(num_large_space)
            
            spark_start = increase(num_large_space(i-1));
            spark_end = decrease(num_large_space(i));
            
            if ( spark_start < peak_pos ) && ( spark_end > peak_pos )
                break;
            end
            
        end
        
    end

    
    spark_start = spark_start - 1 + (Half_Peak-Array(spark_start-1))/...
                                (Array(spark_start)-Array(spark_start-1));
                            
    spark_end = spark_end + (Half_Peak-Array(spark_end))/...
                        (Array(spark_end+1)-Array(spark_end));
                    
    FWHM = spark_end - spark_start;
end
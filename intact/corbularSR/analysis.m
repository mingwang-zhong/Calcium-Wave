dV = 0.5;
Numi = 40;

% cSR, latency, ci, cj, spark rate, Aci, Av, N_DAD, N_TA
statAll = zeros(2,27);
for j = 1:2
    ind = 1;
    cSR = 0.02*(j-1);
    % i, DAD or TA, t, ci, cj, spark rate, t_Aci, Aci, t_Av, Av
    result = zeros(5000,10); 
    
    fprintf('cSR = %g \n', cSR);
    numTA = 0;

    for i = 1:Numi
        
        b0 = 4; % the first beat to count

        fprintf('%g ', i);
        if mod(i,10)==0
            fprintf('\n'); 
        end

        data = dlmread(sprintf('cSR%g_%g/wholecell.txt', cSR, i));
        indi = 1;
        maxbeat=( floor((data(end,1)-100)/2000));
        for b=b0:maxbeat
            
            t100 = 2000*(b-1)+200;
            t2000 = 2000*b+100;
            tVis0 = find(data(t100:t2000,7)<0,1) + t100 - 1;
            
            NTA_beat = find(data(tVis0:t2000,7)>0);
            temp1 = data(tVis0:t2000,7);
            temp1(temp1>=0) = 1;
            temp1(temp1<0) = 0;
            temp2 = diff(temp1);
            temp2(temp2<0) = 0;

            flagTA = sum(temp2); % numel(NTA_beat)>0;
            numTA = numTA + flagTA;
            
            Vmin = min(data(tVis0:t2000,7));
            tVmin1= find(data(tVis0:t2000,7)<Vmin+0.3,1) + tVis0 - 1;
            forbase = find(data(tVmin1:t2000,7)<Vmin+0.3)+tVmin1-1;
            Vb = mean(data(forbase,7)); % baseline of diastolic Vm
            cib = mean(data(forbase,2)); % baseline of diastolic ci
            cjb = mean(data(forbase,5)); % baseline of diastolic cj
            rateb = mean(data(forbase,36)); % baseline of diastolic rate

            tDAD = tVmin1;
            tDAD = find(data(tDAD:t2000,7)>Vb+dV,1) + tDAD - 1;
            while ( numel(tDAD)>0 )
                result(ind, 1) = i;
                result(ind, 2) = flagTA;
                result(ind, 3) = tDAD;
                result(ind, 4) = cib; %data(tDAD,2); % ci at DAD initiation
                result(ind, 5) = cjb; %data(tDAD,5); % cj at DAD initiation
                result(ind, 6) = rateb; %data(tDAD,36); % spark rate

                % determine if there is a 2nd DAD in this beat
                temp = find(data(tDAD:t2000,7)<Vb,1) + tDAD - 1;
                tDADnext = find(data(temp:t2000,7)>Vb+dV,1) + temp - 1;
                if numel(tDADnext)==0
                    tDADnext = t2000;
                end

                maxci = max(data(tDAD:tDADnext,2));
                maxv = max(data(tDAD:tDADnext,7));
                result(ind, 7) = find(data(tDAD:tDADnext,2)==maxci,1) ...
                                    + tDAD -1;
                result(ind, 8) = max(data(tDAD:tDADnext,2)) - cib; % A_ci
                result(ind, 9) = find(data(tDAD:tDADnext,7)==maxv,1) ...
                                + tDAD -1;
                result(ind, 10) = max(data(tDAD:tDADnext,7)) - Vb; % A_Vm

                if (tDADnext==t2000)
                    tDAD = [];
                else
                    tDAD = tDADnext;
                end

                ind = ind + 1;
                indi = indi + 1;
            end
            
            % there are no DADs at low uptake, so we use the basal values
            if j<0
                result(ind, 1) = i;
                result(ind, 2) = 0;
                result(ind, 3) = NaN;
                result(ind, 4) = cib; %data(tDAD,2); % ci at DAD initiation
                result(ind, 5) = cjb; %data(tDAD,5); % cj at DAD initiation
                result(ind, 6) = rateb; %data(tDAD,36); % spark rate
                
                result(ind, 7:10) = NaN;
                ind = ind + 1;
            end

        end

        if (0)
            figure(1);
            clf(1);
                tDADinit = result((ind-indi+1):(ind-1),3);
                tDADmax = result((ind-indi+1):(ind-1),9);
                hold on;
                plot(data(:,1), data(:,7));
                plot(tDADinit, data(tDADinit,7),'o');
                plot(tDADmax, data(tDADmax,7),'o');
                hold off;
                title(sprintf('%d',i));
            pause(1); 
        end
    end
    
    result(~any(result,2),:)=[];
    
    resultDAD = result(result(:,2)==0,:); % get the subthrethold DAD
    latencyDAD = resultDAD(:,3)-floor((resultDAD(:,3)-100)/2000)*2000-100;
    NumDAD = size(resultDAD,1);
    if j<0
        NumDAD = 0;
        numTA = 0;
    end

    statAll(j,1) = cSR;
    statAll(j,2) = NumDAD; % Number of DAD
    statAll(j,3) = mean(latencyDAD); % latency
    statAll(j,4) = std(latencyDAD);
    statAll(j,5) = mean(resultDAD(:,4)); % ci
    statAll(j,6) = std(resultDAD(:,4));
    statAll(j,7) = mean(resultDAD(:,5)); % cj
    statAll(j,8) = std(resultDAD(:,5));
    statAll(j,9) = mean(resultDAD(:,6)); % spark rate
    statAll(j,10) = std(resultDAD(:,6));
    statAll(j,11) = mean(resultDAD(:,8)); % max ci
    statAll(j,12) = std(resultDAD(:,8));
    statAll(j,13) = mean(resultDAD(:,10)); % max Vm
    statAll(j,14) = std(resultDAD(:,10));
    
    resultTA = result(result(:,2)>=1,:); % get the superthrethold DAD
    latencyTA = resultTA(:,3)-floor((resultTA(:,3)-100)/2000)*2000-100;
    statAll(j,15) = numTA; % size(resultTA,1); % Number of TA
    statAll(j,16) = mean(latencyTA);
    statAll(j,17) = std(latencyTA);
    statAll(j,18) = mean(resultTA(:,4)); % ci
    statAll(j,19) = std(resultTA(:,4));
    statAll(j,20) = mean(resultTA(:,5)); % cj
    statAll(j,21) = std(resultTA(:,5));
    statAll(j,22) = mean(resultTA(:,6)); % spark rate
    statAll(j,23) = std(resultTA(:,6));
    statAll(j,24) = mean(resultTA(:,8)); % max ci
    statAll(j,25) = std(resultTA(:,8));
    statAll(j,26) = mean(resultTA(:,10)); % max Vm
    statAll(j,27) = std(resultTA(:,10));
    
    dlmwrite(sprintf('result_cSR%g.txt',cSR), result, 'delimiter', '\t');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    str = {'Latency','Distolic c_i','Distolic c_j','Spark rate',...
        'c_i amplitude', 'V_m amplitude', 'Number of DAD'};
    value = [4 5 6 8 10];
    figure(2);
    clf(2);
        for i=1:6
            subplot(4,3,i);
                if i==1
                    histogram(latencyDAD);
                else
                    histogram(resultDAD(:,value(i-1)));
                end
                xlabel(str(i));
                title('Sub DAD');
        end
        
        for i=7:12
            subplot(4,3,i);
                if i==7
                    histogram(latencyTA);
                else
                    histogram(resultTA(:,value(i-7)));
                end
                xlabel(str(i-6));
                title('TA');
        end
        
            
    set(findobj('type','axes'),'FontSize',11);
    set(gcf, 'PaperPosition', [-1 0 12 15]);
    set(gcf, 'PaperSize', [10 15]);
    saveas(gcf, sprintf('result_cSR%g.pdf',cSR), 'pdf');
    pause(2);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp = dlmread('../uptake/result_Vup_all.txt');
temp(4,1) = 0.05;
statAll = [statAll; temp(4,:)];
dlmwrite('result_cSR_all.txt', statAll, 'delimiter', '\t');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3); % DAD
clf(3);
    for i=1:7
        subplot(3,3,i);
        if i==7
            plot(statAll(:,1), statAll(:,2),'-o');
        else
            errorbar(statAll(:,1),statAll(:,2*i+1),statAll(:,2*i+2),'-o');
        end
        xlabel('V_{up}');
        title(str(i));
    end
set(findobj('type','axes'),'FontSize',11);
set(gcf, 'PaperPosition', [-1 0 12 10]);
set(gcf, 'PaperSize', [10 10]);
saveas(gcf, 'cSR_DAD.pdf', 'pdf');
    
figure(4); % TA
clf(4);
    for i=1:7
        subplot(3,3,i);
        if i==7
            plot(statAll(:,1), statAll(:,15),'-o');
        else
            errorbar(statAll(:,1),statAll(:,2*i+14),statAll(:,2*i+15),'-o');
        end
        xlabel('V_{up}');
        title(str(i));
    end
set(findobj('type','axes'),'FontSize',11);
set(gcf, 'PaperPosition', [-1 0 12 10]);
set(gcf, 'PaperSize', [10 10]);
saveas(gcf, 'cSR_TA.pdf', 'pdf');
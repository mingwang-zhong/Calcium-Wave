
num = 10; % number of simulations
Nb = 50; % number of beats of each simulation
results = zeros(5000, 11); % time; takeoff Vm; EAD amplitude; cp; cj; ICa peak of EADs; diastolic cj; integrated ICal during EADs

ind = 1;
for j=1:num
    data=dlmread(sprintf('Hill10_alpha0.2_beta0.001_cstar1.2_%g/wholecell.txt',j));
    for i=2:Nb
        ti = (i-1)*2000+200; % start time of this beat
        ti1 = (i-1)*2000+800; % end time of this beat
        
        if ti-100+2000<size(data,1)
            [vmax,tmax] = findpeaks(data(ti:ti1,7),'MinPeakHeight',-20,'MinPeakDistance',100); % EAD amplitude
            [vmin,tmin] = findpeaks(-data(ti:ti1,7),'MinPeakHeight',-30,'MinPeakDistance',100); % Take-off voltage
            cpmin = min(data((ti-50):(ti+50),3)); % mininum cp within [ti-50, ti+50]
            tmin_cp = find( data((ti-50):(ti+50),3)==cpmin ) + ti-50; % time at the minimum cp
            tend = find(data(ti:ti1,7)<-80, 1) + ti; % end of the action potential

            if numel(vmax)>0 && numel(vmin) % when there is an EAD

                vmin = -vmin(1);
                tmin = tmin(1)+ti;
                tmax = tmax(1)+ti;

                results(ind,1) = tmin;
                results(ind,2) = vmin; % Take-off voltage
                results(ind,3) = vmax; % EAD amplitude
                results(ind,4) = cpmin; % Take-off cp
                results(ind,5) = data(tmin_cp, 5); % Take-off cj
                results(ind,6) = min(data(tmin:(tmin+200),9)); % ICaL peak
                results(ind,7) = mean(data( (ti-300):(ti-100),2)); % diastolic ci
                results(ind,8) = mean(data( (ti-300):(ti-100),5)); % diastolic cj
                results(ind,9) = max(data( (ti-200):(ti+200),2)); % ci peak

                if i<Nb
                    results(ind,10) = sum( data((ti-100):(ti-100+2000), 9) ) * 45.0/0.0965/2.0/26/62/10; % 10^-15 μmol, integrated ICal over a PCL
                    results(ind,11) = sum( data((ti-100):(ti-100+2000), 8) ) * 45.0/0.0965/26/62/10; % 10^-15 μmol, integrated INCX over a PCL
                else
                    results(ind,10) = nan;
                    results(ind,11) = nan;
                end

                ind = ind+1;
            end
        end

    end
end


results = results(any(results,2),:);
results(results(:,2)==max(results(:,2)),:)=[]; % delete the outlier data with a max Vm
display(numel(results(:,1)));

dlmwrite('data_EAD.txt', results, 'delimiter', '\t');

%% fitting

% diastolic cj vs take-off Vm
fo = fitoptions('Method','NonlinearLeastSquares',...
   'Lower',[0.1, 945],...
   'Upper',[2, 975],...
   'StartPoint',[0.5, 960]);
ft = fittype('A*x+B','options',fo);

[line,~] = fit(results(:,2), results(:,8), ft);

output = ['Diastolic cj vs. take-off Vm:  slope is ', num2str(line.A), ...
    ', intercept is ', num2str(line.B)];
display(output);



% ci peak vs take-off Vm
fo = fitoptions('Method','NonlinearLeastSquares',...
   'Lower',[0.001, 4.6],...
   'Upper',[0.07, 5.2],...
   'StartPoint',[0.007, 4.9]);
ft = fittype('A*x+B','options',fo);

[line,~] = fit(results(:,2), results(:,9), ft);

output = ['ci peak vs. take-off Vm:  slope is ', num2str(line.A), ...
    ', intercept is ', num2str(line.B)];
display(output);



% take-off cp vs take-off Vm
fo = fitoptions('Method','NonlinearLeastSquares',...
   'Lower',[0.001, 1.6],...
   'Upper',[0.07, 2],...
   'StartPoint',[0.007, 1.85]);
ft = fittype('A*x+B','options',fo);

[line,~] = fit(results(:,2), results(:,4), ft);

output = ['take-off cp vs. take-off Vm:  slope is ', num2str(line.A), ...
    ', intercept is ', num2str(line.B)];
display(output);

%% plot
figure(1);
clf(1);
    subplot(2,4,1);
    plot(results(:,2), results(:,4), 'o');
    xlabel('Take-off $V_m$ (mV)', 'Interpreter','latex');
    ylabel('Take-off $c_p$ ($\mu$M)', 'Interpreter','latex');


    subplot(2,4,2);
    plot(results(:,2), results(:,5), 'o');
    xlabel('Take-off $V_m$ (mV)', 'Interpreter','latex');
    ylabel('Take-off $c_j$ ($\mu$M)', 'Interpreter','latex');


    subplot(2,4,3);
    plot(results(:,2), results(:,7), 'o');
    xlabel('Take-off $V_m$ (mV)', 'Interpreter','latex');
    ylabel('diastolic $c_i$ ($\mu$M)', 'Interpreter','latex');


    subplot(2,4,4);
    plot(results(:,2), results(:,8), 'o');
    xlabel('Take-off $V_m$ (mV)', 'Interpreter','latex');
    ylabel('diastolic $c_j$ ($\mu$M)', 'Interpreter','latex');


    subplot(2,4,5);
    plot(results(:,2), results(:,9), 'o');
    xlabel('Take-off $V_m$ (mV)', 'Interpreter','latex');
    ylabel('$c_i$ peak ($\mu$M)', 'Interpreter','latex');


    subplot(2,4,6);
    plot(results(:,2), results(:,6), 'o');
    xlabel('Take-off $V_m$ (mV)', 'Interpreter','latex');
    ylabel('$I_{Ca,L}$ peak (pA/pF)', 'Interpreter','latex');


    subplot(2,4,7);
    plot(results(:,2), results(:,10), 'o');
    hold on;
    plot(results(:,2), results(:,11), 's');
    hold off;
    legend('$I_{Ca,L}$', '$I_{NCX}$', 'Location', 'northwest', 'Interpreter','latex');
    xlabel('Take-off $V_m$ (mV)', 'Interpreter','latex');
    ylabel('Integrated $I_{Ca,L}$ or $I_{NCX}$', 'Interpreter','latex');


    subplot(2,4,8);
    plot(results(:,2), results(:,11), 'o');
    xlabel('Take-off $V_m$ (mV)', 'Interpreter','latex');
    ylabel('Integrated $I_{NCX}$', 'Interpreter','latex');
    
    set(findobj('type','axes'),'FontSize',11);
    set(gcf, 'PaperPosition', [0 0 12 6]);
    set(gcf, 'PaperSize', [12 6]);
    saveas(gcf, 'EADanalysis.pdf', 'pdf');


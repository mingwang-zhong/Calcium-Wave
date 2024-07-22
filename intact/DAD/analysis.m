function analysis()
    nHill = 4;
    Nbeat = [45 45 85 85];
    Hill = [4; 5; 6; 7];
    latency = zeros(nHill,3);
    citakeoff = zeros(nHill,3);
    cjtakeoff = zeros(nHill,3);
    ciAmp = zeros(nHill,3);
    VmAmp = zeros(nHill,3);
    frequency = zeros(nHill,3);
    
    latency(:,1) = Hill;
    citakeoff(:,1) = Hill;
    cjtakeoff(:,1) = Hill;
    ciAmp(:,1) = Hill;
    VmAmp(:,1) = Hill;
    frequency(:,1) = Hill;
    
    
    for i=1:nHill
        filename=sprintf('Hill%d_alpha0.2_beta0.001_cstar1.4/wholecell.txt',3+i);
        raw_EachHill = get_EachHill(filename, Nbeat(i));
        NN = sqrt(size(raw_EachHill,1));
        latency(i,2) = mean(raw_EachHill(:,2));
        latency(i,3) = std(raw_EachHill(:,2))/NN;
        citakeoff(i,2) = mean(raw_EachHill(:,3));
        citakeoff(i,3) = std(raw_EachHill(:,3))/NN;
        cjtakeoff(i,2) = mean(raw_EachHill(:,5));
        cjtakeoff(i,3) = std(raw_EachHill(:,5))/NN;
        ciAmp(i,2) = mean(raw_EachHill(:,4));
        ciAmp(i,3) = std(raw_EachHill(:,4))/NN;
        VmAmp(i,2) = mean(raw_EachHill(:,6));
        VmAmp(i,3) = std(raw_EachHill(:,6))/NN;
        frequency(i, 2) = Nbeat(i); % number of beats
        frequency(i, 3) = numel(raw_EachHill(:,2));
    end
    dlmwrite('latency_cstar1.4.txt', latency, 'delimiter', '\t');
    dlmwrite('citakeoff_cstar1.4.txt', citakeoff, 'delimiter', '\t');
    dlmwrite('cjtakeoff_cstar1.4.txt', cjtakeoff, 'delimiter', '\t');
    dlmwrite('frequency_cstar1.4.txt', frequency, 'delimiter', '\t');
    
    figure(1);
    clf(1);
        subplot(2,3,1);
        errorbar(Hill, latency(:,2),latency(:,3),'-o');
        xlim([3.5 7.5]);
        xlabel('Hill');
        title('Latency (ms)');
        
        subplot(2,3,2);
        errorbar(Hill, citakeoff(:,2),citakeoff(:,3),'-o');
        xlim([3.5 7.5]);
        xlabel('Hill');
        title('takeoff ci (uM)');
        
        subplot(2,3,3);
        errorbar(Hill, cjtakeoff(:,2),cjtakeoff(:,3),'-o');
        xlim([3.5 7.5]);
        xlabel('Hill');
        title('takeoff cj (uM)');
        
        subplot(2,3,4);
        errorbar(Hill, ciAmp(:,2),ciAmp(:,3),'-o');
        xlim([3.5 7.5]);
        xlabel('Hill');
        title('ci amplitude (uM)');
        
        subplot(2,3,5);
        errorbar(Hill, VmAmp(:,2),VmAmp(:,3),'-o');
        xlim([3.5 7.5]);
        xlabel('Hill');
        title('Vm amplitude (mV)');
        
        subplot(2,3,6);
        plot(Hill, frequency(:,3)./frequency(:,2),'-o');
        xlim([3.5 7.5]);
        xlabel('Hill');
        ylim([0 1.1]);
        title('Frequency of DAD');
        
        set(findobj('type','axes'),'FontSize',11);
        set(gcf, 'PaperPosition', [-1 0 12 10]);
        set(gcf, 'PaperSize', [10 10]);
        saveas(gcf, 'Hill_DAD.pdf', 'pdf');
end


function results=get_EachHill(filename, Nb)

    data = dlmread(filename);

    results = zeros(Nb, 6); % t; latency; takeoff ci; ci amplitude; takeoff cj; Vm amplitude; 
    for i=1:Nb
        ti = (i+3)*2000+100; % start time of this beat
        ti1 = (i+4)*2000+100; % end time of this beat
        t1 = find(data((ti+200):ti1, 7)<-70, 1) + ti + 200; % find the time where Vm<-70mV
        smoothdata = sgolayfilt(data(t1:ti1,7), 9, 101); % Polynomial order, length
        [vmin,tmin] = findpeaks(-smoothdata,'MinPeakHeight',-86,'MinPeakDistance',100);
        vmin = -vmin(1);
        tmin = tmin(1)+t1;
        vmax = max(data(tmin:ti1,7)); % find the maximum Vm during diastole
        tmax = find( data(tmin:ti1,7)==vmax, 1 ) + tmin;


        cimin = min(data((tmin-200):(tmin+200),2));
        tmin_ci = find(data(t1:ti1,2)==cimin, 1)+t1;
        smoothdata = sgolayfilt(data(tmin:ti1,2), 9, 101);
        [~,tmax_ci] = findpeaks(smoothdata,'MinPeakHeight',cimin+0.05,'MinPeakDistance',100);
        if numel(tmax_ci)>=1
            tmax_ci = tmax_ci(1) + tmin;
            cimax = max(data((tmax_ci-50):(tmax_ci+50),2));
        end


        if vmax>vmin+0.5 % only save the Vm amplitude that is large enough
            results(i, 1) = tmin;
            results(i, 2) = tmax-t1; % latency
            results(i, 3) = cimin; % takeoff ci
            results(i, 4) = cimax; % ci amplitude
            results(i, 5) = data(tmin_ci, 5); % takeoff cj
            results(i, 6) = vmax; % Vm amplitude
        end
    end

    results = results(any(results,2),:);
end

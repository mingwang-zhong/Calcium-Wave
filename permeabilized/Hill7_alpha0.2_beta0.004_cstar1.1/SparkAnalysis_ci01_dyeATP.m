% This code is to calculate the spark properties using linescan.txt
% and fluoxt.txt

function SparkAnalysis()
    global  total_time stable_time Tgap Tmax Xgap Xmax SparkThreshold
    
    total_time = 11000; 
    stable_time = 4001;
    Tgap = 20; % minimum total_time between sparks (half peak is the spark boundary)
    Tmax = 600; % big enogh to contain a spark.
    Xgap = 2; % minimum space between sparks 
    Xmax = 20; % big enough to contain a spark
    SparkThreshold = 2000;

    [spark_avg, nonspark_avg, total_spark, total_nonspark, nonspark_I] = linescan();
    [spark_profile, spark_location] = SparkProfile();

    % calculate spark rate from fluorescence
    [N,x,idx]=histcounts(spark_location,'BinWidth',500); % group data for each 500 ms
    sparkrate_fluo = mean(N/1.091/3*2);
    dsparkrate_fluo = std(N/1.091/3*2);

    % output histograms
    [N1,edge1]=histcounts(spark_profile(:,1)); % F/F0
    [N2,edge2]=histcounts(spark_profile(:,2), 'BinWidth', 0.2); % FWHM
    [N3,edge3]=histcounts(spark_profile(:,3)); % FDHM
    center1 = edge1(1:(end-1))+0.5*(edge1(2)-edge1(1));
    center2 = edge2(1:(end-1))+0.5*(edge2(2)-edge2(1));
    center3 = edge3(1:(end-1))+0.5*(edge3(2)-edge3(1));
    dlmwrite('spark_ci0.1_FF0.txt', [center1', N1'], 'delimiter', '\t');
    dlmwrite('spark_ci0.1_FWHM.txt', [center2', N2'], 'delimiter', '\t');
    dlmwrite('spark_ci0.1_FDHM.txt', [center3', N3'], 'delimiter', '\t');

    sparkrate = total_spark/(total_time-Tmax)*1000;
    nonsparkrate = total_nonspark/(total_time-Tmax)*1000;
    
    % spark_avg: 1:I, 2:cjsr, 3:cp, 4:nou, 5:nob, 6:ncu, 7:ncb, 8:std I, 9:ci, 10:std ci, 11:std cjsr, 12:std cp, 13:std N_open, 14:CaDye, 15:CaATP
    dlmwrite('spark_ci0.1.txt', [(1:Tmax).' spark_avg], 'delimiter', '\t');

    data = dlmread('ci0.1/wholecell.txt');
    ci = mean(data(stable_time:(total_time-Tmax),2));
    cj = mean(data(stable_time:(total_time-Tmax),5));
    peak_ci = max(spark_avg(:,9));
    
    temp = [numel(spark_location) sparkrate_fluo dsparkrate_fluo mean(spark_profile(:,1)) std(spark_profile(:,1))...
        mean(spark_profile(:,2)) std(spark_profile(:,2)) mean(spark_profile(:,3)) std(spark_profile(:,3)) ];
    dlmwrite('spark_statistics_0.1.txt', temp, 'delimiter', '\t');
    dlmwrite('spark_profile_0.1.txt', spark_profile, 'delimiter', '\t');

    range = 60;
    figure(1);
        subplot(3,3,1)
            plot(1:range,spark_avg(1:range,1),'-o');
            xlabel('Time (ms)');
            title('I_{rel} (pA)');
        subplot(3,3,4)
            plot(1:200, spark_avg(1:200,2), '-o');
            xlabel('Time (ms)');
            title('[Ca^{2+}]_{JSR} (\muM)');
        subplot(3,3,2)
            plot(1:range, spark_avg(1:range,4), '-o');
            xlabel('Time (ms)');
            title('nou');
        subplot(3,3,3)
            plot(1:range, spark_avg(1:range,5), '-o');
            xlabel('Time (ms)');
            title('nob');
        subplot(3,3,5)
            plot(1:200, spark_avg(1:200,3), '-o');
            xlabel('Time (ms)');
            title('c_p');
        subplot(3,3,6)
            plot(1:200, spark_avg(1:200,7), '-o');
            xlabel('Time (ms)');
            title('ncb');

        subplot(3,3,7);
            histogram(spark_profile(:,1), 30);
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
        s1=sprintf('Time range:\n%d ms\n',total_time-Tmax-stable_time);
        s2=sprintf('\n\nSpark rate:\n%.1f/s\n',sparkrate);
        s3=sprintf('\n\nAvg c_i:\n%.2f uM\n',ci);
        s4=sprintf('\n\nPeak c_i:\n%.2f uM\n',peak_ci);
        s5=sprintf('\n\nAvg c_j:\n%.0f uM\n',cj);
        s6=sprintf('\n\nc_p before\nsparks:\n%.2f uM\n',spark_avg(10,3));
        s7=sprintf('\n\nc_j before\nsparks:\n%.0f uM\n',spark_avg(10,2));
        s8=sprintf('\n\nSpark rate\n(fluo):\n%.1f/s\n',sparkrate_fluo);
        str = strcat(s1,s2,s3,s4,s5,s6,s7,s8);
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'EdgeColor','none','FontSize',9);
        
        set(findobj('type','axes'),'FontSize',11);
        set(gcf, 'PaperPosition', [0.2 0 10 8]);
        set(gcf, 'PaperSize', [10 8]);
        saveas(gcf, 'SparkAnalysis_ci0.1.pdf', 'pdf');

        clf(1);

    if total_nonspark > 0 
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
                ylabel('b');
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
            saveas(gcf, 'SparkAnalysis_nonSpark_ci0.1.pdf', 'pdf');

            clf(1);
    else
        fprintf('\nThere is no non-spark release.\n\n');
    end
end

function [spark_avg, nonspark_avg, total_spark, total_nonspark, nonspark_I] = linescan()

    global  stable_time total_time Tgap Tmax SparkThreshold
    
    data = dlmread('ci0.1/linescan.txt');
    num_CRU = 62;
    linescan = zeros(num_CRU, 20, total_time);
    for t=1:total_time
        linescan(:,:,t) = data( ( (t-1)*num_CRU+1 ):( t*num_CRU ), :);
    end
    
    % Tmax:maximum open time, 5000: maximum number of releases
    spark = zeros(Tmax, 5000, 10); % 1:I, 2:cjsr, 3:cp, 4:nou, 5:nob, 6:ncu, 7:ncb, 8:CaDye, 9:CaATP
    nonspark = zeros(Tmax, 5000, 10);
    nonspark_I = zeros(5000,2); % 1:peak, 2:duration

    num_spark = 1; % number of sparks
    num_nonspark = 1; % number of non-sparks
    for i=1:num_CRU
        current_binary = reshape(linescan(i, 8, stable_time:(total_time-Tmax)),[],1);
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
                    spark(:,num_spark,8) = linescan(i,3,temp_start:(temp_start+Tmax-1)); % ci
                    spark(:,num_spark,9) = linescan(i,19,temp_start:(temp_start+Tmax-1)); % CaDye
                    spark(:,num_spark,10)= linescan(i,20,temp_start:(temp_start+Tmax-1)); % CaATP

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
                    nonspark(:,num_nonspark, 8) = linescan(i,3,temp_start:(temp_start+Tmax-1));
                    nonspark(:,num_nonspark, 9) = linescan(i,19,temp_start:(temp_start+Tmax-1));
                    nonspark(:,num_nonspark, 10)= linescan(i,20,temp_start:(temp_start+Tmax-1));

                    nonspark_I(num_nonspark,1) = max(nonspark(1:current_end, num_nonspark, 1)); % peak current of non-spark
                    nonspark_I(num_nonspark,2) = spark_end(k) - spark_start(k) + 1; % duration of non-spark current

                    num_nonspark = num_nonspark+1;

                end

            end
        end
    end

    spark_avg = zeros(Tmax,15);
    spark_avg(:,1) = mean(spark(:,1:(num_spark-1),1), 2); % I
    spark_avg(:,2) = mean(spark(:,1:(num_spark-1),2), 2); % cjsr
    spark_avg(:,3) = mean(spark(:,1:(num_spark-1),3), 2); % cp
    spark_avg(:,4) = mean(spark(:,1:(num_spark-1),4), 2); % nou
    spark_avg(:,5) = mean(spark(:,1:(num_spark-1),5), 2); % nob
    spark_avg(:,6) = mean(spark(:,1:(num_spark-1),6), 2); % ncu
    spark_avg(:,7) = mean(spark(:,1:(num_spark-1),7), 2); % ncb
    spark_avg(:,8) = std(spark(:,1:(num_spark-1),1), [], 2); % d I
    spark_avg(:,9) = mean(spark(:,1:(num_spark-1),8), 2); % ci
    spark_avg(:,10) = std(spark(:,1:(num_spark-1),8), [], 2); % d ci
    spark_avg(:,11) = std(spark(:,1:(num_spark-1),2), [], 2); % d cjsr
    spark_avg(:,12) = std(spark(:,1:(num_spark-1),3), [], 2); % d cp
    spark_avg(:,13) = sqrt( std(spark(:,1:(num_spark-1),4), [], 2).^2 ...
                            + std(spark(:,1:(num_spark-1),5), [], 2).^2 ); % d N_open
    spark_avg(:,14) = mean(spark(:,1:(num_spark-1),9), 2); % CaDye
    spark_avg(:,15) = mean(spark(:,1:(num_spark-1),10),2); % CaATP

    total_spark = num_spark - 1;

    nonspark_avg = zeros(Tmax,9);
    nonspark_avg(:,1) = mean(nonspark(:,1:(num_nonspark-1),1), 2);
    nonspark_avg(:,2) = mean(nonspark(:,1:(num_nonspark-1),2), 2);
    nonspark_avg(:,3) = mean(nonspark(:,1:(num_nonspark-1),3), 2);
    nonspark_avg(:,4) = mean(nonspark(:,1:(num_nonspark-1),4), 2);
    nonspark_avg(:,5) = mean(nonspark(:,1:(num_nonspark-1),5), 2);
    nonspark_avg(:,6) = mean(nonspark(:,1:(num_nonspark-1),6), 2);
    nonspark_avg(:,7) = mean(nonspark(:,1:(num_nonspark-1),7), 2);
    nonspark_avg(:,8) = std(nonspark(:,1:(num_nonspark-1),1), [], 2);
    nonspark_avg(:,9) = mean(nonspark(:,1:(num_nonspark-1),8), 2);
    total_nonspark = num_nonspark - 1;
end

function [spark_profile, spark_location] = SparkProfile()
    global  total_time stable_time Tgap Tmax Xgap Xmax 
    
    FluoSizeX = 128;
    fluo_basal = 4.2;
    fluo_threshold = fluo_basal*1.5;

    fluoxt = dlmread('ci0.1/fluoxt.txt');
    fluo = zeros(total_time+Tmax*2, FluoSizeX+Xmax, 7); %It is larger because of boudary.
    for t = 1:total_time
        fluo(t+Tmax/2, (Xmax/2+1):(FluoSizeX+Xmax/2), :) = ...
                            fluoxt( ( (t-1)*FluoSizeX+1 ):( t*FluoSizeX ), :);
    end


    % find the spark peaks
    mask = ones(200, 10);
    mask(100, 5) = 0;
    num_spark = 1;
    peak = zeros(5000,1);

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
    peak(num_spark:end,:) = [];
    spark_location = peak(:,1);

    % get the spark profile
    spark_profile = zeros(num_spark-1,4); % FWHM, FDHM, F/F_0
    spark_time_trace = zeros(Tmax+1, num_spark-1);
    for ii = 1:(num_spark-1)

        % F/F_0
        spark_profile(ii, 1) = peak(ii,4)/fluo_basal;

        % FWHM
        spark_x = fluo( peak(ii,1), (peak(ii,2)-Xmax/2):(peak(ii,2)+Xmax/2), ...
                        peak(ii,3) );
        [spark_profile(ii, 2), temp]=EachSparkSize(spark_x, Xmax/2+1, fluo_basal, Xgap);

        % FDHM
        spark_time = fluo( (peak(ii,1)-Tmax/2):(peak(ii,1)+Tmax/2), ...
                            peak(ii,2), peak(ii,3) );
        [spark_profile(ii, 3), spark_profile(ii, 4)] = ...
            EachSparkSize(spark_time, Tmax/2+1, fluo_basal,Tgap);
        
        spark_time_trace(:,ii) = fluo( (peak(ii,1)-Tmax/2+spark_profile(ii, 4)-10):(peak(ii,1)+Tmax/2+spark_profile(ii, 4)-10), ...
                            peak(ii,2), peak(ii,3) );
    end
    
    total_spark = num_spark - 1;
    dlmwrite('spark_ci0.1_time.txt', [(1:(Tmax+1)).' spark_time_trace], 'delimiter', '\t');
end

% The following function is to detect the start and end of a spark.
% Input: 
%   Array
%   peak_pos: position of the spark maximum
%   basal: basal of the original array
%   min_gap: minimum number of 0 between two sparks of 1
% Output:
%   FWHM: full width at half maximum

function [FWHM, time_start] = EachSparkSize(Array, peak_pos, basal, min_gap)
    
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

    time_start = spark_start;
    spark_start = spark_start - 1 + (Half_Peak-Array(spark_start-1))/...
                                (Array(spark_start)-Array(spark_start-1));
                            
    spark_end = spark_end + (Half_Peak-Array(spark_end))/...
                        (Array(spark_end+1)-Array(spark_end));
                    
    FWHM = spark_end - spark_start;
    
end
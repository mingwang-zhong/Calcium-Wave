% This code is to calculate the spark properties using linescan.txt

function SparkAnalysis()
    global  total_time stable_time Tgap Tmax Xgap Xmax SparkThreshold
    
    total_time = 25000; 
    stable_time = 15001;
    Tgap = 50; % minimum total_time between sparks (half peak is the spark boundary)
    Tmax = 400; % big enogh to contain a spark.
    Xgap = 2; % minimum space between sparks 
    Xmax = 20; % big enough to contain a spark
    SparkThreshold = 2000;

    [spark_avg, nonspark_avg, total_spark, total_nonspark, nonspark_I] = linescan();

    [total_spark total_nonspark]
    sparkrate = total_spark/(total_time-Tmax-stable_time)*1000;
    nonsparkrate = total_nonspark/(total_time-Tmax-stable_time)*1000;

    dlmwrite('spark_ci0.3.txt', [(1:Tmax).' spark_avg], 'delimiter', '\t');
    dlmwrite('I_release_ci0.3.txt', nonspark_I(1:total_nonspark,1), 'delimiter', '\t');

    data = dlmread('ci0.3/wholecell.txt');
    ci = mean(data(stable_time:(total_time-Tmax),2));
    cj = mean(data(stable_time:(total_time-Tmax),5));
    
    range = 60;
    figure(1);
        subplot(3,3,1)
            plot(1:range,spark_avg(1:range,1),'-o');
            xlabel('Time (ms)');
            title('I_{rel} (pA)');
        subplot(3,3,4)
            plot(1:Tmax, spark_avg(:,2), '-o');
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
            plot(1:Tmax, spark_avg(:,6), '-o');
            xlabel('Time (ms)');
            title('ncu');
        subplot(3,3,6)
            plot(1:Tmax, spark_avg(:,7), '-o');
            xlabel('Time (ms)');
            title('ncb');
        
        dim = [.19 .61 .3 .3];
        str={'Mean current over',sprintf('20 ms: %.2f pA', sum(spark_avg(:,1))/20)};
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'FontSize', 12, 'EdgeColor','none');
        
        dim = [0 .41 .3 .3];
        s1=sprintf('Time range:\n%d ms\n',total_time-Tmax-stable_time);
        s2=sprintf('\n\nSpark rate:\n%.1f/s\n',sparkrate);
        s3=sprintf('\n\nAvg c_i:\n%.2f uM\n',ci);
        s4=sprintf('\n\nAvg c_j:\n%.0f uM\n',cj);
        s5=sprintf('\n\nc_p before\nsparks:\n%.2f uM\n',spark_avg(10,3));
        s6=sprintf('\n\nc_j before\nsparks:\n%.0f uM\n',spark_avg(10,2));
        str = strcat(s1,s2,s3,s4,s5,s6);
        annotation('textbox', dim,'String', str, 'FitBoxToText','on',...
            'EdgeColor','none','FontSize',9);
        
        set(findobj('type','axes'),'FontSize',11);
        set(gcf, 'PaperPosition', [0.2 0 10 8]);
        set(gcf, 'PaperSize', [10 8]);
        saveas(gcf, 'SparkAnalysis_ci0.3.pdf', 'pdf');

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
                histogram(nonspark_I(1:total_nonspark,1), 30);
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
            saveas(gcf, 'SparkAnalysis_nonSpark_ci0.3.pdf', 'pdf');

            clf(1);
    else
        fprintf('\nThere is no non-spark release.\n\n');
    end
end

function [spark_avg, nonspark_avg, total_spark, total_nonspark, nonspark_I] = linescan()

    global  stable_time total_time Tgap Tmax SparkThreshold
    
    data = dlmread('ci0.3/linescan.txt');
    num_CRU = 62;
    linescan = zeros(num_CRU, 31, total_time);
    for t=1:total_time
        linescan(:,:,t) = data( ( (t-1)*num_CRU+1 ):( t*num_CRU ), :);
    end
    
    % Tmax:maximum open time, 5000: maximum number of releases
    spark = zeros(Tmax, 5000, 10); % 1:I, 2:cjsr, 3:cp, 4:nou, 5:nob, 6:ncu, 7:ncb
    nonspark = zeros(Tmax, 5000, 8);
    nonspark_I = zeros(5000,2); % 1:peak, 2:duration

    num_spark = 1; % number of sparks
    num_nonspark = 1; % number of non-sparks

    position = [11 18 25]; % three set of ( cp, cj, Jrel, nou, nob, ncu, ncb )
    for index = 1:3
        for i=1:num_CRU
            current_binary = reshape(linescan(i, position(index)+2, stable_time:(total_time-Tmax)),[],1);
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

                    if any( linescan(i, position(index)+2, temp_start:(temp_start+current_end-1)) > SparkThreshold )...
                        && linescan(i,position(index)+1,temp_start+10) >700 

                        spark(1:current_end, num_spark,1) = ...
                            linescan(i, position(index)+2, temp_start:(temp_start+current_end-1))/100.0*2.0*9.648533*0.00126;
                        spark(:,num_spark,2) = linescan(i,position(index)+1,temp_start:(temp_start+Tmax-1)); % cjsr
                        spark(:,num_spark,3) = linescan(i,position(index)+0,temp_start:(temp_start+Tmax-1)); % cp
                        spark(:,num_spark,4) = linescan(i,position(index)+3,temp_start:(temp_start+Tmax-1)); % nou
                        spark(:,num_spark,5) = linescan(i,position(index)+4,temp_start:(temp_start+Tmax-1)); % nob
                        spark(:,num_spark,6) = linescan(i,position(index)+5,temp_start:(temp_start+Tmax-1)); % ncu
                        spark(:,num_spark,7) = linescan(i,position(index)+6,temp_start:(temp_start+Tmax-1)); % ncb
                        spark(:,num_spark,8) = temp_start + 9;
                        spark(:,num_spark,9) = position(index);
                        spark(:,num_spark,10) = i;

                        num_spark = num_spark + 1;

                    elseif all( linescan(i, position(index)+2, temp_start:(temp_start+current_end-1)) < SparkThreshold )...
                        && linescan(i,position(index)+1,temp_start+10) <700 

                        nonspark(1:current_end, num_nonspark, 1) = ...
                            linescan(i, position(index)+2, temp_start:(temp_start+current_end-1))/100.0*2.0*9.648533*0.00126;
                        nonspark(:,num_nonspark, 2) = linescan(i,position(index)+1,temp_start:(temp_start+Tmax-1));
                        nonspark(:,num_nonspark, 3) = linescan(i,position(index)+0,temp_start:(temp_start+Tmax-1));
                        nonspark(:,num_nonspark, 4) = linescan(i,position(index)+3,temp_start:(temp_start+Tmax-1));
                        nonspark(:,num_nonspark, 5) = linescan(i,position(index)+4,temp_start:(temp_start+Tmax-1));
                        nonspark(:,num_nonspark, 6) = linescan(i,position(index)+5,temp_start:(temp_start+Tmax-1));
                        nonspark(:,num_nonspark, 7) = linescan(i,position(index)+6,temp_start:(temp_start+Tmax-1));

                        nonspark_I(num_nonspark,1) = max(nonspark(1:current_end, num_nonspark, 1)); % peak current of non-spark
                        nonspark_I(num_nonspark,2) = spark_end(k) - spark_start(k) + 1; % duration of non-spark current

                        num_nonspark = num_nonspark+1;

                    end

                end
            end
        end
    end
    
    spark_avg = zeros(Tmax,8); % 8: error of I
    spark_avg(:,1) = mean(spark(:,1:(num_spark-1),1), 2);
    spark_avg(:,2) = mean(spark(:,1:(num_spark-1),2), 2);
    spark_avg(:,3) = mean(spark(:,1:(num_spark-1),3), 2);
    spark_avg(:,4) = mean(spark(:,1:(num_spark-1),4), 2);
    spark_avg(:,5) = mean(spark(:,1:(num_spark-1),5), 2);
    spark_avg(:,6) = mean(spark(:,1:(num_spark-1),6), 2);
    spark_avg(:,7) = mean(spark(:,1:(num_spark-1),7), 2);
    spark_avg(:,8) = std(spark(:,1:(num_spark-1),1), [], 2);
    total_spark = num_spark - 1;

    nonspark_avg = zeros(Tmax,8);
    nonspark_avg(:,1) = mean(nonspark(:,1:(num_nonspark-1),1), 2);
    nonspark_avg(:,2) = mean(nonspark(:,1:(num_nonspark-1),2), 2);
    nonspark_avg(:,3) = mean(nonspark(:,1:(num_nonspark-1),3), 2);
    nonspark_avg(:,4) = mean(nonspark(:,1:(num_nonspark-1),4), 2);
    nonspark_avg(:,5) = mean(nonspark(:,1:(num_nonspark-1),5), 2);
    nonspark_avg(:,6) = mean(nonspark(:,1:(num_nonspark-1),6), 2);
    nonspark_avg(:,7) = mean(nonspark(:,1:(num_nonspark-1),7), 2);
    nonspark_avg(:,8) = std(nonspark(:,1:(num_nonspark-1),1), [], 2);
    total_nonspark = num_nonspark - 1;

    figure(2);
    subplot(2,2,1);
        histogram(spark(10,1:(num_spark-1),3),50);
        xlabel('c_p (\mu M)');
        xlim([0 2]);
    subplot(2,2,2);
        histogram(spark(10,1:(num_spark-1),2),50);
        xlabel('c_j (\mu M)');
        xlim([700 950]);
    subplot(2,2,3);
        histogram(spark(10,1:(num_spark-1),6),30);
        xlabel('NCU');
    subplot(2,2,4);
        histogram(spark(10,1:(num_spark-1),7),30);
        xlabel('NCB');

    dlmwrite('ci0.3_before_spark.txt', reshape(spark(10,1:(num_spark-1),2:10), [num_spark-1 9] ), 'delimiter', '\t');

    set(findobj('type','axes'),'FontSize',11);
    set(gcf, 'PaperPosition', [0.2 0 8 6]);
    set(gcf, 'PaperSize', [8 6]);
    saveas(gcf, 'before_Spark_ci0.3.pdf', 'pdf');
end
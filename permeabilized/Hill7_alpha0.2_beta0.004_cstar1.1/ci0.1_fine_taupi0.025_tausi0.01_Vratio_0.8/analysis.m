function analysis()

    spark_profile = zeros(1,3);
    
    data = dlmread('fluoxt.txt');

    num_time = size(data,1)/80;

    fluoxt = zeros(num_time,80);
    for i=1:80
        fluoxt(:,i) = data( i:80:(num_time*80-80+i) ,3);
    end
    basal = mean(fluoxt(:,1))

    peak = max(max(fluoxt));
    [j i] = find(fluoxt==peak,1);

    spark_profile(1) = peak/basal;

    array = fluoxt(j, :);
    spark_profile(2) = EachSparkSize(array, i, basal, 5)*0.165;

    array = fluoxt(:, i);
    spark_profile(3) = EachSparkSize(array, j, basal, 5);


    dlmwrite('profile.txt', spark_profile, 'delimiter', '\t');

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
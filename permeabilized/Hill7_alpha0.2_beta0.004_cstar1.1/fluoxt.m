
ci=[0.1 0.15 0.2 0.3];

for i=1:4
    data = dlmread(sprintf('ci%g/fluoxt.txt',ci(i)));

    num_time = size(data,1)/128;
	fluo = zeros(num_time,129);
    for j=1:128
        fluo(:,j+1) = data( j:128:(num_time*128-128+j) ,3);
    end
    fluo(:,1) = data( j:128:(num_time*128-128+j) ,1);

    dlmwrite(sprintf('ci%g/fluoxt2.txt',ci(i)), fluo, 'delimiter', '\t');
end

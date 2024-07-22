cj = [400:20:1000];
NN = size(cj,2);
result = zeros(NN,5);

BCSQN=460;
nCa=31;
Kc=600;

for i=1:NN
	data = dlmread(sprintf('cj%d/wholecell.txt',cj(i)));
	result(i,1) = data(700,5);
	result(i,2) = sum(data(700:900,9))/0.0965/0.00126/2*45/(62*26*10); % JCa
	result(i,3) = sum(data(700:900,20)); % Jrel
	result(i,4) = (data(700,5) + BCSQN*nCa*data(700,5)/(Kc+data(700,5)))*0.03/0.00126; % initial total amount of Ca2+ in SR
	result(i,5) = data(700,5) - min(data(700:900,5)); % SR load depletion
end

dlmwrite('result.txt', result, 'delimiter', '\t');

figure(1);
clf(1);
	subplot(2,2,1);
	plot(result(:,1), -result(:,3)./result(:,2), '-s');
	xlabel('$c_j (\mu M)$', 'Interpreter', 'LaTex');
	title('Gain');
	xlim([min(cj) max(cj)]);
	ylim([0 40]);

	subplot(2,2,2);
	plot(result(:,1), result(:,3)./result(:,4), '-s');
	xlabel('$c_j (\mu M)$', 'Interpreter', 'LaTex');
	title('Fractional release');
	xlim([min(cj) max(cj)]);
	ylim([0 1]);

	subplot(2,2,4);
	plot(result(:,1), result(:,5)./result(:,1) , '-s');
	% plot(cj, result(:,3)*0.00126/0.03, '-s');
	xlabel('$c_j (\mu M)$', 'Interpreter', 'LaTex');
	title('Fractional release');
	xlim([min(cj) max(cj)]);
	ylim([0 0.6]);


set(findobj('type','axes'),'FontSize',12);
set(gcf, 'PaperPosition', [0 0 10 8]);
set(gcf, 'PaperSize', [10 8]);
saveas(gcf, 'gain.pdf', 'pdf');
result = zeros(21,3);
Vm = -40:5:60;

for i=1:21
	data = dlmread(sprintf('Vm%d/wholecell.txt',Vm(i)));
	result(i,1) = Vm(i);
	result(i,2) = min(data(90:150,9));
	result(i,3) = max(data(90:150,20));
end

result(:,2)=result(:,2)/min(result(:,2));
result(:,3)=result(:,3)/max(result(:,3));

dlmwrite('result.txt', result, 'delimiter', '\t');

figure(1);
clf(1);
	subplot(1,2,1);
	hold on;
	plot(Vm, result(:,2), '-o');
	plot(Vm, result(:,3), '-s');
	hold off;
	xlabel('V_m (mV)');
	legend('I_{Ca,L}','I_{rel}')

	subplot(1,2,2);
	plot(Vm, result(:,3)./result(:,2), '-s');
	xlabel('V_m (mV)');
	title('Gain');


set(findobj('type','axes'),'FontSize',12);
set(gcf, 'PaperPosition', [0 0 10 4]);
set(gcf, 'PaperSize', [10 4]);
saveas(gcf, 'bellShape.pdf', 'pdf');
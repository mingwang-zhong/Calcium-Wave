data = dlmread("linescan.txt");

num_time = size(data,1)/124;
fluo = zeros(num_time,124);
for j=1:124
    fluo(:,j) = data( j:124:(num_time*124-124+j) ,3);
end

% clf(1);
figure(1);
surfl(fluo(9400:9700,:), 'light');
lightangle(-40,-0);
xticks([24.2424, 36.3636, 48.4848]);
xticklabels({'20','30','40'});
xlim([20 50]);
% ylim([10 50]);
ylim([-100 400]);
zlim([0 2.]);
set(gca,'Xdir','reverse');
shading interp;
set(gca, 'CameraPosition', [-50 20 10]);
caxis([0 1.5]);
grid off;

set(findobj('type','axes'),'FontSize',12);
set(gcf, 'PaperPosition', [0 0 10 4.6]); 
set(gcf, 'PaperSize', [10 4.6]); 
saveas(gcf, 'image', 'png');
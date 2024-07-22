data = dlmread("linescan.txt");

num_time = size(data,1)/124;
fluo = zeros(num_time,124);
for j=1:124
    fluo(:,j) = data( j:124:(num_time*124-124+j) ,3);
end

% clf(1);
figure(1);
surfl(fluo(9000:10000,:), 'light');
lightangle(-40,-0);
xticks([0,24.2424, 48.4848, 72.7273, 96.9697, 121.2121]);
xticklabels({'0','20','40','60', '80','100'});
xlim([-10 135]);
ylim([-50 1050]);
% ylim([-100 400]);
zlim([0 4.]);
set(gca,'Xdir','reverse');
shading interp;
set(gca, 'CameraPosition', [-50 400 10]);
caxis([0 2.5]);
grid off;

set(findobj('type','axes'),'FontSize',12);
set(gcf, 'PaperPosition', [0 0 10 4.6]); 
set(gcf, 'PaperSize', [10 4.6]); 
saveas(gcf, 'image', 'png');
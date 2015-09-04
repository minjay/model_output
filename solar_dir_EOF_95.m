load('labels.mat')

load('svd.mat')

r = double(r);

direction = {'W', 'SW', 'S', 'SE', 'E', 'NE', 'N', 'NW'};
loc_x = [0.15 0.25 0.4 0.55 0.65 0.55 0.4 0.25];
loc_y = [0.4 0.2 0.05 0.2 0.4 0.6 0.75 0.6];

quiver(-1, 0, 2, 0, 0, 'LineWidth', 2, 'color', 'k') 
axis off
axis equal
hold on
quiver(0, -1, 0, 2, 0, 'LineWidth', 2, 'color', 'k')

for i = 1:8
    index = strcmp(labels, direction(i));
    mean_dir = mean(r(index(1:720), :), 1);
    axes('position', [loc_x(i) loc_y(i) 0.25 0.25])
    plot_pot_lite(reshape(mean_dir, size(phi)), phi, theta, 1000)
end
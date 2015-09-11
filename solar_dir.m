load('labels.mat')

load('WHI_quad.mat')

all_Pot_N = all_Pot_N(1:720);

L = 18;
M = 3;

all_resid = zeros(720, numel(theta));

for t = 1:720
    [~, resid, ~, ~] = SCHA_regr(all_Pot_N{t}, theta, phi, L, M);
    all_resid(t, :) = resid;
end

direction = {'W', 'SW', 'S', 'SE', 'E', 'NE', 'N', 'NW'};
loc_x = [0    0 0.3 0.6 0.6  0.6 0.3 0];
loc_y = [0.35 0 0   0   0.35 0.7 0.7 0.7];

max_caxis = 0;
for i = 1:8
    index = strcmp(labels, direction(i));
    mean_dir = mean(all_resid(index(1:720), :), 1);
    max_caxis = max([abs(mean_dir), max_caxis]);
end

for i = 1:8
    subplot('position', [loc_x(i) loc_y(i) 0.25 0.3])
    index = strcmp(labels, direction(i));
    mean_dir = mean(all_resid(index(1:720), :), 1);
    plot_pot_lite(reshape(mean_dir, size(phi)), phi, theta, 1000, max_caxis)
end
subplot('position', [0.3 0.35, 0.25 0.3])
quiver(-1, 0, 2, 0, 0, 'LineWidth', 2, 'color', 'k') 
axis off
axis equal
hold on
quiver(0, -1, 0, 2, 0, 'LineWidth', 2, 'color', 'k')

colorbar('Position', [0.9 0.05 0.05 0.9])
colormap(b2r(-max_caxis, max_caxis))

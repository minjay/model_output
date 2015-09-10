direction = {'W', 'SW', 'S', 'SE', 'E', 'NE', 'N', 'NW'};

for i = 1:8
    figure
    suptitle(direction{i})
    for j = 1:size(V_L_all{i}, 2)
        subplot(2, 2, j)
        plot_pot(reshape(V_L_all{i}(:, j), size(phi)), phi, theta, 1000)
    end
    print(['./', 'EOF', direction{i}], '-dpng')
end
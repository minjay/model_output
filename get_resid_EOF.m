load('svd.mat')
load('theta_phi.mat')

% plot mean
plot_pot(reshape(mean_map, size(phi)), phi, theta, 1000)

% plot EOFs
n_EOF = size(V_L, 2);
for i = 1:n_EOF
    figure
    plot_pot(reshape(double(V_L(:, i)), size(phi)), phi, theta, 1000)
end

% plot time series
for i = 1:n_EOF
    subplot(4, 1, i)
    plot(T_L(:, i))
    axis tight
end

for i = 1:720
    subplot('Position', [0 0 1 1])
    title(['Residual, time point ', num2str(i)])
    plot_pot(reshape(double(r(i, :)), size(phi)), phi, theta, 1000)
    print(['./plots2/', 'fig', num2str(i)], '-dpng')
end
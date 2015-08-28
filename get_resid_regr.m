% get residuals by spherical harmonic regression

load('WHI_quad.mat')

all_Pot_N = all_Pot_N(1:720);
n = length(all_Pot_N);

X = zeros(n, numel(theta));
for i = 1:n
    X(i, :) = all_Pot_N{i}(:);
end

clear all_Pot_N

L = 8;
M = 3;

for t = 1:720
    [coef, res, yhat] = SCHA_regr(reshape(X(t, :), size(phi)), theta, phi, L, M);
    subplot('position', [0, 0.5 0.45 0.45])
    title(['True, time point ', num2str(t)])
    plot_pot(reshape(X(t, :), size(phi)), phi, theta, 1000)
    subplot('position', [0.5, 0.5 0.45 0.45])
    title('Fitted')
    plot_pot(reshape(yhat, size(phi)), phi, theta, 1000)
    subplot('position', [0, 0 0.45 0.45])
    title('Residual')
    plot_pot(reshape(res, size(phi)), phi, theta, 1000)
    
    print(['./plots/', 'fig', num2str(t)], '-dpng') 
end

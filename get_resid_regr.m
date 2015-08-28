% get residuals by spherical harmonic regression

load('WHI_quad.mat')

all_Pot_N = all_Pot_N(1:720);

L = 8;
M = 3;

for t = 1:720
    [coef, resid, y_hat] = SCHA_regr(all_Pot_N{t}, theta, phi, L, M);
    subplot('position', [0, 0.5 0.45 0.45])
    title(['True, time point ', num2str(t)])
    plot_pot(all_Pot_N{t}, phi, theta, 1000)
    subplot('position', [0.5, 0.5 0.45 0.45])
    title('Fitted')
    plot_pot(reshape(y_hat, size(phi)), phi, theta, 1000)
    subplot('position', [0, 0 0.45 0.45])
    title('Residual')
    plot_pot(reshape(resid, size(phi)), phi, theta, 1000)
    
    print(['./plots/', 'fig', num2str(t)], '-dpng') 
end

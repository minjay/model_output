load('WHI_quad.mat')

all_Pot_N = all_Pot_N(1:720);

n = length(all_Pot_N);

% design matrix
X = zeros(n, numel(theta));
for i = 1:n
    X(i, :) = all_Pot_N{i}(:);
end

L = 8;
M = 3;

[~, ~, ~, X2] = SCHA_regr(all_Pot_N{1}, theta, phi, L, M);
Var_y = X'*X;
percent = trace(X2*((X2'*X2)\(X2'))*X'*X)/trace(Var_y);

percent

mean_map = mean(X, 1);

for i = 1:n
    X(i, :) = X(i, :)-mean_map;
end

[U, S, V] = svd(X, 'econ');

lambda = diag(S).^2;
var_exp = cumsum(lambda)./sum(lambda);
thres = find(var_exp>=percent, 1, 'first');

% compute the residual fields
V_L = V(:, 1:thres);
T_L = X*V_L;
X_L = T_L*V_L';
r = X-X_L;

for t = 1:720
    subplot('position', [0 0.25 0.5 0.5])
    title(['Residual (EOF), time point ', num2str(t)])
    plot_pot(reshape(r(t, :), size(phi)), phi, theta, 1000)
    [~, resid, ~, ~] = SCHA_regr(all_Pot_N{t}, theta, phi, L, M);
    subplot('position', [0.5 0.25 0.5 0.5])
    title('Residual (regr)')
    plot_pot(reshape(resid, size(phi)), phi, theta, 1000)
    
    print(['./plots3/', 'fig', num2str(t)], '-dpng') 
end

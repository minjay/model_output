load('labels.mat')

load('WHI_quad.mat')

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
    mean_dir = mean(r(index, :), 1);
    axes('position', [loc_x(i) loc_y(i) 0.25 0.25])
    plot_pot_lite(reshape(mean_dir, size(phi)), phi, theta, 1000)
end
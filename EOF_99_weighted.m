% run on server

load('WHI_quad.mat')

n = length(all_Pot_N);

% design matrix
X = zeros(n, numel(theta));
for i = 1:n
    X(i, :) = all_Pot_N{i}(:);
end

clear all_Pot_N

mean_map = mean(X, 1);

for i = 1:n
    X(i, :) = X(i, :)-mean_map;
end

[U, S, V] = svd(X, 'econ');

U = single(U);
V = single(V);

% find the 99% threshold
lambda = diag(S).^2;
var_exp = cumsum(lambda)./sum(lambda);
thres = find(var_exp>=0.99, 1, 'first');

% compute the residual fields
V_L = V(:, 1:thres);
T_L = X*V_L;
X_L = T_L*V_L';
r = X-X_L;

save('/home/minjay/svd.mat', 'V_L', 'r', 'T_L', 'mean_map')

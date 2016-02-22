% run on server

load('WHI_double.mat')

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

% find the 95% threshold
lambda = diag(S).^2;

save('/home/minjay/svd_double.mat', 'lambda')

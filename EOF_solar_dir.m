% run on server

load('WHI_quad.mat')

load('labels.mat')

direction = {'W', 'SW', 'S', 'SE', 'E', 'NE', 'N', 'NW'};

V_L_all = cell(8, 1);

for i = 1:8
    index = find(strcmp(labels, direction(i))==1);
    n = length(index);
    X = zeros(n, numel(theta));
    for j = 1:n
        X(j, :) = all_Pot_N{index(j)}(:);
    end
    
    [U, S, V] = svd(X, 'econ');
    
    % find the 95% threshold
    lambda = diag(S).^2;
    var_exp = cumsum(lambda)./sum(lambda);
    thres = find(var_exp>=0.95, 1, 'first');
    
    V_L_all{i} = V(:, 1:thres);
end

save('/home/minjay/svd_all.mat', 'V_L_all')

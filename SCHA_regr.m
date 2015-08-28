function [coef, resid, y_hat] = SCHA_regr(y, theta, phi, L, M)
%SCHA_REGR   Spherical cap harmonic regression.
%
%   [coef, resid, y_hat] = SCHA_regr(y, theta, phi, L, M);
%
% Inputs:
%   y: the response, an n_phi-by-n_theta matrix
%   theta: the co-latitude, the same size as y, all the rows are
%   the same
%   phi: the longitude, the same size as y, all the columns are the
%   same
%
% Outputs:
%   coef: the estimated coefficients, a column vector
%   resid: the residuals, an (n_phi*n_theta)-by-1 vector, corresponds to y
%   ordered by column
%   y_hat: the fitted y, the same size as resid
%
% Written by Minjie Fan, 2015

[n_phi, n_theta] = size(y);
n_r = n_phi*n_theta;
% stretch
theta_vec = theta(1, :)*4;
phi_vec = phi(:, 1);

Cos = zeros(n_phi, M);
Sin = zeros(n_phi, M);
for i = 1:M
    Cos(:, i) = cos(i*phi_vec);
    Sin(:, i) = sin(i*phi_vec);
end

Plm = cell(L+1, 1);
for l = 0:L
    Plm{l+1} = legendre(l, cos(theta_vec));
end
    
n_c = L+1+(M+1)*M+M*(L-M)*2;
X = zeros(n_r, n_c);
index = 0;

% specify each column of the design matrix X
for l = 0:L
    index = index+1;
    X(:, index) = kron(Plm{l+1}(1, :)', ones(n_phi, 1));
end

for l = 1:L
    min_lM = min([l M]);
    for m = 1:min_lM
        index = index+1;
        X(:, index) = kron(Plm{l+1}(m+1, :)', Cos(:, m));
        index = index+1;
        X(:, index) = kron(Plm{l+1}(m+1, :)', Sin(:, m));
    end
end

y = y(:);
coef = (X'*X)\(X'*y);
y_hat = X*coef;
resid = y-y_hat;

end

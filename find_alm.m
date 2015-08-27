load('WHI_quad.mat')

all_Pot_N = all_Pot_N(1:720);
n = length(all_Pot_N);

% design matrix
X = zeros(n, numel(theta));
for i = 1:n
    X(i, :) = all_Pot_N{i}(:);
end

clear all_Pot_N

mean_map = mean(X, 1);
plot_pot(reshape(mean_map, size(phi)), phi, theta, 1000)

for i = 1:n
    X(i, :) = X(i, :)-mean_map;
end

bw = 180;
n = 4*bw^2;

% new grid
phi_interp_vec = 2*pi*(0:2*bw-1)/(2*bw);
theta_interp_vec = pi*(2*(0:2*bw-1)+1)/4/bw;
[theta_interp_mat, phi_interp_mat] = meshgrid(theta_interp_vec, phi_interp_vec);

% stretch to the whole sphere
theta_global = theta*4;

% regrid by interpolation
x_interp = interp2(theta_global, phi, reshape((X(1, :)), size(theta)),...
    theta_interp_mat, phi_interp_mat, 'spline', 0);

x_interp_vec = x_interp(:);

directory = '/Users/minjay/Documents/MATLAB/Needlets/S2Kit_Matlab';

alm = spharmonic_tran(x_interp_vec, bw, directory);

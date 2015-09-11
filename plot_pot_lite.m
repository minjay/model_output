function plot_pot_lite(Pot, phi, theta, res, max_caxis)

% need package b2r

phi = phi/pi*180;
theta = (pi/2-theta)/pi*180;

theta_min = min(min(theta));

lonlim = [0 360];
latlim = [theta_min 90];

phi_interp = linspace(0, 360, res);
theta_interp = linspace(90, theta_min, res/4);

[theta_interp_mat, phi_interp_mat] = meshgrid(theta_interp, phi_interp);

Pot_interp = interp2(theta, phi, Pot, theta_interp_mat, phi_interp_mat, 'spline');

worldmap(latlim, lonlim);
pcolorm(theta_interp_mat, phi_interp_mat, Pot_interp);
hold on
contourm(theta_interp_mat, phi_interp_mat, Pot_interp, 'k');
colormap(b2r(-max_caxis, max_caxis))
setm(gca, 'ParallelLabel', 'off', 'MeridianLabel', 'off')
textm(75, 300, '15\circ');
textm(60, 300, '30\circ');
textm(50, 177.5, '00')
textm(52.5, 270, '06')
textm(50, 2.5, '12')
textm(47.5, 90, '18')

end

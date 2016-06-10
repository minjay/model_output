load('svd.mat')
load('svd_quad.mat')
load('theta_phi.mat')
V_L = double(V_L);

phi_rot = phi+pi/2;
[x, y] = pol2cart(phi_rot, theta/pi*180);

figure
subplot = @(m,n,p) subtightplot (m, n, p, [0.1 0.05], [0.05 0.1], [0.1 0.05]);

n_EOF = 20;
ratio = cumsum(lambda)/sum(lambda);
sp = subplot(2, 3, 1);
plot(ratio(1:n_EOF), '-mo', 'color', 'k')
title('Scree plot')
xlabel('# of EOFs')
ylabel('Proportion of variance explained')
set(gca, 'FontSize', 12)
h = refline(0, 0.95);
h.Color = 'r';
h.LineWidth = 2;

subplot(2, 3, 2)
cf = reshape(mean_map/1e3, size(phi));
vmag = linspace(min(cf(:)), max(cf(:)), 10);
h = mypolar([0 2*pi], [0 max(theta(:))/pi*180], x, y, cf, vmag);
delete(h)
shading flat
colormap(jet)
title('Mean')
set(gca, 'FontSize', 12)
colorbar
caxis([-max(abs(cf(:))), max(abs(cf(:)))])
text(-50, -50, sprintf('Min\n%2.1f',min(cf(:))),'FontName','times','Fontsize',10)
text(30, -50, sprintf('Max\n%2.1f [kV]',max(cf(:))),'FontName','times','Fontsize',10)

for i = 1:4
    subplot(2, 3, 2+i)
    cf = reshape(V_L(:, i), size(phi));
    vmag = linspace(min(cf(:)), max(cf(:)), 10);
    h = mypolar([0 2*pi], [0 max(theta(:))/pi*180], x, y, cf, vmag);
    delete(h)
    shading flat
    colormap(jet)
    title(['EOF ', num2str(i)])
    set(gca, 'FontSize', 12)
    colorbar
    caxis([-max(abs(cf(:))), max(abs(cf(:)))])
    text(-50, -50, sprintf('Min\n%2.3f',min(cf(:))),'FontName','times','Fontsize',10)
    text(30, -50, sprintf('Max\n%2.3f [kV]',max(cf(:))),'FontName','times','Fontsize',10)
end

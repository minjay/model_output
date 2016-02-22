load('svd_single')

n_EOF = 30;

ratio = cumsum(lambda)/sum(lambda);
plot(ratio(1:n_EOF), 'b.')

load('svd_double')

hold on

ratio = cumsum(lambda)/sum(lambda);
plot(ratio(1:n_EOF), 'r.')

load('svd_quad')

ratio = cumsum(lambda)/sum(lambda);
plot(ratio(1:n_EOF), 'k.')

legend('Single', 'Double', 'Quad')

xlabel('Index')
ylabel('Variance explained')
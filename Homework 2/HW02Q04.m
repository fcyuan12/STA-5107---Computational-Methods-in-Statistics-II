rng(0);
T = [1, 0.1, 0.01, 0.001];

for i = 1:length(T)
    Q4 = RandomWalk;
    Q4.T = T(i);
    Q4.alpha = 1;
    Q4.s = Q4.alpha * sqrt(Q4.T);
    Q4.n = 10 / Q4.T;

    Q4 = Q4.fit;
    Q4.plot_path(sprintf('figure/HW02Q04_%d', i));
end    

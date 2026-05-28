rng(0);

P{1} = [0.5 0.5 0.0 0.0; 0.1 0.9 0.0 0.0; 0.0 0.0 0.3 0.7; 0.0 0.0 0.2 0.8];
P{2} = [0.0 0.5 0.0 0.5; 0.5 0.0 0.5 0.0; 0.0 0.5 0.0 0.5; 0.5 0.0 0.5 0.0];

for i = 1:length(P)
    Q4   = MarkovChain;
    Q4.P = P{i};
    Q4.T = 50;
    Q4.npath = 4;
    
    Q4 = Q4.fit;
    Q4.plot_path(sprintf('%s_%d_%s', 'figure/HW02Q04', i, 'path'))
    
    Q4 = Q4.find_freq;
    Q4.plot_freq(sprintf('%s_%d_%s', 'figure/HW02Q04', i, 'freq'))
    Q4 = Q4.compare_freq_V(sprintf('%s_%d_%s', 'figure/HW02Q04', i, 'freq_V.mat'));
end

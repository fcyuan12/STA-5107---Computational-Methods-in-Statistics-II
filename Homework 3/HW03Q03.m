rng(0);

Q3   = MarkovChain;
Q3.P = [0.2 0.2 0.1 0.5; 0.1 0.3 0.4 0.2; 0.3 0.2 0.3 0.2; 0.1 0.3 0.1 0.5];
Q3.T = 50;
Q3.npath = 4;

Q3 = Q3.fit;
Q3.plot_path('figure/HW02Q03_path')

Q3 = Q3.find_freq;
Q3.plot_freq('figure/HW02Q03_freq')
Q3 = Q3.compare_freq_V('figure/HW02Q03_freq_V.mat');

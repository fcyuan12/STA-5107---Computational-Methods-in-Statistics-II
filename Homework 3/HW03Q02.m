rng(0);

Q2   = MarkovChain;
Q2.P = [0.2 0.2 0.1 0.5; 0.1 0.3 0.4 0.2; 0.3 0.2 0.3 0.2; 0.1 0.3 0.1 0.5];
Q2.T = 10;
Q2.npath = 5;

Q2 = Q2.fit;
Q2.plot_path('figure/HW02Q02_path')

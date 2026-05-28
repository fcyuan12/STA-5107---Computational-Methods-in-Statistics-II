rng(0)

% set up the class
Q2        = HPCP;
Q2.lambda = 0.1;
Q2.T      = 100;
Q2.npath  = 5;

% run 
Q2 = Q2.fit;
Q2.plot_path('figure/HW02Q02');
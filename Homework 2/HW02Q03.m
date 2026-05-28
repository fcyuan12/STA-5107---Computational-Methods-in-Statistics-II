rng(0)

% set up the class
Q3        = HPCP;
Q3.lambda = 0.1;
Q3.T      = 100;
Q3.npath  = 50;

% run 
Q3 = Q3.fit;
Q3 = Q3.get_count(10, 60);
Q3.plot_hist_count('figure/HW02Q03')
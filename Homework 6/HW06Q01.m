rng(0);
Q1 = SMC;
Q1.T = 20;
Q1.n = 5000;
Q1.sig1 = sqrt(0.1);
Q1.sig2 = sqrt(0.1);

% 1.
Q1 = Q1.DGP1;
% 2.
Q1 = Q1.fit1;
% 3.
Q1.plot_hist('figure/HW06Q01_hist');
% 4.
Q1.plot_path('figure/HW06Q01_path');

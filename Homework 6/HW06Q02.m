rng(0);
Q2 = SMC;
Q2.T = 20;
Q2.n = 5000;
Q2.sig1 = sqrt(10);
Q2.sig2 = sqrt(1);

% 1.
Q2 = Q2.DGP2;
% 2.
Q2 = Q2.fit2;
% 3.
Q2.plot_hist('figure/HW06Q02_hist');
% 4.
Q2.plot_path('figure/HW06Q02_path');
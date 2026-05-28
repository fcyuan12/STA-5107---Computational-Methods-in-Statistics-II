load('data/Problem2_Data.mat');  

Q2 = DP;
Q2.n  = size(D, 1);
Q2.N  = Q2.n;
Q2.D  = D;
Q2.X  = X;
Q2.M  = 1000;
Q2.i0 = 10;
Q2.j0 = 30;

Q2 = Q2.fit_SDP;
Q2.plot_SDP('figure/HW09Q02_10to30');

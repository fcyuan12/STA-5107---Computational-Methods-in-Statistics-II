load('data/Problem1_Data.mat');  

Q1 = DP;
Q1.n = size(A, 1);
Q1.N = 20;
Q1.D = A;

Q1 = Q1.fit_DP;
Q1.plot_DP('figure/HW09Q01');

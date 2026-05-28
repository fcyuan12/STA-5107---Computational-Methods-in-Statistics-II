rng(0);

H = [1; -1; 1; -1];
J = [1; 1; -1; -1];
n = 10;
niter = 4;

for i = 1:4
    Q1 = GS;
    Q1.H = H(i);
    Q1.J = J(i);
    Q1.n = n;
    Q1.niter = niter;

    savename = sprintf('%s_%d', 'figure/HW05Q01', i);
    Q1 = Q1.fit_Q1(savename);
end    

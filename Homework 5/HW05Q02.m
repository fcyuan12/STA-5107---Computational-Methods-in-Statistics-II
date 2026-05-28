rng(0);

sigma = sqrt(0.1);
niter = 5;

for i = 1:4
    readname = sprintf('data/ImageFile%d.mat', i);
    load(readname);

    Q2 = GS;
    Q2.sigma = sigma;
    Q2.niter = niter;
    Q2.I = I;
    
    savename = sprintf('%s_%d', 'figure/HW05Q02', i);
    Q2 = Q2.fit_Q2(savename);
end

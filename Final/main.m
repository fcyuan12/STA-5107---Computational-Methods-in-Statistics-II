dt = {};

for i = 1:10
    rng(i);

    dt{i} = RJMCMC;
    dt{i}.m    = 10;
    dt{i}.k    = 10;
    dt{i}.mu_b = 2;
    dt{i}.sigma_p = 0.3;
    dt{i}.sigma_0 = 0.2;
    dt{i}.sigma_r = 0.2;
    dt{i}.R = 100000;

    dt{i} = dt{i}.DGP;
    dt{i} = dt{i}.fit;

    dt{i}.plot_hist(sprintf('figure/n_hist_%d', i));
    dt{i}.plot_path(sprintf('figure/n_path_%d', i));
    disp(dt{i}.n(end))
    disp(dt{i}.n0)
end    

save('dt.mat', 'dt')

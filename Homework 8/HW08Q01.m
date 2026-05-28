for i = 1:2
    rng(i);
    Q1 = Optim;
    Q1.f = @(x) 1 - exp(-x.^2) - 2*exp(-(x - 3).^2) - exp(-(x - 6).^2);
    Q1.g = @(x) 2*x.*exp(-x.^2) + 4*(x - 3).*exp(-(x - 3).^2) + 2*(x - 6).*exp(-(x - 6).^2);
    Q1.delta   = 0.1;
    Q1.tol     = 1e-6;
    Q1.maxIter = 5000;
    Q1.alpha   = 0.995;
    Q1.lb      = -1;
    Q1.ub      = 7;

    Q1.x1      = -1 + (7 + 1) * rand(1);
    Q1.T       = 1;

    % 1.
    Q1 = Q1.DGD;
    Q1.plot_xk(sprintf('figure/HW08Q01_DGD_xk_%d', i));
    Q1.plot_fxk(sprintf('figure/HW08Q01_DGD_E_%d', i));

    % 2.
    Q1 = Q1.SGD;
    Q1.plot_xk(sprintf('figure/HW08Q01_SGD_xk_%d', i));
    Q1.plot_fxk(sprintf('figure/HW08Q01_SGD_E_%d', i));

    % 3.
    Q1 = Q1.SA;
    Q1.plot_xk(sprintf('figure/HW08Q01_SA_xk_%d', i));
    Q1.plot_fxk(sprintf('figure/HW08Q01_SA_E_%d', i));
end

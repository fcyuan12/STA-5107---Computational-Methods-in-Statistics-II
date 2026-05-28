for i = 1:2
    rng(i);
    Q2 = Optim;
    Q2.f = @(x) (x(1) * sin(20 * x(2)) + x(2) * sin(20 * x(1)))^2 * cosh(sin(10 * x(1)) * x(1)) + ...
                (x(1) * cos(10 * x(2)) - x(2) * sin(10 * x(1)))^2 * cosh(cos(20 * x(2)) * x(2)) + ...
                0.01 * (x(1)^2 + x(2)^2);
    Q2.maxIter = 5000;
    Q2.alpha   = 0.995;
    Q2.lb      = -1;
    Q2.ub      = 1;
    
    Q2.x1      = -1 + (1 + 1) * rand(1, 2);
    Q2.T       = 1;

    Q2 = Q2.SA;
    Q2.plot_xk(sprintf('figure/HW08Q02_SA_xk_%d', i));
    Q2.plot_fxk(sprintf('figure/HW08Q02_SA_E_%d', i));
end    

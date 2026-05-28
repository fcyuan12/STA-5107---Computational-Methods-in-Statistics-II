rng(0);

Q2      = MH;
Q2.T    = 10000;
Q2.f    = @(x) (x.^2 .* abs(sin(pi*x)) .* exp(-abs(x).^3)) .* (x > 0);
Q2.rq   = @(para) -para(1) * log(rand(1));
Q2.dq   = @(x, para) 1 / para(1) * exp(-x / para(1));
Q2.para = 1;

Q2 = Q2.fit; 

% (a)
Q2.plot_density('figure/HW04Q02_density');

% (b)
Q2.plot_hist('figure/HW04Q02_hist');

% (c)
mean(Q2.X) % 0.8515
var(Q2.X)  % 0.1357

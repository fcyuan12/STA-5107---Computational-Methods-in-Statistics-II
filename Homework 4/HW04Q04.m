rng(0);

n_chain = 4;
y       = 4;
lambda  = 1;

Q4      = MH;
Q4.T    = 10000;
Q4.f    = @(x) exp(-lambda * abs(y - x)^0.5) * (1 / sqrt(2 * pi * 4) * exp(-1/2 * (x - 5)^2 / 4));
Q4.rq   = @(para) para(1) + para(2) * randn(1);
Q4.dq   = @(x, para) 1 / sqrt(2 * pi * para(2)^2) * exp(-1/2 * (x - para(1))^2 / para(2)^2);
Q4.para = [5; sqrt(4)];

%%
X1    = zeros(n_chain, 1);
Xbar  = zeros(n_chain, 1);
S2    = zeros(n_chain, 1);
for i = 1:n_chain
    % fit the model
    Q4 = Q4.fit;
    X1(i) = Q4.X(1);

    % (a)
    savename = sprintf('%s_%d', 'figure/HW04Q04_evolution', i);
    Q4.plot_evolution(savename);

    % (b)
    Xbar(i) = mean(Q4.X);
    S2(i)   = var(Q4.X);
end

mean(Xbar) % 4.5519
mean(S2)   % 2.2960

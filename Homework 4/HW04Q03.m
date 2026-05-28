%% proposal distribution
rq{1} = @(para) -para(1) * log(rand(1));
rq{2} = @(para) -para(1) * log(rand(1));
rq{3} = @(para) para(1) + para(2) * randn(1);
rq{4} = @(para) abs(para(1) + para(2) * randn(1));

dq{1} = @(x, para) 1 / para(1) * exp(-x / para(1));
dq{2} = @(x, para) 1 / para(1) * exp(-x / para(1));
dq{3} = @(x, para) 1 / sqrt(2 * pi * para(2)^2) * exp(-1/2 * (x - para(1))^2 / para(2)^2);
dq{4} = @(x, para) 2 / sqrt(2 * pi * para(2)^2) * exp(-1/2 * (x - para(1))^2 / para(2)^2);

para{1} = 1;   % beta
para{2} = 1/2; % beta
para{3} = [0; 1]; % mu, sigma
para{4} = [0; 1]; % mu, sigma

%% 
rng(0);

Q3 = MH;
Q3.T = 10000;
Q3.f = @(x) (x.^2 .* abs(sin(pi*x)) .* exp(-abs(x).^3)) .* (x > 0);

res_r_accept = zeros(4, 1);

for i = 1:4
    Q3.rq   = rq{i};
    Q3.dq   = dq{i};
    Q3.para = para{i};
    
    Q3 = Q3.fit; 
    % disp(mean(Q3.X))
    res_r_accept(i) = Q3.r_accept;
end

disp(res_r_accept)
save('figure/HW04Q03_r_accept', "res_r_accept")

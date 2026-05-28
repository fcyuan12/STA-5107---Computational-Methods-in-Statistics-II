Q2 = KF;
Q2.n = 4;
Q2.d = 2;
Q2.T = 100;
Q2.A = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
Q2.B = [1 0 0 0; 0 1 0 0];
Q2.Gamma = eye(4);
Q2.Q     = eye(4);
Q2.x0 = zeros(4, 1);
Q2.P0 = eye(4);

for i = 1:3
    rng(i);
    Q2.Lambda = 10^i * eye(2);
    Q2 = Q2.DGP;
    Q2 = Q2.fit;
    
    Q2.plot_error(sprintf('figure/HW07Q02_error_%d', i))
end    
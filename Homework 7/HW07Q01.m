Q1 = KF;
Q1.n = 2;
Q1.d = 1;
Q1.T = 100;
Q1.A = [1 1; 0 1];
Q1.B = [1 0];
Q1.Gamma  = 0.1 * eye(2);
Q1.Q      = eye(2);
Q1.Lambda = 0.1 * eye(1);
Q1.x0 = zeros(2, 1);
Q1.P0 = eye(2);

for i = 1:3
    rng(i);
    Q1 = Q1.DGP;
    Q1 = Q1.fit;
    
    % 1.
    Q1.plot_2D_x(sprintf('figure/HW07Q01_data_%d', i)); 

    % 2.
    Q1.plot_2D_path(sprintf('figure/HW07Q01_path_%d', i)); 
    Q1.plot_error(sprintf('figure/HW07Q01_error_%d', i))
end    
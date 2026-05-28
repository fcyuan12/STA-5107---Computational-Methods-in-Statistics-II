k = 100; % k: number of observations for each class
C = 5;   % C: number of classes
d = 2;   % d: selected dimenion for projection

for i = 1:4
    % import the data
    dataname = sprintf('data/FDA_Dataset_%d.mat', i);
    load(dataname);

    % set up the class
    Q1    = LDA;
    Q1.X0 = X;
    Q1    = Q1.init(k, C);

    % (1) - (4)
    Q1 = Q1.fit;

    % (5) 
    Q1 = Q1.proj(d);
    Q1.plot_eigval(sprintf('figure/HW02Q01_eigval_%d', i));
    Q1.plot_proj(sprintf('figure/HW02Q01_proj_%d', i))
end

% data name index
idx = [1, 2, 4, 5];      
% save # of singular values to meet 90% explained variance
n_comp_90 = zeros(length(idx), 1); 

for i = 1:length(idx)
    % import the data
    dataname = sprintf('data/PCA_Dataset_%d.mat', idx(i));
    load(dataname);

    % set up the class
    Q1   = PCA;
    Q1.X = X;
    Q1   = Q1.get_dim;

    % (1) scatter plot of data
    Q1.plot_data(sprintf('figure/HW01Q01_data_%d', idx(i)));
    % (2) perform PCA
    Q1 = Q1.fit;
    % (3) display the top 2 principal directions on the scatter plot of data
    Q1 = Q1.plot_direction(sprintf('figure/HW01Q01_dir_%d', idx(i)));
    % (4) project the data to the first 2 principal dimensions
    Q1 = Q1.plot_PCscore(sprintf('figure/HW01Q01_proj_%d', idx(i)));
    % (5) plot the singular values, and find # of singular values to meet 90% explained variance
    Q1 = Q1.plot_S(sprintf('figure/HW01Q01_S_%d', idx(i)));
    Q1 = Q1.plot_R(sprintf('figure/HW01Q01_R_%d', idx(i)));
    n_comp_90(i, 1) = find(Q1.R >= 0.9, 1);
end    

disp(n_comp_90)
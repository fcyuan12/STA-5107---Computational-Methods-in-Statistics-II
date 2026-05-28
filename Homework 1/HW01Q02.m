%% import the data
load data/FaceImagesSubset1.mat;

%% set up the class
Q2    = PCAimg;
Q2.X  = X;
Q2    = Q2.get_dim;
Q2.n1 = 64;
Q2.n2 = 56;

%% (1) plot the sample mean face
Q2 = Q2.plot_mean('figure/HW01Q02_Xbar');

%% (2) plot the singular values of Cov(X)
Q2 = Q2.fit; % perform PCA
Q2 = Q2.plot_S('figure/HW01Q02_S');
Q2 = Q2.plot_R('figure/HW01Q02_R');

%% (3) images of the first three principal eigenvectors
for i = 1:3
    Q2 = Q2.plot_PCi(i, sprintf('figure/HW01Q02_PC%d', i));
end    

%% (4) 3 arbitrary faces: original image, reconstruction (d=20), and absolute error
rng(0);
idx = ceil(rand(3, 1) * Q2.k);

for i = 1:length(idx)
    Q2.plot_reconstruction(20, i, sprintf('figure/HW01Q02_rec_%d', idx(i)))
end


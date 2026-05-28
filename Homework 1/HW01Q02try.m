%% import the data
load data/FaceImagesSubset1.mat;

%% (1) plot the sample mean face
Xbar = mean(X, 2);
figure(1)
imagesc(reshape(Xbar, 64, 56))
colormap("gray")
axis equal off

%% (2) plot the singular values of Cov(X)
C = cov(X');
[U, S, ~] = svd(C);
figure(1)
s = diag(S);

%%
% Given data
figure(1)
plot(sqrt(s), '-'); % Original plot
title('Original Plot');
xlabel('Index');
ylabel('Value');
% grid on;

% Add an inset figure (top-right corner)
axes('Position', [0.55, 0.55, 0.3, 0.3]); % Adjust the position and size
plot(s(1:100), '-r'); % Plot the zoomed-in section
title('Zoomed View (1:100)');
xlabel('Index');
ylabel('Value');
% grid on;

% [V, D] = eig(C' * C);
% lam = diag(D);
% lam(end) == s(1)^2

%% (3) images of the first three principal eigenvectors

for i = 1:3
    figure(i)
    imagesc(reshape(U(:, i), 64, 56))
    colormap("gray")
    axis equal off

    pause
end

%% (4) 
% https://github.com/fcyuan12/Fall-2024/blob/main/STA%205106%20-%20Computational%20Methods%20in%20Statistics%20I%20/Homework/Midterm/code/matlab/NN_40.m
U1 = U(:, 1:20);
Xr = Xbar + U1 * U1' * X(:, 1);
Xerr = abs(X - Xr);

%%
for i = 178%1:3
    figure(i)
    imagesc(reshape(Xr(:, i), 64, 56))
    colormap("gray")
    axis equal off

    pause
end

%%
for i = 178%1:3
    figure(i)
    imagesc(reshape(Xerr(:, i), 64, 56))
    colormap("gray")
    axis equal off

    pause
end
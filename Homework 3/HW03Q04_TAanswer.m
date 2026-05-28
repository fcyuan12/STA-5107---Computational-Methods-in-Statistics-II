% To obtain the dominant vector, you should first do the eigenvector decomposition and then find where the eigenvalue is 1. 
% Find the corresponding eigenvector and then scale it,then you can obtain the dominant eigenvector.

% Problem 4

clear all;

pi=[0.5 0.5 0.0 0.0;

0.1 0.9 0.0 0.0;

0.0 0.0 0.3 0.7;

0.0 0.0 0.2 0.8]

[U, S]=eig(pi');

S

v1=U(:,2)/sum(U(:,2))

v2=U(:,4)/sum(U(:,4))

 

%% Repeat the above code in Question 4

clear all;

pi=[0 0.5 0.0 0.5;

0.5 0 0.5 0.0;

0.0 0.5 0 0.5;

0.5 0.0 0.5 0]

[U, S]=eig(pi');

 

v1=U(:,4)/sum(U(:,4))
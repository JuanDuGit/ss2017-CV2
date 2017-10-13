% solve for the best fitting linear function of several variables 
% through a set of points using the Matlab function svd

% Note from Rui: 
% The Matlab function pinv() should not be used in this exercise.  

%% create the data

% generate data set consisting of 20 samples of each of 4 variables
N = 20;
d1 = rand(N,1);
d2 = rand(N,1);
d3 = rand(N,1);
d4 = 4*d1 - 3*d2 + 2*d3 - 1;

% introduce small errors into the data
% (the 'rand' function produces numbers between 0 and 1)
eps = 1.e-5;
d1 = d1 .* (1 + eps * rand(N,1));
d2 = d2 .* (1 + eps * rand(N,1));
d3 = d3 .* (1 + eps * rand(N,1));
d4 = d4 .* (1 + eps * rand(N,1));

%% find the coefficients x solving the system: x1*d1 + x2*d2 + x3*d3 + x4*d4 = 1;

% define A and compute the svd
D = [d1 d2 d3 d4];
[U, S, V] = svd(D);

% construct b and S^+
S_plus = 1 ./ S;
S_plus(S == 0) = 0;
S_plus = S_plus';
b = ones(N,1);

% solve the least squares problem using the pseudo inverse D_plus = V * S_plus * U'
% (compare Chapter 1, last slide: x = D_plus * b 
% is among all minimizers of |Dx - b| the one with the smallest norm |x|.)
x = V * S_plus * U' * b;
disp(x)

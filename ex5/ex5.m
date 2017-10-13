close all;
%{
I= imreadbw('img1.png');
sigma = 1;
kappa = 0.05;
theta = 1e-7;

[C, pts ] = getHarrisCorners(I, sigma, kappa, theta);
drawPts(I, pts);

[C, pts ] = getHarrisCorners(I, 2*sigma, kappa, theta);
drawPts(I, pts);
[C, pts ] = getHarrisCorners(I, 4*sigma, kappa, theta);
drawPts(I, pts);
%}
I1 = imreadbw('img1.png');
I2 = imreadbw('img2.png');
sigma = 2;

[vx, vy] = getFlow(I1, I2, sigma);
figure;
imagesc(vx);
colormap gray;
figure;
imagesc(vy);
colormap gray;
figure;
[m,n] = size(I1);

[X,Y] = meshgrid(1:n,1:m);
quiver(X,Y,vy,vx);
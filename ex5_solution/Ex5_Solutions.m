%% Multiple View Geometry 2017, Exercise Sheet 5
% Prof. Daniel Cremers, Christiane Sommer, Rui Wang

%% Exercise 1: The Structure Tensor
close all;
I = imreadbw('img1.png');
sigma = 2;

[M11, M22, M12] = getM(I, sigma);

subplot(131), imagesc(M11), axis image
subplot(132), imagesc(M22), axis image
subplot(133), imagesc(M12), axis image

%% Exercise 2: Corner Detection

I = imreadbw('img1.png');
sigma = 2;
kappa = 0.05;
theta = 1e-7;

[C, pts ] = getHarrisCorners(I, sigma, kappa, theta);
figure;
drawPts(I, pts);


%% Exercise 3: Dense Optical Flow

I1 = imreadbw('img1.png');
I2 = imreadbw('img2.png');
sigma = 8;

[vx, vy] = getFlow_my(I1, I2, sigma);
figure;
imagesc(vx), axis image
colormap gray
figure
imagesc(vy), axis image
colormap gray
figure
imagesc(I1), axis image
hold on, quiver(10*vx, 10*vy), hold off

colormap gray
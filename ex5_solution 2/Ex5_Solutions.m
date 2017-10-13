%% Multiple View Geometry 2017, Exercise Sheet 5
% Prof. Daniel Cremers, Christiane Sommer, Rui Wang

%% Exercise 1: The Structure Tensor

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

drawPts(I, pts);


%% Exercise 3: Dense Optical Flow

I1 = imreadbw('img1.png');
I2 = imreadbw('img2.png');
sigma = 2;

[vx, vy] = getFlow(I1, I2, sigma);

subplot(131), imagesc(vx), axis image
subplot(132), imagesc(vy), axis image

subplot(133), imagesc(I1), axis image
hold on, quiver(vx, vy), hold off

colormap gray
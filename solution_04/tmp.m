% (a)
%load image
Id1 = imreadbw('img1.jpg');
figure;
subplot(121)
imagesc(Id1), axis image, colormap gray
title('Distorted image')

% (b)
tic
% camera intrinsics of distorted image
Kd1 = [388.6     0 343.7;...
           0 389.4 234.6;...
           0     0     1];
% camera intrinsics of new, virtual image
Knew = [250   0 512;...
          0 250 384;...
          0   0   1];
% define pixel grid of new image
[n,m] = meshgrid(0:1023, 0:767);
% pixels in homogeneous coordinates
nm1 = [n(:), m(:), ones(1024*768,1)]';
% pi(X) in homogeneous coordinates: un-project
pi_hom = Knew\nm1;
% compute radial distortion
w = 0.92646;
g_ATAN = @(r) atan(2*r*tan(.5*w))./(w*r);
r = sqrt(pi_hom(1,:).^2+pi_hom(2,:).^2);
size(r)
G = [g_ATAN(r); g_ATAN(r); ones(1,1024*768)];
size(G)
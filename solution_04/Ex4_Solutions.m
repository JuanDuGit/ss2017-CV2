%% Multiple View Geometry 2017, Exercise Sheet 4
% Prof. Daniel Cremers, Christiane Sommer, Rui Wang

%% Exercise 1: Image Formation
close all;
[V, F] = openOFF('model.off');
N_vert = size(V,1);

% (a)
% homogeneous coordinates
V_hom = [V, ones(N_vert,1)];
% define rigid body transformation matrix
T = [1 0 0 -0.5;...
     0 1 0 -0.5;...
     0 0 1    1];
% translate vertices
V_new = T*V_hom';

% (b)
% camera intrinsics
K = [540   0 320;...
       0 540 240;...
       0   0   1];
% perspective projection
lambda_nm1 = K*V_new;
Z = lambda_nm1(3,:);
n = lambda_nm1(1,:)./Z;
m = lambda_nm1(2,:)./Z;
% visualization
figure;
subplot(121)
patch('Vertices', [n;m]', 'Faces', F)
axis equal, axis([0 640 0 480])
title('Perspective projection')

% (c)
% parallel projection pi_parallel in homogeneous coordinates
pi_par_hom = [V_new(1:2,:); ones(1, N_vert)];
nm1 = K*pi_par_hom;
subplot(122)
patch('Vertices', nm1(1:2,:)', 'Faces', F)
axis equal, axis([0 640 0 480])
title('Parallel projection')

%% Exercise 2: Radial Distortion and Image Rectification

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
G = [g_ATAN(r); g_ATAN(r); ones(1,1024*768)];

% projection into distorted image
pi_d_hom = G.*pi_hom;
ndmd1 = Kd1*pi_d_hom;
nd = ndmd1(1,:);
md = ndmd1(2,:);
% interpolation
Inew = reshape(interp2(Id1, nd, md, 'linear'),size(n));
toc
% display rectified image
subplot(122)
imagesc(Inew), axis image, colormap gray
title('Rectified image')
imwrite(Inew,'img1_undist.jpg')

% (c)
% load and display image
Id2 = imreadbw('img2.jpg');
figure
subplot(121)
imagesc(Id2), axis image, colormap gray
title('Distorted image')
% start actual rectification
tic
% camera intrinsics of distorted image
Kd2 = [279.7     0 347.3;...
           0 279.7 235.0;...
           0     0     1];
% compute radial distortion
g_pol = @(r) (1 - .3407*r + .057*r.^2 - .0046*r.^3 + .00014*r.^4);
G = [g_pol(r); g_pol(r); ones(1,1024*768)];
% projection into distorted image
pi_d_hom = G.*pi_hom;
ndmd1 = Kd2*pi_d_hom;
nd = ndmd1(1,:);
md = ndmd1(2,:);
% interpolation
Inew = reshape(interp2(Id2, nd, md, 'linear'),size(n));
toc
% display rectified image
subplot(122)
imagesc(Inew), axis image, colormap gray
title('Rectified image')
imwrite(Inew,'img2_undist.jpg')

% (f)
figure
subplot(121)
imagesc(Id2), axis image, colormap gray
title('Original image')
% compute g_ATAN*pi(X)
pi_d1_hom = Kd1\nm1;
% invert radial distortion
f_ATAN = @(rd) .5*tan(rd*w)./(rd*tan(.5*w));
rd = sqrt(pi_d1_hom(1,:).^2+pi_d1_hom(2,:).^2);
r = f_ATAN(rd).*rd;
F = [f_ATAN(rd); f_ATAN(rd); ones(1,1024*768)];
pi_hom = F.*pi_d1_hom;
% compute new radial distortion
G = [g_pol(r); g_pol(r); ones(1,1024*768)];
% projection into image 2
pi_d2_hom = G.*pi_hom;
ndmd1 = Kd2*pi_d2_hom;
nd = ndmd1(1,:);
md = ndmd1(2,:);
% interpolation

Inew = reshape(interp2(Id2, nd, md, 'linear'),size(n));
toc
% display rectified image
subplot(122)
imagesc(Inew), axis image, colormap gray
title('New virtual image')
imwrite(Inew,'img2_cam1.jpg')
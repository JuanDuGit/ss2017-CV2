close all;
clear all;
Id1 = imreadbw('img1.jpg');
%Id1_gray = rgb2gray(Id1);
figure;
imagesc(Id1), axis image, colormap gray
title('Distorted image')

%un-projecting
tic
K_d1 = [388.6     0 343.7;...
           0 389.4 234.6;...
           0     0     1];
Knew = [250   0 512;...
          0 250 384;...
          0   0   1];
[n,m] = meshgrid(0:1023, 0:767);

img_cord = [n(:),m(:),ones(1024*768,1)]';
    
pi_x_hom = Knew\img_cord;
disp(pi_x_hom(:,1:3));
r = sqrt(pi_x_hom(1,:).^2 + pi_x_hom(2,:).^2);
w = 0.92646;
g_pix = atan(2*r*tan(w/2))./(w*r);
tmp = [g_pix; g_pix; ones(1,1024*768)];
pid_x_hom = tmp.*pi_x_hom;
newimg_cord = K_d1*pid_x_hom;
newimg = interp2(Id1,newimg_cord(1,:),newimg_cord(2,:));
newimg = reshape(newimg,size(n));
toc
figure;
imagesc(newimg), axis image, colormap gray
title('rec image1');
%% img2
Id2 = imreadbw('img2.jpg');
figure;
imagesc(Id2), axis image, colormap gray
title('Distorted image2')

%un-projecting
tic
K_d2 = [279.7     0 347.3;...
           0 279.7 235.0;...
           0     0     1];

g_pol = (1 - .3407*r + .057*r.^2 - .0046*r.^3 + .00014*r.^4);
tmp = [g_pol; g_pol; ones(1,1024*768)];
pid_x_hom = tmp.*pi_x_hom;
newimg_cord = K_d2*pid_x_hom;
newimg = interp2(Id2,newimg_cord(1,:),newimg_cord(2,:));
newimg = reshape(newimg,size(n));
toc
figure;
imagesc(newimg), axis image, colormap gray
title('rec image2');

%% (f)
pi_d_hom = K_d1\img_cord;
rd = sqrt(pi_d_hom(1,:).^2 + pi_d_hom(2,:).^2);
f_rd = tan(rd*w)./(2*rd*tan(0.5*w));
tmp = [f_rd; f_rd; ones(1,1024*768)];
pi_x_hom = tmp.*pi_d_hom;
r = f_rd.*rd;
g_pol = (1 - .3407*r + .057*r.^2 - .0046*r.^3 + .00014*r.^4);
tmp = [g_pol; g_pol; ones(1,1024*768)];
pid_x_hom = tmp.*pi_x_hom;
newimg_cord = K_d2*pid_x_hom;
newimg2 = interp2(Id2,newimg_cord(1,:),newimg_cord(2,:));
newimg2 = reshape(newimg2,size(n));
toc
figure;
imagesc(newimg2), axis image, colormap gray
title('dis image2');






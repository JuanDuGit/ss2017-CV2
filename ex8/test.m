close all;
K = [517.3 0 318.6;	0 516.5 255.3; 0 0 1];
    % first pair of input frames
    c1 = double(imreadbw('rgb/1305031102.275326.png'));
    c2 = double(imreadbw('rgb/1305031102.175304.png'));
    d1 = double(imread('depth/1305031102.262886.png'))/5000;
    d2 = double(imread('depth/1305031102.160407.png'))/5000;

lvl = 4;
[IRef, DRef, Klvl] = downscale(c1,d1,K,lvl);
    % downscale target frame (intensity image and depth map)
    xi = [0 0 0 0 0 0]';

[I, D] = downscale(c2,d2,K,lvl);
residual = calcErr(IRef,DRef,I,xi,K);
figure;
subplot(1,2,1);
imshow(IRef);
subplot(1,2,2);
imshow(residual);
residual = calcErr(IRef,DRef,I,xi,K);

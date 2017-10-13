function [ output_args ] = ex1( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 lena = imread('lena.png');
 [rows, cols, channels] = size(lena);
imshow(lena), axis image
 
 graylena = rgb2gray(lena);
 maxv = max(graylena(:))
 minv = min(graylena(:))
 
 lena_d = im2double(graylena);
 
 smoothlena = conv2(lena_d, fspecial('gaussian'));
 imwrite(smoothlena,'gaussian.png');
 
 subplot(1,3,1); imshow(lena);title('original');
 subplot(1,3,2); imshow(lena_d); title('gray');
 subplot(1,3,3); imshow(smoothlena); title('gauusian');
 
end


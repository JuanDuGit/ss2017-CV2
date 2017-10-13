close all;
clear all;
num_points = 8;
% Read input images:
image1 = double(imread('batinria0.tif'));
image2 = double(imread('batinria1.tif'));


x1 = [70.0000
  296.0000
  324.0000
  374.0000
  304.0000
  348.0000
  106.0000
   56.0000];
y1 = [88.0000
  148.0000
  210.0000
  264.0000
  334.0000
  396.0000
  230.0000
  292.0000];
x2 = [184.0000
  404.0000
  436.0000
  494.0000
  416.0000
  458.0000
  214.0000
  166.0000];
y2 = [98.0000
  154.0000
  216.0000
  274.0000
  344.0000
  408.0000
  236.0000
  298.0000];
K1 = [844.310547 0 243.413315; 0 1202.508301 281.529236; 0 0 1];
K2 = [852.721008 0 252.021805; 0 1215.657349 288.587189; 0 0 1];
figure; imshow(uint8(image1));
hold on;
plot(x1, y1, 'r+');
hold off;

figure; imshow(uint8(image2));
hold on;
plot(x2, y2, 'r+');
hold off;
chi = zeros(num_points,9);
for i = 1:num_points
    x1i = K1\[x1(i);y1(i);1];
    x2i = K1\[x2(i);y2(i);1];
    chi(i,:) = kron(x1i, x2i);
    
end
[U,S,V] = svd(chi);
E = reshape(V(:,9),3,3);
[U_E,S_E,V_E] = svd(E);
Rz1 = [0 1 0; -1 0 0; 0 0 1]';
Rz2 = [0 -1 0; 1 0 0; 0 0 1]';
S_E = [1 0 0;0 1 0;0 0 1];
R1 = U_E*Rz1*V_E';
T1_hat = U_E*Rz1'*S_E*U_E';
T1 = [T1_hat(3,2);T1_hat(1,3);T1_hat(2,1)];
R2 = U_E*Rz2*V_E';
T2_hat = U_E*Rz2'*S_E*U_E';
T2 = [T2_hat(3,2);T2_hat(1,3);T2_hat(2,1)];

lam1 = reconstruction(R1,T1,x1,y1,x2,y2,num_points,K1)
lam2 = reconstruction(R2,T2,x1,y1,x2,y2,num_points,K1)
%{
figure;
imshow(uint8(image1))
[x,y] = ginput(8)
figure;
imshow(uint8(image2))
[x2,y2] = ginput(8)
  %}

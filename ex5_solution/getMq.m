function [M11, M22, M12, q1, q2] = getMq(I1, I2, sigma)

% calc image gradients
Ix = zeros(size(I1));
Iy = zeros(size(I1));
Ix(:,2:(end-1)) = 0.5*(I1(:,3:end) - I1(:,(1:end-2)));
Iy(2:(end-1),:) = 0.5*(I1(3:end,:) - I1((1:end-2),:));

It = I2-I1;

% create gaussian kernel
r = 2*sigma;
sz = 2*r+1;
kernel = fspecial('gaussian', [sz sz], sigma);

% calc tensor content and convolve it with Gaussian kernel
M11 = conv2(Ix.*Ix, kernel, 'same');
M22 = conv2(Iy.*Iy, kernel, 'same');
M12 = conv2(Ix.*Iy, kernel, 'same');

q1 = conv2(Ix.*It, kernel, 'same');
q2 = conv2(Iy.*It, kernel, 'same');
M11(1:10,1:10)

end


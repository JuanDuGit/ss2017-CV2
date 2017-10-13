function [M11, M22, M12] = getM_my(I, sigma)
   % calc image gradients
Ix = zeros(size(I));
Iy = zeros(size(I));
Ix(:,2:(end-1)) = 0.5*(I(:,3:end) - I(:,(1:end-2)));
Iy(2:(end-1),:) = 0.5*(I(3:end,:) - I((1:end-2),:));

% create gaussian kernel
r = 2*sigma;
sz = 2*r+1;
kernel = fspecial('gaussian', [sz sz], sigma);

% calc tensor content and convolve it with Gaussian kernel
M11 = conv2(Ix.*Ix, kernel, 'same');
M22 = conv2(Iy.*Iy, kernel, 'same');
M12 = conv2(Ix.*Iy, kernel, 'same');
    
end

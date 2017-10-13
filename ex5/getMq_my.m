function [M11, M22, M12,q1,q2] = getMq_my(I,I2, sigma)
   % calc image gradients
Ix = zeros(size(I));
Iy = zeros(size(I));

Ix(:,1:end-1) = 0.5*(I(:,2:end) - I(:,1:end-1));
Iy(1:end-1,:) = 0.5*(I(2:end,:) - I(1:end-1,:));

r = 2*sigma;
sz = 2*r+1;
G = fspecial('gaussian', [sz sz], sigma);
M11 = conv2(Ix.^2, G, 'same');
M22 = conv2(Iy.^2, G, 'same');
M12 = conv2(Ix.*Iy, G, 'same');

It = I2 - I;
Ixt = Ix.*It;
Iyt = Iy.*It;
q1 = conv2(Ixt,G,'same');
q2 = conv2(Iyt,G,'same');
q1(1:10,1:10)
    
end

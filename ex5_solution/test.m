I = imreadbw('img1.png');
Ix = zeros(size(I));
Iy = zeros(size(I));
Ix(:,2:(end-1)) = 0.5*(I(:,3:end) - I(:,(1:end-2)));
Iy(2:(end-1),:) = 0.5*(I(3:end,:) - I((1:end-2),:));

[Gx, Gy] = imgradientxy(I,'central');

Ix(1:2,1:10)
Gx(1:2,1:10)

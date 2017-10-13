function [score, points ] = getHarrisCorners(I, sigma, kappa, theta)

[M11, M22, M12] = getM(I, sigma);

det = M11 .* M22 - M12.*M12;
trace2 = (M11 + M22).^2;
score = det - kappa*trace2;

imagesc((score > 0).*abs(score).^0.25)
colormap gray

scoree = NaN(size(score)+2);
scoree(2:(end-1),2:(end-1)) = score;
[y, x] = find(score > scoree(1:(end-2), 2:(end-1)) ...
            & score > scoree(3:(end), 2:(end-1)) ...
            & score > scoree(2:(end-1), 1:(end-2)) ...
            & score > scoree(2:(end-1), 3:(end)) ...
            & score > theta);

points = [x y];
end
function [score, points] = getHarrisCorners(I, sigma, kappa, theta)

[M11, M12, M22] = getM_my(I, sigma);

% TODO: compute score using det and trace
% TODO: display score
det = M11.*M22 - M12.*M12;
trace = M11 + M22;
C = det - kappa*trace.^2;
score = sign(C).*abs(C).^0.25;
%imagesc(score);
%colormap gray;

scorecopy = NaN(size(score)+2);
scorecopy(2:end-1,2:end-1) = score;
% TODO: find corners (variable points)
[x,y] = find(score > theta...
           & score>scorecopy(2:end-1,3:end)...
           & score>scorecopy(2:end-1,1:end-2)...
           & score>scorecopy(3:end,2:end-1)...
           & score>scorecopy(1:end-2,2:end-1))
points = [y x];
end
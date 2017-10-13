function [vx, vy] = getFlow(I1, I2, sigma)

[M11, M22, M12, q1, q2] = getMq(I1, I2, sigma);

detM = M11.*M22 - M12.^2;
vx = (M12.*q2 - M22.*q1) ./ detM;
vy = (M12.*q1 - M11.*q2) ./ detM;

end
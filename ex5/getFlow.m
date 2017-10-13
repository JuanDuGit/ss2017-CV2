function [vx, vy] = getFlow(I1, I2, sigma)

[M11, M12, M22, q1, q2] = getMq_my(I1, I2, sigma);

% TODO: compute entries vx and vy for each pixel
vx = (M12.*q2-M22.*q1)./(M11.*M22-M12.^2);
vy = (M12.*q1-M11.*q2)./(M11.*M22-M12.^2);

end


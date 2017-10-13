function [ Id, Dd, Kd ] = downscale( I, D, K, level )
    % downscale intensity image, depth map and camera intrinsics (recursively)

    if(level <= 1)
        % coarsest pyramid level
        Id = I;
        Dd = D;
        Kd = K;
        return;
    end

    % downscale camera intrinsics
    % TODO
    Kd = 0.5*K;
    Kd(1:3,3) =  Kd(1:3,3) - 0.25;
    Kd(3,3) = 1;

    % downscale intensity image
    % TODO
    [size_x,size_y] = size(I);
    newsize_x = 0.5 * size_x;
    newsize_y = 0.5 * size_y;
    
    Id = (I(1:2:end,1:2:end)+I(1+(1:2:end),(1:2:end))+I((1:2:end),1+(1:2:end))+I(1+(1:2:end),1+(1:2:end)))*0.25;
    
    % downscale depth map
    % TODO
    
    DdCountValid = (sign(D(0+(1:2:end), 0+(1:2:end))) + ...
                sign(D(1+(1:2:end), 0+(1:2:end))) + ...
                sign(D(0+(1:2:end), 1+(1:2:end))) + ...
                sign(D(1+(1:2:end), 1+(1:2:end))));
    Dd = (D(0+(1:2:end), 0+(1:2:end)) + ...
        D(1+(1:2:end), 0+(1:2:end)) + ...
        D(0+(1:2:end), 1+(1:2:end)) + ...
        D(1+(1:2:end), 1+(1:2:end))) ./ DdCountValid;
    Dd(isnan(Dd)) = 0;
    

    % recursively downscale on next pyramid level
    [Id, Dd, Kd] = downscale( Id, Dd, Kd, level - 1);    
end
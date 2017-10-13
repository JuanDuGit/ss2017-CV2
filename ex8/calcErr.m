function [ err ] = calcErr( IRef, DRef, I, xi, K )
    % calculate residuals

    % get shorthands (R, t)
    T = se3Exp(xi);
    R = T(1:3, 1:3);
    t = T(1:3,4);
    %Rinv = R*inv(K);
    Rinv = R * K^-1;
    % these contain the n,m image coordinates of the respective
    % reference-pixel, transformed & projected into the new image.
    % set to -10 initially, as this will give NaN on interpolation later.
    nImg = zeros(size(IRef))-10;
    mImg = zeros(size(IRef))-10;
    
    % for all pixels
    for n=1:size(IRef,2)
        for m=1:size(IRef,1)
            % TODO warp reference points to target image
            z = DRef(m,n);
            unproject = [n-1;m-1;1]*z;
            % TODO project warped points onto image
            newp = K*(Rinv*unproject+t);
            
            if(newp(3) > 0 && DRef(m,n) > 0)
                nImg(m,n) = newp(1)/newp(3)+1;
                mImg(m,n) = newp(2)/newp(3)+1;
                
            end
        end
    end

    % calculate actual residual (as matrix).
    err = interp2(I, nImg, mImg) - IRef;
    %disp(err(60,1:10));
    % plot residual image
    imagesc(err), axis image
    colormap gray;
    set(gca, 'CLim', [-1,1]);

    err = err(:);

end


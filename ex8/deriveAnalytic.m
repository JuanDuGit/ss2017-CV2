function [ Jac, residual ] = deriveAnalytic( IRef, DRef, I, xi, K )
    % calculate analytic derivative

    % get shorthands (R, t)
    T = se3Exp(xi);
    R = T(1:3, 1:3);
    t = T(1:3,4);
    RKInv = R* K^-1;
    % ========= warp pixels into other image, save intermediate results ===============
    % these contain the n,m image coordinates of the respective
    % reference-pixel, transformed & projected into the new image.
    nImg = zeros(size(IRef))-10;
    mImg = zeros(size(IRef))-10;

    % these contain the 3d position of the transformed point
    xp = NaN(size(IRef));
    yp = NaN(size(IRef));
    zp = NaN(size(IRef));
    for n=1:size(IRef,2)
        for m=1:size(IRef,1)
            % TODO warp points into target frame
            p = [n-1;m-1;1] * DRef(m,n);

            % transform to image (unproject, rotate & translate)
            pTrans = K * (RKInv * p + t);

            % if point is valid (depth > 0), project and save result.
            if(pTrans(3) > 0 && DRef(m,n) > 0)
                nImg(m,n) = pTrans(1) / pTrans(3) + 1;
                mImg(m,n) = pTrans(2) / pTrans(3) + 1;
                xp(m,n) = pTrans(1);
                yp(m,n) = pTrans(2);
                zp(m,n) = pTrans(3);
            end
        end
    end

    % ========= calculate actual derivative. ===============
    % culate image derivatives 
    % TODO image gradient in x and y direction using central differences
    %dxI = ...
    %dyI = ...
    dxI = NaN(size(I));
    dyI = NaN(size(I));
    dyI(2:(end-1),:) = 0.5*(I(3:end,:)-I(1:end-2,:));
    dxI(:,2:(end-1)) = 0.5*(I(:,3:end)-I(:,1:end-2));
    % interpolate at warped positions
    Ixfx = K(1,1) * reshape(interp2(dxI, nImg+1, mImg+1),size(I,1) * size(I,2),1);
    Iyfy = K(2,2) * reshape(interp2(dyI, nImg+1, mImg+1),size(I,1) * size(I,2),1);

    % 2.: get warped 3d points (x', y', z').
                
    xp = xp(:);
    yp = yp(:);
    zp = zp(:);


    % 3. implement gradient computed in Theory Ex. 1 (b)
    Jac = zeros(size(I,1) * size(I,2),6);
    % TODO implement analytic partial derivatives
    %Jac(:,1) = ...

    Jac = zeros(size(I,1) * size(I,2),6);
    Jac(:,1) = Ixfx ./ zp;
    Jac(:,2) = Iyfy ./ zp;
    Jac(:,3) = - (Ixfx .* xp + Iyfy .* yp) ./ (zp .* zp);
    Jac(:,4) = - (Ixfx .* xp .* yp) ./ (zp .* zp) - Iyfy .* (1 + (yp ./ zp).^2);
    Jac(:,5) = + Ixfx .* (1 + (xp ./ zp).^2) + (Iyfy .* xp .* yp) ./ (zp .* zp);
    Jac(:,6) = (- Ixfx .* yp + Iyfy .* xp) ./ zp;

%{
    Jac(:,1) = Ixfx./zp;

    Jac(:,2) = Iyfy./zp;
    Jac(:,3) = (-Ixfx.*xp- Iyfy.*yp)./(zp.^2);
    Jac(:,4) = (-Ixfx.*xp.*yp- Iyfy.*(yp.^2)./zp+zp)./(zp);
    Jac(:,5) = (Ixfx.*((xp.^2)./zp+zp)+Iyfy.*yp.*xp./zp) ./(zp);
    Jac(:,6) = (-Ixfx.*yp+Iyfy.*xp)./zp;
%}
    % ========= plot residual image =========
    residual = interp2(I, nImg+1, mImg+1) - IRef;
    imagesc(residual), axis image
    colormap gray
    set(gca, 'CLim', [-1,1])
    residual = residual(:);
end


function [ out ] = approxequal( x, y, eps )
    % several options:
    out = all(all(abs(x-y) < eps)) % or
    out = sum(sum(abs(x-y) >= eps)) == 0 % or
    out = max(abs(x-y)) < eps % or
    out = max( (x-y) .* (x-y) ) < eps*eps
end


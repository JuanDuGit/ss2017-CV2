function [w] = Rtow(R)
    w_len = acos((trace(R)-1)/2);
    w = 1/(2*sin(w_len))*[R(3,2)-R(2,3); R(1,3)-R(3,1); R(2,1)-R(1,2)];
    w = w*w_len;
end
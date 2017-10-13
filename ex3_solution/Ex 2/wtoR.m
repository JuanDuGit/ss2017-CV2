function [w_hat,R] = wtoR(a,b,c)
    w_hat = [0 -c b; c 0 -a; -b a 0];
    w = [a;b;c];
    w_len = sqrt(w'*w);
    R = eye(3) + w_hat/w_len*sin(w_len) + w_hat*w_hat/(w'*w)*(1-cos(w_len));
end



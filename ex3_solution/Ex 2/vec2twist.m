function [res] = vec2twist(w1,w2,w3,w4,w5,w6)
    %w = [w1,w2,w3,w4,w5,w6];
    w = [w4,w5,w6];
    v = [w1,w2,w3];
    [w_hat,rot] = wtoR(w4,w5,w6);
    trans = (eye(3)-rot)*w_hat*v'+w'*w*v';
    trans = trans/(w*w');
    res = [rot trans;zeros(1,3) 1]; 
    
    M = [0 -w6 w5 w1;
         w6 0 -w4 w2;
         -w5 w4 0 w3;
         0  0  0  0];
    T = expm(M);
    disp(res);
    disp(T);
end
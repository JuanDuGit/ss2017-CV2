function [res] = twist2vec(twist)
    R = twist(1:3,1:3);
    w = Rtow(R);
    w_hat = [0 -w(3) w(2); w(3) 0 -w(1); -w(2) w(1) 0];
    trans = twist(1:3,4);
    A = (eye(3)-R)*w_hat+w*w';
   
    v = A\trans;
   % v = trans/A;
    v = v*(w'*w);
    res = [v;w];
    
    lg = logm(twist);
    twist = [lg(1,4) lg(2,4) lg(3,4) lg(3,2) lg(1,3) lg(2,1)]';
    disp(res);
    disp(twist);
end
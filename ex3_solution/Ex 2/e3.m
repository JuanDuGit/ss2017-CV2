R = wtoR(1,2,3);
w = Rtow(R);
wlen = norm(w);
w/wlen;
len = norm([1 2 3]);
[1 2 3]/len;
R = wtoR(w(1),w(2),w(3));

twist = vec2twist(4,5,6,1,2,3)
vec = twist2vec(twist)';


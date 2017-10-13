v = [4,-3,2];
A = rand(20,3);
d4 = A*v'-1;
d4_err = d4 + 1.e-5 * rand(20,1);
D = [A d4_err];

[U, S, V] = svd(D,0);

s= diag(S)
%k= sum(s> 1e-9) 
%s_p = diag(1./ s(1: k))
s_p = diag(1./s)
pseudoinv = V*s_p*U'




b = ones(20,1);

x = pseudoinv*ones(20,1)


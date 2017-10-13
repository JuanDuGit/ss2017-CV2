function [lamda,gamma]=reconstruction(R,T,x1,y1,x2,y2,num_points,K)
M  = zeros(3*num_points, num_points+1);
for i = 1:num_points
    x1i = K\[x1(i);y1(i);1];
    v = K\[x2(i);y2(i);1];
    
    x2_hat = [0 -v(3) v(2) ; v(3) 0 -v(1) ; -v(2) v(1) 0];
    M(3*i-2:3*i,i) = x2_hat*R*x1i;
   
    
    M(3*i-2:3*i,num_points+1) = x2_hat*T;
    
end

[V,D] = eig(M'*M);
lamda = V(1:num_points,1);
gamma =  V(1+num_points,1);


end

% Structure reconstruction matrix M:

A = [2,2,0; 0,8,3];
b = [5;15];

B = A;

x = A\b;

disp(x);

A(1,2) = 4;

c = 0;
for i = [-4, 0, 4]
    disp(i);
    c = c+i*A'*b;
end


disp(c);

C = A .* B;
D = A' * B;

disp(C);
disp(D);



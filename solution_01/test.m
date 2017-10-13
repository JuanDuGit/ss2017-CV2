a = 1.8
b = 1.3;
rot = [cos(a),sin(a),0; -sin(a),cos(a),0;0,0,1];
rot2 = [1,0,0;0,cos(b),sin(b);0,-sin(b),cos(b)];
rot3 = rot*rot2;
[sig,v] = eig(rot3)
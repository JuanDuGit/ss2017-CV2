[V,F] = openOFF('model.off');
homo_trans = [eye(3),[-0.5 -0.5 1]'];

N_vert = size(V,1);
V_hom = [V, ones(N_vert,1)];
newV = homo_trans*V_hom';


K = [540 0 320; 0 540 240; 0 0 1];
lamdax = K*newV;
lamdaz = lamdax(3,:);
n = lamdax(1,:)./lamdaz;
m = lamdax(2,:)./lamdaz;
finalV = [n;m;ones(1,N_vert)];

figure;
patch('Vertices', finalV(1:2,:)', 'Faces', F)
axis equal, axis([0 640 0 480])
title('Perspective projection')

K = [540 0 320; 0 540 240; 0 0 1];
para_v = newV(1:2,:);
para_v = [para_v; ones(1,N_vert)];
lamdax = K*para_v;
figure;
patch('Vertices', lamdax(1:2,:)', 'Faces', F)
axis equal, axis([0 640 0 480])
title('Parallel projection')
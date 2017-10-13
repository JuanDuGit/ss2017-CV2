function [newV] = alltrans(V, alp, beta, gamma, x, y,z)
    alp = deg2rad(alp);
    beta = deg2rad(beta);
    gamma = deg2rad(gamma);
    rotx = [1 0 0; 0 cos(alp) -sin(alp); 0 sin(alp) cos(alp)];
    roty = [cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)];
    rotz = [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];
    
    center = mean(V);
    
    rot = rotz*roty*rotx;
    
    trans = [eye(3) -center'; zeros(1,3),1];
    rotation = [rot,zeros(3,1);zeros(1,3),1];
    transback = [eye(3) center';zeros(1,3),1];
    transnew = [eye(3) [x,y,z]'; zeros(1,3),1];
    homoV = [V ones(size(V,1),1)];
    newhomoV = transnew*transback*rotation*trans*homoV';
    newhomoV = newhomoV';
    newV = newhomoV(:,1:3);
end
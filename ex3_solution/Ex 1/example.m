%% load & display model
close all;
[V,F,P] = openOFF('model.off');

%% display model again (possibly with changed vertex positions V)
W = rotationXYZ(V,5,0,25);
figure;
patch('Vertices', W, 'Faces', F, 'FaceVertexCData',0.3*ones(size(W,1),3));
axis equal;

shading interp;
camlight right;
camlight left;

W = rotationZYX(V,5,0,25);
figure;
patch('Vertices', W, 'Faces', F, 'FaceVertexCData',0.3*ones(size(W,1),3));

axis equal;
shading interp;
camlight right;
camlight left;

% Even though very similar, but the results are not the same! Try with
% different angles. 

%% rotation and translation
W = rigidTransform(V,5,0,25,0.5,0.2,0.1);
figure;
patch('Vertices', W, 'Faces', F, 'FaceVertexCData',0.3*ones(size(W,1),3));

axis equal;
shading interp;
camlight right;
camlight left;


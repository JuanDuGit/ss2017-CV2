%% load & display model
[V,F,P] = openOFF('model.off');

%% close figure
close all;

new1 = rotzyx(V, 5,0,25);
%% display model again (possibly with changed vertex positions V)
figure;
P = patch('Vertices', new1, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
axis equal;
shading interp;
camlight right;
camlight left;

new2 = rotxyz(V, 5,0,25);
%% display model again (possibly with changed vertex positions V)
figure;
P = patch('Vertices', new2, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
axis equal;
shading interp;
camlight right;
camlight left;

new3 = alltrans(V,5,0,25,0.5,0.2,0.1);
%% display model again (possibly with changed vertex positions V)
figure;
P = patch('Vertices', new3, 'Faces', F, 'FaceVertexCData',0.3*ones(size(V,1),3));
axis equal;
shading interp;
camlight right;
camlight left;




clear; close all;

% 1 Unit square
domain1 = Domain;

% 2 Unit disc
domain2 = Domain('disc');

% 3 Rectangle
nodes = [0 0; 1 0; 1 2;0 2];
domain3 = Domain(nodes);

% 4 Polygon
nodes = [0 0; 2 0; 2 1;1 1;1 2;0 2];
domain4 = Domain(nodes);

% 5 Half disc
nodes = [-1 0; 1 0];
edges = {{1,2};{2,1,{'cos(t)','sin(t)'},[0,pi]}};
domain5 = Domain(nodes,edges);
domain5.plot;

% 6 Parabolic shape
nodes = [0 0; 2 4;0 4];
edges = {{1,2,'t','t.^2',[0,2]};{2,3};{3,1}};
domain6 = Domain(nodes,edges);

% 7 Cosine shape
nodes = [0 0; 4*pi 0; 4*pi 4; 0 4];
edges = {{1,2};{2,3};{3,4,'t','3+cos(t)',[0,4*pi]};{4,1}};
domain7 = Domain(nodes,edges);

% 8 Asymetric Cusp
nodes = [0 0; 1 -1/2; 1 1/2];
edges = {{1,2,'t','-t.^2/2',[0,1]}
         {2,3}
         {3,1,'t','t.^4/2',[0,1]}};
domain8 = Domain(nodes,edges);

% 9 Unit square with a diagonal
nodes = [-1 -1; 1 -1 ; 1 1; -1 1];
edges = {{1,2},{2,3},{3,4},{4,1},{3,1,'lr'}};
domain9 = Domain(nodes,edges);

% 10 Square with an inclusion
nodes = [-1 -1; 1 -1 ; 1 1; -1 1;0.5 0 ; -0.5 0];
edges = {{1,2},{2,3},{3,4},{4,1},{5,6,'0.5*cos(t)','0.5*sin(t)',[0,pi],'lr'},{6,5,'0.5*cos(t)','0.5*sin(t)',[pi,2*pi],'lr'}};
domain10 = Domain(nodes,edges);

% 11 Square with an inclusion and a segment
nodes = [-1 -1; 1 -1 ; 1 1; -1 1;-0.5 0;0.5 0];
edges = {{1,2};
         {2,3};
         {3,4};
         {4,1};
         {5,6,'0.5*cos(t)','0.5*sin(t)',[-pi,0],'lr'};
         {6,5,'0.5*cos(t)','0.5*sin(t)',[0,pi],'lr'};
         {5,6,'lr'}};
domain11 = Domain(nodes,edges);

% 12 Disc with cusp inclusion
nodes = [1.5 0;0 0; 1 -1/2; 1 1/2];
edges = {{1,1,'1.5*cos(t)','1.5*sin(t)',[0,2*pi]}
         {2,3,'t','-t.^2/2',[0,1],'lr'}
         {3,4,'lr'}
         {4,1,'t','t.^4/2',[0,1],'lr'}};
domain12 = Domain(nodes,edges);

% 13 Square with a hole
nodes = [-1 -1; 1 -1 ; 1 1; -1 1;0.5 0];
edges = {{1,2},{2,3},{3,4},{4,1},{5,5,'0.5*cos(t)','0.5*sin(t)',[0,2*pi],'r'}};
domain13 = Domain(nodes,edges);

% 14 Disc with cusp inclusion
nodes = [1.5 0;0 0; 1 -1/2; 1 1/2];
edges = {{1,1,'1.5*cos(t)','1.5*sin(t)',[0,2*pi]}
         {2,3,'t','-t.^2/2',[0,1],'r'}
         {3,4,'r'}
         {4,1,'t','t.^4/2',[0,1],'r'}};
domain14 = Domain(nodes,edges);

% 15 Wave guide
nodes = [-3 -1;3 -1;3 1;-3 1;-2,-1;-2,1;2,-1;2,1];
edges = {{1,2},{2,3},{3,4},{4,1},{5,6,'lr'},{7,8,'lr'}};
domain15 = Domain(nodes,edges);




figure;
subplot 441; domain1.plot('labels');
subplot 442; domain2.plot('labels');
subplot 443; domain3.plot('labels');
subplot 444; domain4.plot('labels');
subplot 445; domain5.plot('labels');
subplot 446; domain6.plot('labels');
subplot 447; domain7.plot('labels');
subplot 448; domain8.plot('labels');
subplot 449; domain9.plot('labels');
subplot (4,4,10); domain10.plot('labels');
subplot (4,4,11); domain11.plot('labels');
subplot (4,4,12); domain12.plot('labels');
subplot (4,4,13); domain13.plot('labels');
subplot (4,4,14); domain14.plot('labels');
subplot (4,4,15); domain15.plot('labels');

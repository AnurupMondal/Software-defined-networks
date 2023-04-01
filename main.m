current_folder = pwd;   % Saving current folder address.
addpath(genpath(strcat(current_folder, '/Graphs')));   % Adding paths of folders to make code maintainable.
addpath(genpath(strcat(current_folder, '/No Link Failure')));
addpath(genpath(strcat(current_folder, '/Single Link Failure')));
addpath(genpath(strcat(current_folder, '/Multi Link Failure')));
addpath(genpath(strcat(current_folder, '/Shared')));

% =================================Graphs=============================

file_names = ["Graphs/Abilene.graphml", "Graphs/Agis.graphml", "Graphs/ATT.graphml", "Graphs/BTNA.graphml", "Graphs/Forthnet.graphml", "Graphs/Geant2012.graphml", "Graphs/Grnet.graphml", "Graphs/Iris.graphml", "Graphs/Navigata.graphml", "Graphs/Nsfnet.graphml", "Graphs/Sanet.graphml", "Graphs/Sprint.graphml", "Graphs/Surfnet.graphml"];
inputfile = fopen(file_names(11));
[topology, lat_long, nodenames, mat, P]= importGraphML(file_names(3)); %--Read GML file to find nodes and adjacency matrix-
s = size (mat);
n = s (1,2);
disp(n);

% ==========================No Link Failure=============================

x_axis = zeros(1, 10);
y_axis = zeros(2, 10);
k = 1;
for i = 2 : n / 2
  total = [];
  for j = 1 : 5
    [~, avg1] = RandomisedLatency(mat, n, i);
    [~, avg2] = GreedyCaseLatency(mat, n, i);
  end
  total(1) = avg1/5; % Average of 5 runs
  total(2) = avg2/5; % Average of 5 runs
  x_axis(k) = i;
  y_axis(: , k) = total;
  k = k + 1;
end
plot(x_axis, y_axis(1, :), x_axis, y_axis(2, :));

% ==========================Single Link Failure=========================
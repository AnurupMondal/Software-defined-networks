function [controllers] = OptimalAvgLatency(mat, nc, n)
% mat: adjacency matrix representing the network topology
% n: number of nodes in the network
% nc: number of controllers to be placed
  for i = 1 : nc
    for j = 1 : n
      if i == 1
        controllers(i, j) = 1;
      else
        controllers(i, j) = 0;
      end
    end
  end
end
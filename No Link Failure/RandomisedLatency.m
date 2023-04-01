function [controllers, avgLatency] = RandomisedLatency(mat, n, nc)
  % mat: adjacency matrix representing the network topology
  % n: number of nodes in the network
  % nc: number of controllers to be placed
  controllers = [];
  for i = 1:nc
      j = randi(n);
      while ismember(j, controllers)
          j = randi(n);
      end
      controllers = [controllers, j];
  end

  sprintf('%s', 'Controllers chosen:')
  disp(controllers);
  
  latency = zeros(nc, n);
  for i = 1:nc
      latency(i, :) = bellmanFord(n, mat, controllers(i));
  end
  sprintf('%s', 'Randomised Latency from each controllers:')
  disp(latency');
  avgLatency = sum(latency (:)) / n;
  end
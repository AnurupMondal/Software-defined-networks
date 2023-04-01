function [controllers, avgLatency] = GreedyCaseLatency(mat, n, nc)
% mat: adjacency matrix representing the network topology
% n: number of nodes in the network
% nc: number of controllers to be placed
controllers = [];
for i = 1:nc
    min_latency = zeros(1, n) + Inf;
    for j = 1:n
        if ismember(j, controllers)
            continue;
        end
        latency = bellmanFord(n, mat, j);
        if sum(latency) < sum(min_latency)
            min_latency = latency;
            closest_controller = j;
        end
    end
    if ~isempty(controllers)
        if ismember(closest_controller, controllers)
            continue;
        end
    end
    controllers(end+1) = closest_controller;
end

if isempty(controllers)
    disp('No controllers could be placed!');
    return;
end
sprintf('%s', 'Controllers chosen:')
disp(controllers);

latency = zeros(nc, n);
for i = 1:nc
    latency(i, :) = bellmanFord(n, mat, controllers(i));
end
sprintf('%s', 'Greedy Latency from each controllers:')
disp(latency');
avgLatency = sum(latency (:)) / n;
end

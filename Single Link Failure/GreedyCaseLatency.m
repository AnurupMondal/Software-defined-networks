function GreedyCaseLatency(mat, n, nc)
    % mat is the adjacency matrix
    % n is the total number of switches / access points
    % nc is the number of controllers to be placed

    controllers = [];   % array of all controllers

    for i = 1:nc
        min_latency = zeros(1, n) + Inf; % initialize entire matrix with infinity
        for j = 1:n
            if ismember(j, controllers) % skip if controller is already placed
                continue;
            end
            latency = bellmanFord(n, mat, j);
            if sum(latency) < sum(min_latency)
                min_latency = latency;
                closest_controller = j;
            end
        end
        if ~isempty(controllers)
            if ismember(closest_controller, controllers) % skip if controller is already placed
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
    
    sprintf('%s', 'Latency from each controllers:')
    disp(latency');
    
    sprintf('%s', 'Average case latency')
    disp(sum(latency (:)) / n);
end

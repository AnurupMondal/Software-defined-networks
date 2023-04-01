function avgCaseLatency(mat, n, nc)
    % mat is the adjacency matrix
    % n is the total number of switches / access points
    % nc is the number of controllers to be placed

    latency = zeros(nc, n);
    mem_latency = zeros(nc, n);     % memorize minimum latency from each optimally placed controller
    min_latency = zeros(1, n) + Inf;% initialize entire matrix with infinity
    c = zeros(1, nc);               % array of all controllers
    cc = zeros(1, nc);              % array of chosen controllers
    
    for i = 1 : n ^ 2
        c = mod(round(rand(1, nc) * 100), n); % randomly select "nc" number of controllers
        for j = 1 : nc
            latency(j, : ) = bellmanFord(n, mat, c(j));
        end
        if sum(latency) < sum(min_latency)
            min_latency(1, :) = sum(latency);
            mem_latency = latency;  % memorize the better latency
            cc = c;                 % change chosen controllers to new controllers
        end
    end
    
    sprintf('%s', 'Controllers chosen:')
    disp(cc);
    
    sprintf('%s', 'Latency from each controllers:')
    disp(mem_latency');
    
    sprintf('%s', 'Average case latency')
    %disp(sum(mem_latency, 'all') / n);
    disp(sum(mem_latency (:)) / n);
end

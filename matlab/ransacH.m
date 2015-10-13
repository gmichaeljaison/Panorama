function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% RANSAC - to get rid of outliers
    
    hmg = @(P) [P; ones(1, size(P,2))];

    P = locs1(matches(:,1), 1:2)';
    Q = locs2(matches(:,2), 1:2)';
    P = hmg(P);
    Q = hmg(Q);
    
    n = size(P,2);
    u = tol * 0.01; % prob of inlier
    
    minOutliers = n;
    inliers = zeros(1,n);
    
    i = 1;
    while (i < nIter)
        
        % choose 4 random points
        rnd = randperm(n, 4);
        p = P(1:2, rnd);
        q = Q(1:2, rnd);
        
        % fit each model and find inliers within the tolerance
        H = computeH(p,q);
        
        
        PH = H * Q;
        % divide by z (homogenous coord)
        PH = PH ./ repmat(PH(3,:), 3, 1);
        
        % distance between p and pH points
        d = sqrt(sum((P - PH) .^ 2));
        d = int16(d);
        
        % find the # of outliers
        nOutliers = numel(d(d > tol));
        if (minOutliers > nOutliers)
            minOutliers = nOutliers;
            
            inliers = (d <= tol);
            nInliers = numel(find(inliers));
            
            % break the loop if the probability of inliers are met
            if (u < nInliers / n)
                break;
            end
        end
        i = i + 1;
    end
    
    p = P(1:2, inliers);
    q = Q(1:2, inliers);
    bestH = computeH(p,q);

end


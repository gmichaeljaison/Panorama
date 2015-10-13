function [ locs, desc ] = computeBrief( im, locs, levels, compareX, compareY )
% compute brief descriptors using the test pairs(compareX,compareY) 
% and interest points(locs)

    % compute gaussian pyramid for the image
    sigma0 = 1;
    k = sqrt(2);
    gaussPyramid = createGaussianPyramid(im, sigma0, k, levels);

    patchSize = 9;
    bound = floor(patchSize / 2);
    desc = [];
    corners = [];
    for i = 1 : size(locs,1)
        % create a 9x9 patch around each loc point
        loc = locs(i,:,:);
        im_level = gaussPyramid(:,:, levels == loc(3));
        
        xrange = loc(1) - bound : loc(1) + bound;
        yrange = loc(2) - bound : loc(2) + bound;
        
        % corner check
        if ((any(xrange < 1 | xrange > size(im_level,2))) || ...
                (any(yrange < 1 | yrange > size(im_level,1))))
            corners = [corners; i];
            continue;
        end
        
        patch = im_level(yrange, xrange);
        
        descI = patch(compareX) < patch(compareY);
        desc = [desc; descI'];
    end
    
    locs = locs(~ismember(1:size(locs,1), corners), :);

end


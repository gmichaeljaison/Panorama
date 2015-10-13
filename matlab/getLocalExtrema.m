function [ locs ] = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)
%GETLOCALEXTREMA Find the local extrema for a point's neightbors in space
%and scale

    locs = [];
    
    for i = 1 : size(DoGPyramid,3)
        
        im = DoGPyramid(:,:,i);
        imp = PrincipalCurvature(:,:,i);
        
        % consider extrema around a point’s eight neighbors in space
        filMask = true(3);
        filMask(5) = 0;
        imFiltered = ordfilt2(im, 8, filMask);
        imMask = (im > imFiltered);
        imFiltered = im .* imMask;
        
        % consider 2 neighbor scales
        prevLayer = zeros(size(im)); 
        nextLayer = zeros(size(im));
        if (i > 1)
            prevLayer = abs(DoGPyramid(:,:,i-1) .* imMask);
        end
        if (i < size(DoGPyramid,3))
            nextLayer = abs(DoGPyramid(:,:,i+1) .* imMask);
        end
        totalMax = max(max(imFiltered, prevLayer), nextLayer);
        imFiltered = imFiltered .* (totalMax == imFiltered);
        
        
        % filter out points that does not meet threshold
        ind = find(abs(imFiltered) > th_contrast & abs(imp) < th_r);
        
        [y, x] = ind2sub(size(im), ind);
        
        loc = [x y repmat(DoGLevels(i), length(x), 1)];
        
        locs = [locs; loc];
    end

end

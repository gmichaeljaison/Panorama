function [ panoImg, H, locs1, locs2, matches ] = generatePanorama( img1, img2 )

%     img1 = imresize(img1, 0.3);
%     img2 = imresize(img2, 0.3);

    im1 = rgb2gray(img1);
    im2 = rgb2gray(img2);
    
    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);

    matches = briefMatch(desc1, desc2);
    
%     RANSAC:
%     log(1-p) / log(1- u^m)
%       p: prob at least a set of random sample does not include outlier
%       u: prob of inlier
%       m: min #points required
    tol = 4;
    u = tol * 0.01; % depends on tolerance
    nIter = log(1 - 0.99) / log(1 - u^4);
    H = ransacH(matches, locs1, locs2, nIter, 5);
    
    panoImg = imageStitching_noClip(img1, img2, H);

end

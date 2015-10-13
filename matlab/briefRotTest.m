im1 = imread('../data/model_chickenbroth.jpg');

im1 = rgb2gray(im1);

rotDegs = 0 : 10 : 180;
matchesCnt = zeros(size(rotDegs));

for i = 1 : numel(rotDegs)
    im2 = imrotate(im1, rotDegs(i));

    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);

    matches = briefMatch(desc1, desc2);
    
    matchesCnt(i) = size(matches,1);
end

bar(rotDegs, matchesCnt);

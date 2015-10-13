%%
patchWidth = 9;
descSize = 256;
[compareX, compareY] = makeTestPattern(patchWidth, descSize);
save('testPattern.mat', 'compareX', 'compareY');


%%

im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');

% im2 = imread('../data/model_chickenbroth.jpg');
% im1 = imread('../data/model_chickenbroth.jpg');
% im2 = imread('../data/chickenbroth_01.jpg');
% im1 = imread('../data/chickenbroth_01.jpg');

% im1 = imread('../data/pf_scan_scaled.jpg');
% im2 = imread('../data/pf_pile.jpg');

% im1 = imread('../data/taj1r.jpg');
% im2 = imread('../data/taj2r.jpg');

im1 = rgb2gray(im1);
im2 = rgb2gray(im2);

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

matches = briefMatch(desc1, desc2);

plotMatches(im1, im2, matches, locs1, locs2);

% figure; imshow(im1); hold on; scatter(locs1(:, 1),locs1(:,2), 20, 'r', 'filled');
% figure; imshow(im2); hold on; scatter(locs2(:, 1),locs2(:,2), 20, 'r', 'filled');


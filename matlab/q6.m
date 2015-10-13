tic;

% img1 = imread('../data/incline_L.png');
% img2 = imread('../data/incline_R.png');

% img1 = imread('../data/taj1r.jpg');
% img2 = imread('../data/taj2r.jpg');

% img1 = imread('../data/cam/cmu-out-1.jpg');
% img2 = imread('../data/cam/cmu-out-2.jpg');
% img3 = imread('../data/cam/cmu-out-3.jpg');

img1 = imread('../data/yosemite_test/yosemite1.jpg');
img2 = imread('../data/yosemite_test/yosemite2.jpg');
img3 = imread('../data/yosemite_test/yosemite3.jpg');

% img1 = imresize(img1, 0.3);
% img2 = imresize(img2, 0.3);
% img3 = imresize(img3, 0.3);

[panoImg, H1, locs1, locs2, matches1] = generatePanorama(img1, img2);

imshow(panoImg);

[panoImg2, H2, locs3, locs4, matches2] = generatePanorama(panoImg, img3);

imshow(panoImg2);

toc;

% imshow(panoImg); hold on; scatter(locs3(:,1),locs3(:,2),20,'g')
% imshow(panoImg); hold on; scatter(locs1(:,1),locs1(:,2),20,'g')
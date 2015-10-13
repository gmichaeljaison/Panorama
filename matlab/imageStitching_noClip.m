function [ panoImg ] = imageStitching_noClip( img1, img2, H )

% no cliping means: fitting the final panorama inside the fixed frame
% without hiding any pixels. (consider width as fixed, and change height)
    frame = [720 1280]; % rows cols
    
    hmg = @(P) [P; ones(1, size(P,2))];
    % divide by z
    divideZ = @(P) P ./ repmat(P(3,:), 3, 1);
    homoP = @(P) divideZ(H * P);
    
    [h1, w1, ~] = size(img1);
    [h2, w2, ~] = size(img2);
    
%     find the 4 corners of img2
    c = [0 0;  w2 0; w2 h2; 0 h2];
    c = hmg(c');
    cH = homoP(c);
    
%   Expected width and height
    expW = max(w1, max(cH(1,:))) - min(0, min(cH(1,:)));
    expH = max(h1, max(cH(2,:))) - min(0, min(cH(2,:)));

    sx = frame(2) / expW;
    frame(1) = expH * sx;
    frame = ceil(frame);
    
    ty = sx * -min(cH(2,:));
    
    M = [sx 0 0;...
         0 sx ty;...
         0 0  1];
     
    warp_im1 = warpH(img1, M, frame);
    warp_im2 = warpH(img2, M*H, frame);
    
%     masking 2 images
    panoImg = max(warp_im1, warp_im2);
    
%     panoImg = imfuse(warp_im1, warp_im2, 'blend');
end


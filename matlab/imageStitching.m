function [ panoImg ] = imageStitching(img1, img2, H )
    img2w = warpH(img2, H, [size(img1, 1), 2400]);
    
    panoImg = imfuse(img1, img2w, 'blend');
    imshow(panoImg);
end


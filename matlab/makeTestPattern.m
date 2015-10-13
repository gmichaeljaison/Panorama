function [ compareX, compareY ] = makeTestPattern( patchWidth, nbits )
% use gaussian distribution to randomly pick pairs of pixels
% compareX - (nbits x 1) vector
% compareY - (nbits x 1) vector

    % standard deviation
    nPixels = patchWidth ^ 2;
    sd = 1/25 * nPixels;
    
    compareX = round(sd * randn(nbits, 1) + nPixels/2);
    compareY = round(sd * randn(nbits, 1) + nPixels/2);

end

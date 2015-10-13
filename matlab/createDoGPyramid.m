function [ DoGPyramid, DoGLevels ] = createDoGPyramid( GaussianPyramid, levels )
%CREATEDOGPYRAMID Creates a DoG pyramid using Gaussian pyramid
% Dl(x, y, σl) = GPl − GPl−1

    DoGLevels = levels(2:length(levels));
    sizeG = size(GaussianPyramid);
    
    DoGPyramid = zeros(sizeG(1), sizeG(2), sizeG(3)-1);
    
    for i = 2 : sizeG(3)
        DoGPyramid(:,:,i-1) = GaussianPyramid(:,:,i) - GaussianPyramid(:,:,i-1);
    end

end

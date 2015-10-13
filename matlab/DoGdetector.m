function [ locs, GaussianPyramid ] = DoGdetector( im, sigma0, k, levels, th_contrast, th_r )

    GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);

    [dogPyramid, dLevels] = createDoGPyramid(GaussianPyramid, levels);

    pCurv = computePrincipalCurvature(dogPyramid);

    locs = getLocalExtrema(dogPyramid, dLevels, pCurv, th_contrast, th_r);

end

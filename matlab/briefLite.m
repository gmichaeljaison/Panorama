function [ locs, desc ] = briefLite( im )
    sigma0 = 1;
    k = sqrt(2);
    levels = [-1,0,1,2,3,4];

    theta_c = 0.03;
    theta_r = 12;
    

    [locs, gPyramid] = DoGdetector(im, sigma0, k, levels, theta_c, theta_r);
    
    load('testPattern.mat');
    
    [locs, desc] = computeBrief(im, locs, levels, compareX, compareY);
    
end

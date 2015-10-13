function [ PrincipalCurvature ] = computePrincipalCurvature( DoGPyramid )
%COMPUTEPRINCIPALCURVATURE Use Hessian matrix to find the principal
%curvature

    PrincipalCurvature = zeros(size(DoGPyramid));

    for i = 1 : size(DoGPyramid,3)
        im = DoGPyramid(:,:,i);
        [gx, gy] = gradient(im);
        [gxx, gxy] = gradient(gx);
        [~, gyy] = gradient(gy);
        
        % trace^2 of Hessian of every pixel
        TraceH = gxx + gyy;
        TraceH = TraceH .* TraceH;
        
        % Determinant of Hessian for every pixel
        DetH = (gxx .* gyy) - (gxy .* gxy);
        
        R = TraceH ./ DetH;
        
        PrincipalCurvature(:,:,i) = R;
    end


end


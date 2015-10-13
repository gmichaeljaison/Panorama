function [ H ] = computeH( P, Q )
% compute Homography matrix, given a set of 2D points
% P: 2xN N points in camera1
% Q: 2xN N points in camera2
% 
% Using the below linear system method,
% http://ags.cs.uni-kl.de/fileadmin/inf_ags/3dcv-ws11-12/3DCV_WS11-12_lec04.pdf

    N = size(P,2);
    z = zeros(1,3);
    
    hmg = @(P) [P; ones(1, size(P,2))];
    
    % make homogenous coordinates
    P = hmg(P);
    Q = hmg(Q);

    % construct matrix A such that Ah=0; h = [h1; h2; h3]
    A = zeros(2 * N, 9);
    for i = 1 : N
        p = P(:,i)';
        q = Q(:,i)';
        j = i*2 - 1;
        A(j,:) = [z -q p(2)*q];
        A(j+1,:) = [q z -p(1)*q];
    end
    
    % Solving system using SVD decomposition provides approximate solution
    % last column of V provides eigen vector with least eigen value
    [~,~,V] = svd(A);
    
    H = reshape(V(:,9), [3,3]);
    H = H';
end


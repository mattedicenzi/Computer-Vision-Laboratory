%Demutti Marco
%Dicenzi Matteo

%This function computes the cornerness map, and the corner region

%Input: sum of products of derivatives in x, sum of products of derivatives
%in x y, sum of products of derivative in y
%Output: R score map, corner regions
function [R_map, corner_reg] = corner_detection(Sx2, Sxy, Sy2)

[rr,cc]=size(Sx2);
corner_reg = zeros(rr,cc);
R_map = zeros(rr,cc);
k = 0.05;

for ii=1:rr
    for jj=1:cc
        % define at each pixel x,y the matrix M
        M = [Sx2(ii,jj), Sxy(ii,jj); Sxy(ii,jj), Sy2(ii,jj)];
        % compute the response of the detector at each pixel
        R = det(M) - k*(trace(M).^2);
        R_map(ii,jj) = R;
    end
end

% Compute max value of R map
M = max(R_map, [], 'all');

% Threshold for the corner regions using M
for ii=1:rr
    for jj=1:cc
        corner_reg(ii,jj) = (R_map(ii,jj) > 0.3 * M);
    end
end

end
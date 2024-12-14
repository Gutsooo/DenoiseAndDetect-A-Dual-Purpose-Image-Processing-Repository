function outputArg1 = salt_pepper(I,n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
pixel_num = numel(I(:,:,1));
m = fix(n*pixel_num);
idx = randperm(pixel_num, m);
k = fix(0.5*m);
idx1 = idx(1:k);
idx2 = idx(k+1:end);
I(idx1) = 255;
I(idx2) = 0;
outputArg1 =I;
end
clc; clear; close all

I_1 = im2double(imread("Q3\Cameraman.tif"));
I_2 = imresize(im2double(imread("Q3\Baboon.tif")),2);

for Alpha = 0 : .1 : 1
    J = Alpha * I_1   + (1-Alpha) * I_2 ;
    imshow(J);
    title([num2str(Alpha) 'x Cameraman + ' num2str(1-Alpha) 'x Baboon']);
    pause;
end
% 
% J = reshape(I_1,[],3846);
% imtool(I_1,[]);
% imtool(J,[]);

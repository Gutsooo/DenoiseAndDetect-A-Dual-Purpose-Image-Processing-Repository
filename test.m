%% part1
clc; clear; 
close all;
tic;
% num2str(i),
for i=0:1
name = strcat('Q2\Dataset\Templates\9_sC',".bmp");
% Removing noises and clarifying the image
I = imread(name);
imwrite(I,'Q2\Dataset\Templates\9_sC.tif');
% imtool(I);
imtool(I);
% imtool(I);
W = 3;
J = medfilt3(I,[W W W]);
im_pad = padarray(J, [floor(W/2) floor(W/2)]);
im_col = im2col(im_pad, [W W], 'sliding');
sorted_cols = sort(im_col, 1, 'ascend');
im_pad2 = padarray(I, [floor(W/2) floor(W/2)]);
im_col2 = im2col(im_pad2, [W W], 'sliding');
counter_76 = sum(im_col2() == 76);
counter_29 = sum(im_col2() == 29);
med_vector = sorted_cols(floor(W*W/2)+1, :);

for k = 1:size(im_col,2)
    if (counter_76(k)>1)
        med_vector(k) = 76;
    end
end

for k = 1:size(im_col,2)
    if (counter_29(k)>3)
        med_vector(k) = 29;
    end
end


out = col2im(med_vector, [W W], size(im_pad), 'sliding');
imtool(out);



end

toc;

name = strcat('Q2\Dataset\Images\im_28',".png");
% Removing noises and clarifying the image





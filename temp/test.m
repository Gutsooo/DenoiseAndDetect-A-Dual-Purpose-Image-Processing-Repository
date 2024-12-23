clc; clear; close all

% Removing noises and clarifying the image
I = imread('Q2\Dataset\Images\im_01.png');
% imtool(I);
I = rgb2gray(I);
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
    if (counter_29(k)>1)
        med_vector(k) = 29;
    end
end
 


out = col2im(med_vector, [W W], size(im_pad), 'sliding');
imtool(out);
% I = Grayscale2BW(I);
% J2 = Grayscale2BW(J2);
% out = Grayscale2BW(out);

keys = [0 1 2];
names = ["b" "m" "s"];
d = dictionary(keys,names);
keyss = [3 4 5];
namess = ["C" "L" "R"];
d2 = dictionary(keyss,namess);



for number = 0:9
    for ssize = 0:2
        for ratio = 3:5
            name = strcat(num2str(number) ,"_",d(ssize) ,d2(ratio) ,".tif");
            temp = im2double(imread(name));
            N = size(temp,1);
            im_pad = padarray(out, [floor(N/2) floor(N/2)],255);
            im_pad = im2double(im_pad);
            imtool(temp);
            imtool(im_pad);
            [rws, cls] = size(I);
            mag = im2double(uint8(zeros(size(I)))+255);
            % imtool(mag);
            pixel_radius = floor(N/2);
            
            for i = 1+pixel_radius:rws+pixel_radius
                for j = 1+pixel_radius : cls+pixel_radius
                    mag(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius) = sum(sum(abs(im_pad(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius)-temp)));
                end
            end
            
            imtool(mag,[]);
            num=min(min(mag));
            [x,y]=find(mag==num);
            x = x-1;
            y = y-1;


        end
    end
end


extractLBPFeatures


clc; clear; close all
tic
% Removing noises and clarifying the image
picture_number = "11";
picture_name = strcat("Q2\Dataset\Images\im_",picture_number,".png");
I = imread(picture_name);
I = rgb2gray(I);
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
    if (counter_29(k)>1)
        med_vector(k) = 29;
    end
end


path =pwd + "\Q2\Dataset\Templates\";
out = col2im(med_vector, [W W], size(im_pad), 'sliding');
imtool(out);
% is_circle = zeros(size(im_pad));
% is_circle(im_pad<80)=1;
% is_circle(im_pad>=80)=0;
% imtool(is_circle);

keys = [1 2 3];
names = ["b" "m" "s"];
d = dictionary(keys,names);
keyss = [1 2 3];
namess = ["C" "L" "R"];
d2 = dictionary(keyss,namess);
mins(1:10,1:9,3)=4000;


for number = 0:9
    count=0;
    for ssize = 1:3
        for ratio = 1:3
            name = strcat(path ,num2str(number) ,"_",d(ssize) ,d2(ratio) ,".tif");
%             name = "E:\lessons\term 6\Computer Vision\HWs\CV_HW_3\Q2\Dataset\Templates\0_bC.tif";
            temp = im2double(imread(name));
            N = size(temp,1);
            im_pad = padarray(out, [floor(N/2) floor(N/2)],255);
            is_circle = zeros(size(im_pad));
            is_circle(im_pad<80)=1;
            is_circle(im_pad>=80)=0;
            im_pad = im2double(im_pad);
%             imtool(temp);
%             imtool(is_circle);
            [rws, cls] = size(I);
            mag = im2double(uint8(zeros(size(I)))+255);
            % imtool(mag);
            pixel_radius = floor(N/2);
            
            for i = 1+pixel_radius:rws+pixel_radius
                for j = 1+pixel_radius : cls+pixel_radius
                    if is_circle(i,j)
                        mag(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius) = sum(sum(abs(im_pad(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius)-temp)));
                    else
                        mag(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius) = 2000;
                    end
                end
            end
            count=count+1;
%             imtool(mag,[]);
            mins(number+1,count,1) = min(min(mag));
            [x,y]=find(mag==mins(number+1,count));
            mins(number+1,count,2) = x-1;
            mins(number+1,count,3) = y-1;
        end
    end
end
toc
big_threshold = str2num(picture_number)+40;
large_threshold = str2num(picture_number)+33;
small_threshold = str2num(picture_number)+7;
if str2num(picture_number)>=75
    small_threshold = picture_number-6;
end
flags = zeros(10);
bigs = mins(:,1:3,:);
is_big_here = bigs(:,:,1)<big_threshold;
largs = mins(:,4:6,:);
is_large_here = largs(:,:,1)<large_threshold;
smalls = mins(:,7:9,:);
is_small_here = smalls(:,:,1)<small_threshold;

is_big_here=sum((is_big_here)');
is_large_here=sum((is_large_here)');
is_small_here=sum((is_small_here)');


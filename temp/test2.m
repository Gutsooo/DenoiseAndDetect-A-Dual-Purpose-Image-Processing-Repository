

% I = Grayscale2BW(I);
% J2 = Grayscale2BW(J2);
% out = Grayscale2BW(out);

clc; clear; close all
I = im2double(imread('Q2\Dataset\Templates\t0.tif'));
imshow(I);

 Gx = [-1 0 1;-2 0 2;-1 0 1];
 Gy = [-1 -2 -1; 0 0 0; 1 2 1];
 img = I;
 [rws, cls] = size(img);
 mag = zeros(rws, cls);

 for i = 1:rws - 2

    for j = 1 : cls - 2
        yemp = Gx.*img(i:i+2, j:j+2);
        temp = sum(Gx.*img(i:i+2, j:j+2));
        S1 = sum(sum(Gx.*img(i:i+2, j:j+2)));
        S2 = sum(sum(Gy.*img(i:i+2, j:j+2)));
        mag(i+1, j+1) = sqrt(S1^2 + S2^2);
    end
end
imtool(mag);


clc; clear; close all

I = imread('Q2\Dataset\Images\im_00.png');
% imtool(I);


% imtool(I);
I = rgb2gray(I);
W = 3;
J = medfilt3(I,[W W W]);
J2 = medfilt2(J,[W W]);
% J3 = medfilt3(J,[W W W]);
% imtool([I J J2]);
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
[centers, radii, metric] = imfindcircles(out,[25 47]);
centersStrong5 = centers(1:5,:); 
radiiStrong5 = radii(1:5);
metricStrong5 = metric(1:5);
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');

temp = im2double(imread('Q2\Dataset\Templates\5_bL.tif'));
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
        mag(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius) = sum(sum(temp - im_pad(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius)));
%         if abs(im_pad(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius)-temp) == 0
%             break;
%         end
%         S1 = sum(sum(Gx.*im_pad(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius)));
%         S2 = sum(sum(Gy.*im_pad(i:i+2, j:j+2)));
%         mag(i+1, j+1) = sqrt(S1^2 + S2^2);
    end
%     if abs(im_pad(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius)-temp) == 0
%         break; 
%     end
end
imtool(mag,[]);
number=min(min(mag));
[x,y]=find(mag==number);


clc; clear; close all

% Removing noises and clarifying the image
I = imread('Q2\Dataset\Images\im_00.png');
imtool(I);
[rws, cls] = size(I);
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
image = col2im(med_vector, [W W], size(im_pad), 'sliding');
BW = zeros(size(I))+1;
BW(image==29)=1;
BW(image==76)=0;

imtool([I image]);
imtool(BW,[]);


temp = im2double(imread('Q2\Dataset\Templates\m9c.tif'));
N = size(temp,1);
im_pad = padarray(image, [floor(N/2) floor(N/2)],255);
im_pad = im2double(im_pad);
imtool(temp);
imtool(im_pad);

mag = im2double(uint8(zeros(size(I)))+255);
% imtool(mag);
pixel_radius = floor(N/2);

for i = 1+pixel_radius:rws+pixel_radius
    for j = 1+pixel_radius : cls+pixel_radius
        mag(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius) = abs(sum(sum(im_pad(i-pixel_radius:i+pixel_radius, j-pixel_radius:j+pixel_radius)-temp)));
    end
end

imtool(mag,[]);
number=min(min(mag));
[x,y]=find(mag==number);
x = x-1;
y = y-1;


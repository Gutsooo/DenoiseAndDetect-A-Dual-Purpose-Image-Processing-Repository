%% part1
clc; clear; close all

I = im2double(imread('E:\lessons\term 6\Computer Vision\HWs\CV_HW_2\Q2\Image_1.tif'));
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

J = (R+G+B)/3;
Z = cat(3,J,J,J);

% J = salt_pepper(I,.5);
imtool(J,[]);
imtool([I Z],[]);



%%  part2
clc; clear; close all
path=pwd;

I_Baboon = imread([path '\Baboon.tif']);
I_Cameraman = imread([path '\Cameraman.tif']);
I_Peppers = imread([path '\Peppers.tif']);
I_Street = imread([path '\Street.bmp']);

I=I_Cameraman;
sum1=0;
sum2=0;
for i=0.3:0.2:0.9
    Noisy=imnoise(I,'salt & pepper',i);
    built_in=medfilt2(Noisy);
    output=kernel_generator(Noisy);
    disp(i*100);
    disp(strcat(num2str(psnr(built_in,I)),"          ",num2str(psnr(output,I))));
    sum1=sum1+(psnr(built_in,I));
    sum2=sum2+(psnr(output,I));
    figure,imshow([Noisy,built_in,output,I],[]);
end
K = im2double([Noisy output I]);
% mesh(K);
disp(strcat(num2str(sum1/4),"          ",num2str(sum2/4)));

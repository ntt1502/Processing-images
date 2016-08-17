close all;
clear;
clc;
I = imread('2a.jpg');
I1 = rgb2gray(I);

red = I(:,:,1);
green = I(:,:,2);
blue = I(:,:,3);
[dim_x, dim_y] = size(red);

level_red = graythresh(red);
level_green = graythresh(green);
level_blue = graythresh(blue);

red = im2bw(red, level_red);
green = im2bw(green, level_green);
blue = im2bw(blue, level_blue);

or = bitor(red,green);
or = bitor(or,blue);
yellow = bitand(red,green);
    
% figure; imshow(red);
% figure; imshow(green);
% figure; imshow(blue);
% figure; imshow(or);
imwrite(red,'redYellow.jpg')
imwrite(green,'greenYellow.jpg')
imwrite(blue,'blue.jpg')
imwrite(or,'or.jpg')
imwrite(yellow,'yellow.jpg')

red1 = red - yellow;
green1 = green - yellow;
%     imwrite(red1,'red.jpg')
%     imwrite(green1,'green.jpg')

yellow = bwareaopen(yellow,300);
    imwrite(yellow,'yellow.jpg');
%     figure;imshow(yellow);
    
red2 = bwareaopen(red1,300);
green2 = bwareaopen(green1,300);
blue2 = bwareaopen(blue,300);
    imwrite(red2,'red.jpg');
    imwrite(green2,'green.jpg');
    imwrite(blue2,'blue.jpg');
%     figure;imshow(red2);
%     figure;imshow(green2);

%--------------------------------
frame = imread('frame.jpg');
correlOr = normxcorr2(frame,or);
BW = im2bw(correlOr, 0.2);
figure;imshow(correlOr);

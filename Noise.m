function [watermarkedimagergb, psnr, mse] = Noise(I, watermarkedimagergb)

watermarkedimagergb = imnoise(watermarkedimagergb,'salt & pepper',0.1);
%watermarkedimagergb = imnoise(watermarkedimagergb,'gaussian',0,0.03);
%mask = fspecial('average',[5,5]);
%mask = [-1 -1 -1 ;-1 9 -1;-1 -1 -1];
% watermarkedimagergb = imfilter(watermarkedimagergb,mask);
% watermarkedimagergb(1:256, 1:512,1)=0;
% watermarkedimagergb (1:256, 1:512,2)=0;
% watermarkedimagergb (1:256, 1:512,3)=0;
% watermarkedimagergb= histeq(watermarkedimagergb, 256);

[psnr, mse] = metrics(I,watermarkedimagergb);
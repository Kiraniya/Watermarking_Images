function [psnr,mse] = metrics(I,Iwm)

pixel_max = 255;
I = I(:);      
Iwm = Iwm(:);    
I=double(I);
Iwm=double(Iwm);
x=(I-Iwm).^2;
mse=mean(x);
psnr=10*log10(((pixel_max).^2)/(mse));
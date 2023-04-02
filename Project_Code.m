clear;
clc;

embedding_strength = 2;
wavetype = 'haar';
decomposition_level = 9;
key = input("Enter user key value: ");

[filename1, pathname1] = uigetfile('*.*','Select the Cover image');
cover_image = imread(num2str(filename1));
cover_image = imresize(cover_image,[512 512]);
Mc=size(cover_image,1);
Nc=size(cover_image,2);

[filename2, pathname2] = uigetfile('*.*','Select the Watermark Text file');
watermark_txt = extractFileText(filename2);

encrypted_txt = Encrypt(watermark_txt,key);
encrypted_char = convertStringsToChars(encrypted_txt);
wm = dec2bin(encrypted_char)-'0';
[m,n] = size(wm);
wmo = reshape(wm,[1,m*n]);
watermark_matrix = zeros(1,Mc*Nc);
if m*n >= Mc*Nc
    watermark_matrix = wmo;
    m=Mc; n=Nc;
else
    watermark_matrix(1,1:m*n) = wmo;
end 
watermark_matrix = reshape(watermark_matrix,[Mc,Nc]);

ycbcr = rgb2ycbcr(cover_image);
y = ycbcr(:,:,1);
cb = ycbcr(:,:,2);
cr = ycbcr(:,:,3);

[watermarked_y, psnr, mse] = embedwm(y,watermark_matrix,wavetype,embedding_strength, decomposition_level,key);

watermarked_image_ycbcr = cat(3, watermarked_y,cb,cr);
watermarked_image_rgb = uint8(ycbcr2rgb(watermarked_image_ycbcr));

imwrite(watermarked_image_rgb, 'Watermarked.png');
filename4 = 'Watermarked.png';

figure
subplot(121)
imshow(cover_image); title('Cover Image')
subplot(122)
imshow(watermarked_image_rgb); title('Watermarked Image')
fprintf("\nWatermark text : %s\n",watermark_txt);
fprintf("\nEncrypted text : %s\n",encrypted_txt);
fprintf('\nPSNR value = %f\n',psnr);
fprintf('\nMSE value = %f\n',mse);

watermarked_image=imread(filename4); 
YCBCRr=rgb2ycbcr(watermarked_image); 
yr=YCBCRr(:,:,1); 

[extracted_wm]=recoverWM(yr, y, wavetype, embedding_strength, decomposition_level, key); 

extracted_wm = reshape(extracted_wm,[1,Mc*Nc]);
extracted_wm = extracted_wm(1,1:m*n);
extracted_wm = round(extracted_wm);
extracted_wm = reshape(extracted_wm,[m,n]);
ewm = round(abs(extracted_wm));
extracted_binary = int2str(ewm);
extracted_decimal = bin2dec(extracted_binary);
extracted_char = char(extracted_decimal);
extracted_txt = convertCharsToStrings(extracted_char);

extracted_watermark = Decrypt(extracted_txt,key);

[NCC,CC] = Correlation(ewm,wm);

fprintf("\nRecovered encrypted watermark : %s\n",extracted_txt);
fprintf("\nRecovered watermark : %s\n",extracted_watermark);
fprintf('\nCorrelation Coefficient value = %f\n',CC);
fprintf('\nNormalized Cross Correlation value = %f\n',NCC);

%{
if(watermark_txt==extracted_watermark)
    fprintf('yes');
end
%}
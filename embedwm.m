function [Iwm,psnr,mse] = embedwm(I,wmo,wname,k,N,key)

[c_ca,c_ch,c_cv,c_cd]=dwt2(I,wname);
[w_ca,w_ch,w_cv,w_cd]=dwt2(wmo,wname);
L = 2^N;
[Mc,Nc] = size(I);
rng(key);

pn = zeros(Mc/2,Nc/2);
for i=1:Mc*Nc/4
    pnsequence = round(2*(rand(Mc/L,Nc/L)-0.5));
    pn(i)= pnsequence;
end

c_ca = c_ca+pn+k*w_ca;
c_ch = c_ch + w_ch;
c_cv = c_cv + w_cv;
c_cd = c_cd + w_cd;

Iwm =  idwt2(c_ca,c_ch,c_cv,c_cd,wname);

Iwm = Iwm(:,:,1);

[psnr, mse] = metrics(I,Iwm);

end
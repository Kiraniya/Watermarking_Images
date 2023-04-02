function [Wmr]=recoverWM(Iwm, I, wname, k, N, key)

[c_ca,c_ch,c_cv,c_cd]=dwt2(I,wname);
[wm_ca,wm_ch,wm_cv,wm_cd]=dwt2(Iwm,wname);

L = 2^N;
[Mc,Nc] = size(I);
rng(key);

pn = zeros(Mc/2,Nc/2);
for i=1:Mc*Nc/4
    pnsequence = round(2*(rand(Mc/L,Nc/L)-0.5));
    pn(i)= pnsequence;
end

w_ca = (wm_ca - c_ca - pn)/(k);
w_ch = wm_ch - c_ch;
w_cv = wm_cv - c_cv;
w_cd = wm_cd - c_cd;

Wmr = idwt2(w_ca,w_ch,w_cv,w_cd,wname);

end
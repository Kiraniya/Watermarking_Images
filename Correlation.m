function [ncc,cc] = Correlation(ewm, wm)

cc = corr2(ewm,wm);
ncc=sum(sum(wm.*ewm))/(sqrt(sum(wm(:).^2))*sqrt(sum(ewm(:).^2)));

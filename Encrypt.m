function [etxt] = Encrypt(txt,key)

txt = convertStringsToChars(txt);
decimal_values = double(txt);

for i = 1:length(decimal_values)
    decimal_values(i)= mod(decimal_values(i)-32+key,(126-31))+32;
end
etxt = char(decimal_values);
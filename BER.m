function out =BER(x,y)
[row,~]=size(x);
temp = x-y;
num_temp = sum(sum(power(temp,2)));
out = num_temp/row;
end
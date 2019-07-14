function out = yingshe(x)
[row,column] = size(x);
reshape_x = reshape(x,[row*column,1]);
reshape_x_real = real(reshape_x);
reshape_x_imag = imag(reshape_x);
real_imag = [reshape_x_real;reshape_x_imag];
for i=1:1:row*column*2
    if real_imag(i,:)<0
       real_imag(i,:) = 0;
    else
       real_imag(i,:) = 1;
    end
end
 out = real_imag;
% out = reshape(real_imag,[row,column]);

end
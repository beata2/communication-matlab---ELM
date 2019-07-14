function [H_n_y,x_data] =data_gen(Frame_Len,N,BIT_num,Ex)
% H_n_y:[Frame_Len,N]     x_data:[Frame_Len,N] 

global M_antenna;
flag = 1;
for ii =1:1:N
% 	 产生data数据
     Temp_data = 1-2*rand(Frame_Len,BIT_num);
     x_data_bit(find(Temp_data >=0 )) = 1;
     x_data_bit(find(Temp_data <0 )) = 0;     %竖
     temp_x_data(find(x_data_bit ==0 )) = sqrt(0.5);
     temp_x_data(find(x_data_bit ==1 )) = -sqrt(0.5);
     temp_x_data_1=reshape(temp_x_data,Frame_Len,BIT_num);  % 竖
     x_data_1 = sqrt(Ex)*(temp_x_data_1(:,1) +1i*temp_x_data_1(:,2));    

    %过信道，加噪声
    H_Vector = 1/sqrt(M_antenna)*sqrt(0.5)*( randn(M_antenna,1) + 1i*randn(M_antenna,1) );      
    y_data = H_Vector*x_data_1.'+sqrt(0.5)*( randn(M_antenna,Frame_Len) + 1i*randn(M_antenna,Frame_Len) );    % [M,F]
    H_n_y_1 = (pinv(H_Vector)*y_data).';
    
    
    
    if flag==1;
        flag = 0;
        x_data = x_data_1;
        H_n_y = H_n_y_1;
    else
        x_data = [x_data,x_data_1];
        H_n_y = [H_n_y,H_n_y_1];
    end
end
end
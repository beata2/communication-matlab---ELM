clear all;
clc;
close all;
warning off; 

global M_antenna;
global Frame_Len;

%---参数设置----
Frame_Len =1;  %---数据帧长；
M_antenna =16;  %---接收天线数
BIT_num  = 2;
Training_L = 10^5;  % 训练组数
Test_L = 5*10^4;  % 测试组数
SNR = -10;
Hidden_node = Frame_Len*8;   %隐藏层节点数
Ex = 10^(0.1*SNR) ;

%训练数据产生
[H_n_y,train_data]= data_gen(Frame_Len,Training_L,BIT_num,Ex); 

% 网络结构-------------训练
W = rand(Hidden_node,Frame_Len)*2-1;
b = rand(Hidden_node,1);
B = b(:,ones(1,Training_L));  % 隐藏层阈值
H = sigmod(W * H_n_y +B);   % 隐藏层输出
B_ta = train_data*pinv(H);    % 输出层权置

%测试数据产生
[test_H_n_y,test_data]= data_gen(Frame_Len,Test_L,BIT_num,Ex);

% 网络结构-------------测试
B_C = b(:,ones(1,Test_L));   % 隐藏层阈值
H_R = sigmod(W * test_H_n_y +B_C);
data_R = B_ta*H_R;

% BER
test_x_bit = yingshe(test_data);
restore_x_bit = yingshe(data_R);
BER = BER(test_x_bit,restore_x_bit)
clear all;
clc;
close all;
warning off; 

global M_antenna;
global Frame_Len;

%---��������----
Frame_Len =1;  %---����֡����
M_antenna =16;  %---����������
BIT_num  = 2;
Training_L = 10^5;  % ѵ������
Test_L = 5*10^4;  % ��������
SNR = -10;
Hidden_node = Frame_Len*8;   %���ز�ڵ���
Ex = 10^(0.1*SNR) ;

%ѵ�����ݲ���
[H_n_y,train_data]= data_gen(Frame_Len,Training_L,BIT_num,Ex); 

% ����ṹ-------------ѵ��
W = rand(Hidden_node,Frame_Len)*2-1;
b = rand(Hidden_node,1);
B = b(:,ones(1,Training_L));  % ���ز���ֵ
H = sigmod(W * H_n_y +B);   % ���ز����
B_ta = train_data*pinv(H);    % �����Ȩ��

%�������ݲ���
[test_H_n_y,test_data]= data_gen(Frame_Len,Test_L,BIT_num,Ex);

% ����ṹ-------------����
B_C = b(:,ones(1,Test_L));   % ���ز���ֵ
H_R = sigmod(W * test_H_n_y +B_C);
data_R = B_ta*H_R;

% BER
test_x_bit = yingshe(test_data);
restore_x_bit = yingshe(data_R);
BER = BER(test_x_bit,restore_x_bit)
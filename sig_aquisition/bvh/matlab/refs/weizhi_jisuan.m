function [ Q,L,RLa ] = weizhi_jisuan( xx ,data,data0)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   xxΪ֡����dataΪ��������ݣ�data0Ϊ���ڵ�ռ�����λ�ã�
data
B=data;
C=B';
D=C(:,xx);  %ȡ�����˶������еĵ�xx֡���޸������л�֡����
data0
B0=data0;
C0=B0';
P0=C0(:,xx);  %ȡ�����˶������еĵ�һ֡���޸������л�֡����

s1 = [];
for i=1:3:54                                        %��Z,X,Y����ת�ǵ�Z��������ѡȡ
    
    b1=D(i,:);
    s1 = [s1,b1]
    
end
R=s1'


s2 = [];
for i=2:3:54                                        %��Z,X,Y����ת�ǵ�X��������ѡȡ
    
    b2=D(i,:);
    s2 = [s2,b2]
    
end
P=s2'


% disp(F)
s3 = [];                                            %��Z,X,Y����ת�ǵ�Y��������ѡȡ
for i=3:3:54
    
    b3=D(i,:);
    s3 = [s3,b3]
    
end
Y=s3'
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����Žڵ������׽ڵ����άλ������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r=R(1,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(1,:)';
y=Y(1,:)';
M0 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];    %������ڵ㣨�Ų�������ת����

r=R(2,:)';                                       %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵڶ������ݣ����ǵڶ����ؽڵ����ת������
p=P(2,:)';
y=Y(2,:)';
M1 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];    %������ڵ㣨�Ų�������ת����

r=R(3,:)';                                       %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ��������ݣ����ǵ������ؽڵ����ת������
p=P(3,:)';
y=Y(3,:)';
M2 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];    %������ڵ㣨�Ų�������ת����

r=R(4,:)';                                         %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ��ĸ����ݣ����ǵ��ĸ��ؽڵ����ת������
p=P(4,:)';
y=Y(4,:)';
M3 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];


L1 = [-9.625 -1.639 0]';                             %���ŵ����ƫ������
L2 = [0 -43.12 0]';                           %��ϥ�����ƫ������
L3 = [0 -43.12 0]';                             %���׵����ƫ������

O1 = M0*(M1*L1);                             %������Ը��ڵ�Ĺ�������ϵ��ƫ�ƣ��ݹ��������
O2 = M0*(M1*(M2*L2));                        %��ϥ������ŵĹ�������ϵ���꣨�ݹ��������
O3 = M0*(M1*(M2*(M3*L3)));                   %���������ϥ�Ĺ�������ϵ���꣨�ݹ��������

%P0 = [D0(1:xx) D0(2:xx) D0(3:xx)]';                   %���ڵ���������ꣻ��ÿ֡���޸ģ�
P1 = P0 + O1;                                %���Žڵ���������ꣻ
P2 = P0 + O1 + O2;                           %��ϥ�ڵ���������ꣻ
P3 = P0 + O1 +O2 + O3;                       %���׽ڵ���������ꣻ

% disp(P0);
% disp(P1);
% disp(P2);
% disp(P3);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%�����Žڵ������׽ڵ�λ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=R(5,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(5,:)';
y=Y(5,:)';
M4 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %���Źؽ���ת����

r=R(6,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(6,:)';
y=Y(6,:)';
M5 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %��ϥ�ؽ���ת����

r=R(7,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(7,:)';
y=Y(7,:)';
M6 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %���׹ؽ���ת����


L4 = [9.625 -1.639 0]';                             %���ŵ����ƫ������
L5 = [0 -43.12 0]';                           %��ϥ�����ƫ������
L6 = [0 -43.12 0]';                             %���׵����ƫ������

O4 = M0*(M4*L4);                             %������Ը��ڵ�Ĺ�������ϵ��ƫ�ƣ��ݹ��������
O5 = M0*(M4*(M5*L5));                        %��ϥ������ŵĹ�������ϵ���꣨�ݹ��������
O6 = M0*(M4*(M5*(M6*L6)));                   %���������ϥ�Ĺ�������ϵ���꣨�ݹ��������

% P0 = [-0.3952 40.1746 0.2306]';                   %���ڵ���������ꣻ
P4 = P0 + O4;                                %���Žڵ���������ꣻ
P5 = P0 + O4 + O5;                           %��ϥ�ڵ���������ꣻ
P6 = P0 + O4 +O5 + O6;                       %���׽ڵ���������ꣻ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%�����Źؽ���ͷ����λ��%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=R(8,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(8,:)';
y=Y(8,:)';
M7 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %��׵�ؽ���ת�������������Ҽ������󣬼�׵��ͷ���õ���

r=R(9,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(9,:)';
y=Y(9,:)';
M8 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %�󾱹ؽ���ת����

r=R(10,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(10,:)';
y=Y(10,:)';
M9 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %���ؽ���ת����

L7 = [0 24.755 0]';                             %��׵�����ƫ�� ��
L8 = [0 10.713 0]';                           %�󾱵����ƫ������
L9 = [0 9.72 0]';                           %�������ƫ������

O7 = M0*(M7*L7);                             %��׵��Ը��ڵ�Ĺ�������ϵ��ƫ�ƣ��ݹ��������
O8 = M0*(M7*(M8*L8));                        %��������ŵĹ�������ϵ���꣨�ݹ��������
O9 = M0*(M7*(M8*(M9*L9)));                   %��������ϥ�Ĺ�������ϵ���꣨�ݹ��������
% O10 = M0*(M7*(M8*(M9*(M10*L10))));           %������Ը��ڵ�Ĺ�������ϵ��ƫ�ƣ��ݹ��������
% O11 = M0*(M7*(M8*(M9*(M10*(M11*L11)))));     %����������ŵĹ�������ϵ���꣨�ݹ��������


% P0 = [-0.3952 40.1746 0.2306]';                   %���ڵ���������ꣻ
P7 = P0 + O7;                                %��׵�ڵ���������ꣻ
P8 = P0 + O7 + O8;                           %�󾱽ڵ���������ꣻ
P9 = P0 + O7 + O8 + O9;                      %���ڵ���������ꣻ
% P10 = P0 + O7 + O8 + O9 + O10;               %����ڵ���������ꣻ
% P11 = P0 + O7 + O8 + O9 + O10 + O11;         %����ڵ���������ꣻ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%�����Źؽ��������λ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=R(11,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(11,:)';
y=Y(11,:)';
M10 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %�Ҿ��ؽ���ת����

r=R(12,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(12,:)';
y=Y(12,:)';
M11 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %�Ҽ�ؽ���ת����

r=R(13,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(13,:)';
y=Y(13,:)';
M12 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %����ؽ���ת����

r=R(14,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(14,:)';
y=Y(14,:)';
M13 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %����ؽ���ת����

%L10 = [-3.275 7 0]';                             %��׵�����ƫ��
L10 = [-15 7 0]';
L11 = [-13.1 0 0]';                           %�󾱵����ƫ������
%L12 = [-27.25 0 0]';                             %�Ҽ�����ƫ������
L12 = [-20 0 0]'; 
%L13 = [-26.75 0 0]';                             %��������
L13 = [-10 0 0]'; 
O10 = M0*(M7*(M10*L10));                             %�Ҿ���Ը��ڵ�Ĺ�������ϵ��ƫ�ƣ��ݹ��������
O11 = M0*(M7*(M10*(M11*L11)));                       %�Ҽ�������ŵĹ�������ϵ���꣨�ݹ��������
O12 = M0*(M7*(M10*(M11*(M12*L12))));                 %���������ϥ�Ĺ�������ϵ���꣨�ݹ��������
O13 = M0*(M7*(M10*(M11*(M12*(M13*L13)))));           %������Ը��ڵ�Ĺ�������ϵ��ƫ�ƣ��ݹ��������


% P0 = [-0.3952 40.1746 0.2306]';                   %���ڵ���������ꣻ
P10 = P0 + O7 + O10;                                %�Ҿ��ڵ���������ꣻ
P11 = P0 + O7 + O10 + O11;                          %�Ҽ�ڵ���������ꣻ
P12 = P0 + O7 + O10 + O11 + O12;                    %����ڵ���������ꣻ
P13 = P0 + O7 + O10 + O11 + O12 + O13;              %����ڵ���������ꣻ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%�Źؽ�������ڵ�λ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=R(15,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(15,:)';
y=Y(15,:)';
M14 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %���ؽ���ת����

r=R(16,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(16,:)';
y=Y(16,:)';
M15 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %ͷ����ת����

r=R(17,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(17,:)';
y=Y(17,:)';
M16 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %ͷ����ת����

r=R(18,:)';                                     %��ѡ����ѡȡ����3�����飨��Z,X,Y�ᣩ�еĵ�һ�����ݣ����ǵ�һ���ؽڵ����ת������
p=P(18,:)';
y=Y(18,:)';
M17 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %ͷ����ת����

%L14 = [3.275 7.142 0]';                             %���ؽڵ����ƫ��
L14 = [15 7.142 0]'; 
L15 = [13.1 0 0]';
%L16 = [27.75 0 0]';                             %���ؽڵ����ƫ��
L16 = [20 0 0]';  
%L17 = [26.75 0 0]';                               %ͷ�������ƫ������
L17 = [10 0 0]'; 
O14 = M0*(M7*(M14*L14));                             %���ؽ���Ը��ڵ�Ĺ�������ϵ��ƫ�ƣ��ݹ��������
O15 = M0*(M7*(M14*(M15*L15)));
O16 = M0*(M7*(M14*(M15*(M16*L16))));                             %���ؽ���Ը��ڵ�Ĺ�������ϵ��ƫ�ƣ��ݹ��������
O17 = M0*(M7*(M14*(M15*(M16*(M17*L17)))));      %ͷ��������ŵĹ�������ϵ���꣨�ݹ��������

P14 = P0 + O7 + O14;                                %���ؽڵ���������ꣻ
P15 = P0 + O7 + O14 + O15;
P16 = P0 + O7 + O14 + O15 + O16;                                %���ؽڵ���������ꣻ
P17 = P0 + O7 + O14 + O15 + O16 + O17;                          %ͷ�����������ꣻ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(P0);                         %�Žڵ�����
disp(P1);                         %���Žڵ�����
disp(P2);                         %��ϥ�ڵ�����
disp(P3);                         %���׽ڵ�����
disp(P4);                         %���Žڵ�����
disp(P5);                         %��ϥ�ڵ�����
disp(P6);                         %���׽ڵ�����
disp(P7);                         %��׵�ڵ�����
disp(P8);                         %�󾱽ڵ�����
disp(P9);                         %���ڵ�����
disp(P10);                        %����ڵ�����
disp(P11);                        %����ڵ�����
disp(P12);                        %�Ҿ��ڵ�����
disp(P13);                        %�Ҽ�ڵ�����
disp(P14);                        %����ڵ�����
disp(P15);                        %����ڵ�����
disp(P16);                        %���ڵ�����
disp(P17);                        %ͷ������

%%
%%%%%%%%%%%%���Ǽ�ͼ%%%%%%%%%%%%%%

x = [P0(1,:)  P1(1,:)  P2(1,:)   P3(1,:)];
y = [P0(2,:)  P1(2,:)  P2(2,:)   P3(2,:)];
z = [P0(3,:)  P1(3,:)  P2(3,:)   P3(3,:)];            %��������

x1 = [P0(1,:)  P4(1,:)  P5(1,:)   P6(1,:)];
y1 = [P0(2,:)  P4(2,:)  P5(2,:)   P6(2,:)];
z1 = [P0(3,:)  P4(3,:)  P5(3,:)   P6(3,:)];           %��������


x2 = [P0(1,:)  P7(1,:)  P8(1,:)   P9(1,:)];
y2 = [P0(2,:)  P7(2,:)  P8(2,:)   P9(2,:)];
z2 = [P0(3,:)  P7(3,:)  P8(3,:)   P9(3,:)];     %����ͷ��

x3 = [P0(1,:)  P7(1,:)  P10(1,:)   P11(1,:)  P12(1,:)  P13(1,:)];
y3 = [P0(2,:)  P7(2,:)  P10(2,:)   P11(2,:)  P12(2,:)  P13(2,:)];
z3 = [P0(3,:)  P7(3,:)  P10(3,:)   P11(3,:)  P12(3,:)  P13(3,:)];                 %��������

x4 = [P0(1,:)  P7(1,:)  P14(1,:)   P15(1,:)  P16(1,:)  P17(1,:)];
y4 = [P0(2,:)  P7(2,:)  P14(2,:)   P15(2,:)  P16(2,:)  P17(2,:)];
z4 = [P0(3,:)  P7(3,:)  P14(3,:)   P15(3,:)  P16(3,:)  P17(3,:)];                   %��������
% figure(xx)
% %%%%%���ƴ��ڹؼ�֡�ĹǼ�ͼ
%
if xx == 10||xx == 170||xx == 330||xx == 450  %����ؼ�֡����λ��
    plot3(x,z,y,'ro-',x1,z1,y1,'ro-',x2,z2,y2,'ro-',x3,z3,y3,'ro-',x4,z4,y4,'ro-','lineWidth',2,'markerSize',5);
    set(gca,'FontWeight','bold','fontSize',15)
     hold on
else
    plot3(x,z,y,'ko-',x1,z1,y1,'ko-',x2,z2,y2,'ko-',x3,z3,y3,'ko-',x4,z4,y4,'ko-','lineWidth',1,'markerSize',5);
    set(gca,'FontWeight','bold','fontSize',15)
end
% title('�¶�')
  hold on
%plot3(x,z,y,'bo-',x1,z1,y1,'bo-',x2,z2,y2,'bo-',x3,z3,y3,'bo-',x4,z4,y4,'bo-');
 axis([-300 300 -1500 1500 -25 200]);
 view(185,5);
grid on;
%%
%%%%%%%%�������ƹǼ�ͼ
%  plot3(x,z,y,'ko-',x1,z1,y1,'ko-',x2,z2,y2,'ko-',x3,z3,y3,'ko-',x4,z4,y4,'ko-','lineWidth',1,'markerSize',5);
%     set(gca,'FontWeight','bold','fontSize',15)
%  hold on
% %plot3(x,z,y,'bo-',x1,z1,y1,'bo-',x2,z2,y2,'bo-',x3,z3,y3,'bo-',x4,z4,y4,'bo-');
%  axis([-300 300 -1500 1500 -25 200]);
% 
% %  title(['��',num2str(xx),'֡�Ǽ�ͼ']);
% view(185,5);
% grid on;
%%
%%%�����μнǼ��㲿��%%%
Bcenter = P0-P7;
B1 = P1-P2;   %�Ҵ��ȹǶ�
B2 = P2-P3;   %�����ȹǶ�
B3 = P4-P5;   %����ȹǶ�
B4 = P4-P6;   %�����ȹǶ�
B5 = P10-P11; %�Ҵ�۹Ƕ�
B6 = P11-P12; %���±۹Ƕ�
B7 = P14-P15; %���۹Ƕ�
B8 = P15-P16; %���±۹Ƕ�
BB = [B1,B2,B3,B4,B5,B6,B7,B8];
% disp(BB)
% disp(B1)
% % disp(Bcenter)
% disp(BB(1))
Q = [];
for i =1:8
    angi = acosd((BB(:,i)'*Bcenter)/(norm(BB(:,i))*norm(Bcenter)));
    Q = [Q,angi];
    
end
Q = Q';

%%
%%%%%%%%%%%%%�Ҵ������С�ۣ����ۺ���С��֮��ļнǼ���%%%%%%%%%%%%%
AngleRLsim = acosd((B1(:,1)'*B2(:,1))/(norm(B1(:,1))*norm(B2(:,1))));
AngleLLsim = acosd((B3(:,1)'*B4(:,1))/(norm(B3(:,1))*norm(B4(:,1))));
AngleRsim = acosd((B5(:,1)'*B6(:,1))/(norm(B5(:,1))*norm(B6(:,1))));
AngleLsim = acosd((B7(:,1)'*B8(:,1))/(norm(B7(:,1))*norm(B8(:,1))));
RLa = [AngleRLsim;AngleLLsim;AngleRsim;AngleLsim];
%%
%%%%%%�����Ƕ��е������Ĺؽڵ�ľ���%%%%%%%
Pm1 = (P1+P2)/2;
Pm2 = (P2+P3)/2;
Pm3 = (P4+P5)/2;
Pm4 = (P5+P6)/2;
Pm5 = (P11+P12)/2;
Pm6 = (P12+P13)/2;
Pm7 = (P15+P16)/2;
Pm8 = (P16+P17)/2;
PM= [Pm1,Pm2,Pm3,Pm4,Pm5,Pm6,Pm7,Pm8];
L = [];
for i = 1:8
    ll = sqrt((PM(1,i)-P0(1))^2+(PM(2,i)-P0(2))^2+(PM(3,i)-P0(3))^2);
    L = [L,ll];

end
L = L';
end
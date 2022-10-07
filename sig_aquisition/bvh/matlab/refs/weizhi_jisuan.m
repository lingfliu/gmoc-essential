function [ Q,L,RLa ] = weizhi_jisuan( xx ,data,data0)
%UNTITLED 此处显示有关此函数的摘要
%   xx为帧数，data为导入的数据，data0为根节点空间坐标位置；
data
B=data;
C=B';
D=C(:,xx);  %取整个运动序列中的第xx帧（修改数字切换帧数）
data0
B0=data0;
C0=B0';
P0=C0(:,xx);  %取整个运动序列中的第一帧（修改数字切换帧数）

s1 = [];
for i=1:3:54                                        %对Z,X,Y轴旋转角的Z轴数据做选取
    
    b1=D(i,:);
    s1 = [s1,b1]
    
end
R=s1'


s2 = [];
for i=2:3:54                                        %对Z,X,Y轴旋转角的X轴数据做选取
    
    b2=D(i,:);
    s2 = [s2,b2]
    
end
P=s2'


% disp(F)
s3 = [];                                            %对Z,X,Y轴旋转角的Y轴数据做选取
for i=3:3:54
    
    b3=D(i,:);
    s3 = [s3,b3]
    
end
Y=s3'
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%计算髋节点至左踝节点的三维位置坐标%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r=R(1,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(1,:)';
y=Y(1,:)';
M0 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];    %计算根节点（髋部）的旋转矩阵；

r=R(2,:)';                                       %挑选出以选取出的3个数组（即Z,X,Y轴）中的第二个数据，即是第二个关节点的旋转角数据
p=P(2,:)';
y=Y(2,:)';
M1 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];    %计算根节点（髋部）的旋转矩阵；

r=R(3,:)';                                       %挑选出以选取出的3个数组（即Z,X,Y轴）中的第三个数据，即是第三个关节点的旋转角数据
p=P(3,:)';
y=Y(3,:)';
M2 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];    %计算根节点（髋部）的旋转矩阵；

r=R(4,:)';                                         %挑选出以选取出的3个数组（即Z,X,Y轴）中的第四个数据，即是第四个关节点的旋转角数据
p=P(4,:)';
y=Y(4,:)';
M3 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];


L1 = [-9.625 -1.639 0]';                             %左髋的相对偏移量；
L2 = [0 -43.12 0]';                           %左膝的相对偏移量；
L3 = [0 -43.12 0]';                             %左踝的相对偏移量；

O1 = M0*(M1*L1);                             %左髋相对根节点的惯性坐标系的偏移（递归迭代）；
O2 = M0*(M1*(M2*L2));                        %左膝相对左髋的惯性坐标系坐标（递归迭代）；
O3 = M0*(M1*(M2*(M3*L3)));                   %左踝相对左膝的惯性坐标系坐标（递归迭代）；

%P0 = [D0(1:xx) D0(2:xx) D0(3:xx)]';                   %根节点的世界坐标；（每帧需修改）
P1 = P0 + O1;                                %左髋节点的世界坐标；
P2 = P0 + O1 + O2;                           %左膝节点的世界坐标；
P3 = P0 + O1 +O2 + O3;                       %左踝节点的世界坐标；

% disp(P0);
% disp(P1);
% disp(P2);
% disp(P3);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%计算髋节点至右踝节点位置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=R(5,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(5,:)';
y=Y(5,:)';
M4 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %右髋关节旋转矩阵

r=R(6,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(6,:)';
y=Y(6,:)';
M5 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %右膝关节旋转矩阵

r=R(7,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(7,:)';
y=Y(7,:)';
M6 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %右踝关节旋转矩阵


L4 = [9.625 -1.639 0]';                             %右髋的相对偏移量；
L5 = [0 -43.12 0]';                           %右膝的相对偏移量；
L6 = [0 -43.12 0]';                             %右踝的相对偏移量；

O4 = M0*(M4*L4);                             %右髋相对根节点的惯性坐标系的偏移（递归迭代）；
O5 = M0*(M4*(M5*L5));                        %右膝相对左髋的惯性坐标系坐标（递归迭代）；
O6 = M0*(M4*(M5*(M6*L6)));                   %右踝相对左膝的惯性坐标系坐标（递归迭代）；

% P0 = [-0.3952 40.1746 0.2306]';                   %根节点的世界坐标；
P4 = P0 + O4;                                %右髋节点的世界坐标；
P5 = P0 + O4 + O5;                           %右膝节点的世界坐标；
P6 = P0 + O4 +O5 + O6;                       %右踝节点的世界坐标；
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%计算髋关节至头部的位置%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=R(8,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(8,:)';
y=Y(8,:)';
M7 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %脊椎关节旋转矩阵（左颈至左腕，右肩至右腕，脊椎至头均用到）

r=R(9,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(9,:)';
y=Y(9,:)';
M8 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %左颈关节旋转矩阵

r=R(10,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(10,:)';
y=Y(10,:)';
M9 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %左肩关节旋转矩阵

L7 = [0 24.755 0]';                             %脊椎的相对偏移 ；
L8 = [0 10.713 0]';                           %左颈的相对偏移量；
L9 = [0 9.72 0]';                           %左肩的相对偏移量；

O7 = M0*(M7*L7);                             %脊椎相对根节点的惯性坐标系的偏移（递归迭代）；
O8 = M0*(M7*(M8*L8));                        %左颈相对左髋的惯性坐标系坐标（递归迭代）；
O9 = M0*(M7*(M8*(M9*L9)));                   %左肩相对左膝的惯性坐标系坐标（递归迭代）；
% O10 = M0*(M7*(M8*(M9*(M10*L10))));           %左肘相对根节点的惯性坐标系的偏移（递归迭代）；
% O11 = M0*(M7*(M8*(M9*(M10*(M11*L11)))));     %左腕相对左髋的惯性坐标系坐标（递归迭代）；


% P0 = [-0.3952 40.1746 0.2306]';                   %根节点的世界坐标；
P7 = P0 + O7;                                %脊椎节点的世界坐标；
P8 = P0 + O7 + O8;                           %左颈节点的世界坐标；
P9 = P0 + O7 + O8 + O9;                      %左肩节点的世界坐标；
% P10 = P0 + O7 + O8 + O9 + O10;               %左肘节点的世界坐标；
% P11 = P0 + O7 + O8 + O9 + O10 + O11;         %左腕节点的世界坐标；
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%计算髋关节至右腕的位置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=R(11,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(11,:)';
y=Y(11,:)';
M10 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %右颈关节旋转矩阵

r=R(12,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(12,:)';
y=Y(12,:)';
M11 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %右肩关节旋转矩阵

r=R(13,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(13,:)';
y=Y(13,:)';
M12 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %右肘关节旋转矩阵

r=R(14,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(14,:)';
y=Y(14,:)';
M13 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %右腕关节旋转矩阵

%L10 = [-3.275 7 0]';                             %脊椎的相对偏移
L10 = [-15 7 0]';
L11 = [-13.1 0 0]';                           %左颈的相对偏移量；
%L12 = [-27.25 0 0]';                             %右肩的相对偏移量；
L12 = [-20 0 0]'; 
%L13 = [-26.75 0 0]';                             %右肘的相对
L13 = [-10 0 0]'; 
O10 = M0*(M7*(M10*L10));                             %右颈相对根节点的惯性坐标系的偏移（递归迭代）；
O11 = M0*(M7*(M10*(M11*L11)));                       %右肩相对左髋的惯性坐标系坐标（递归迭代）；
O12 = M0*(M7*(M10*(M11*(M12*L12))));                 %右肘相对左膝的惯性坐标系坐标（递归迭代）；
O13 = M0*(M7*(M10*(M11*(M12*(M13*L13)))));           %右腕相对根节点的惯性坐标系的偏移（递归迭代）；


% P0 = [-0.3952 40.1746 0.2306]';                   %根节点的世界坐标；
P10 = P0 + O7 + O10;                                %右颈节点的世界坐标；
P11 = P0 + O7 + O10 + O11;                          %右肩节点的世界坐标；
P12 = P0 + O7 + O10 + O11 + O12;                    %右肘节点的世界坐标；
P13 = P0 + O7 + O10 + O11 + O12 + O13;              %右腕节点的世界坐标；
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%髋关节至左腕节点位置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=R(15,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(15,:)';
y=Y(15,:)';
M14 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %颈关节旋转矩阵

r=R(16,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(16,:)';
y=Y(16,:)';
M15 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %头部旋转矩阵

r=R(17,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(17,:)';
y=Y(17,:)';
M16 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %头部旋转矩阵

r=R(18,:)';                                     %挑选出以选取出的3个数组（即Z,X,Y轴）中的第一个数据，即是第一个关节点的旋转角数据
p=P(18,:)';
y=Y(18,:)';
M17 = [cosd(r)*cosd(y)-sind(r)*sind(p)*sind(y) -sind(r)*cosd(p) cosd(r)*sind(y)+sind(r)*sind(p)*cosd(y);...
    sind(r)*cosd(y)+cosd(r)*sind(p)*sind(y) cosd(r)*cosd(p) sind(r)*sind(y)-cosd(r)*sind(p)*cosd(y);...
    -cosd(p)*sind(y) sind(p) cosd(p)*cosd(y)];       %头部旋转矩阵

%L14 = [3.275 7.142 0]';                             %颈关节的相对偏移
L14 = [15 7.142 0]'; 
L15 = [13.1 0 0]';
%L16 = [27.75 0 0]';                             %颈关节的相对偏移
L16 = [20 0 0]';  
%L17 = [26.75 0 0]';                               %头部的相对偏移量；
L17 = [10 0 0]'; 
O14 = M0*(M7*(M14*L14));                             %颈关节相对根节点的惯性坐标系的偏移（递归迭代）；
O15 = M0*(M7*(M14*(M15*L15)));
O16 = M0*(M7*(M14*(M15*(M16*L16))));                             %颈关节相对根节点的惯性坐标系的偏移（递归迭代）；
O17 = M0*(M7*(M14*(M15*(M16*(M17*L17)))));      %头部相对左髋的惯性坐标系坐标（递归迭代）；

P14 = P0 + O7 + O14;                                %颈关节点的世界坐标；
P15 = P0 + O7 + O14 + O15;
P16 = P0 + O7 + O14 + O15 + O16;                                %颈关节点的世界坐标；
P17 = P0 + O7 + O14 + O15 + O16 + O17;                          %头部的世界坐标；
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(P0);                         %髋节点坐标
disp(P1);                         %右髋节点坐标
disp(P2);                         %左膝节点坐标
disp(P3);                         %左踝节点坐标
disp(P4);                         %右髋节点坐标
disp(P5);                         %右膝节点坐标
disp(P6);                         %右踝节点坐标
disp(P7);                         %脊椎节点坐标
disp(P8);                         %左颈节点坐标
disp(P9);                         %左肩节点坐标
disp(P10);                        %左肘节点坐标
disp(P11);                        %左腕节点坐标
disp(P12);                        %右颈节点坐标
disp(P13);                        %右肩节点坐标
disp(P14);                        %右肘节点坐标
disp(P15);                        %右腕节点坐标
disp(P16);                        %颈节点坐标
disp(P17);                        %头部坐标

%%
%%%%%%%%%%%%画骨架图%%%%%%%%%%%%%%

x = [P0(1,:)  P1(1,:)  P2(1,:)   P3(1,:)];
y = [P0(2,:)  P1(2,:)  P2(2,:)   P3(2,:)];
z = [P0(3,:)  P1(3,:)  P2(3,:)   P3(3,:)];            %髋至右腿

x1 = [P0(1,:)  P4(1,:)  P5(1,:)   P6(1,:)];
y1 = [P0(2,:)  P4(2,:)  P5(2,:)   P6(2,:)];
z1 = [P0(3,:)  P4(3,:)  P5(3,:)   P6(3,:)];           %髋至左腿


x2 = [P0(1,:)  P7(1,:)  P8(1,:)   P9(1,:)];
y2 = [P0(2,:)  P7(2,:)  P8(2,:)   P9(2,:)];
z2 = [P0(3,:)  P7(3,:)  P8(3,:)   P9(3,:)];     %髋至头部

x3 = [P0(1,:)  P7(1,:)  P10(1,:)   P11(1,:)  P12(1,:)  P13(1,:)];
y3 = [P0(2,:)  P7(2,:)  P10(2,:)   P11(2,:)  P12(2,:)  P13(2,:)];
z3 = [P0(3,:)  P7(3,:)  P10(3,:)   P11(3,:)  P12(3,:)  P13(3,:)];                 %髋至右腕

x4 = [P0(1,:)  P7(1,:)  P14(1,:)   P15(1,:)  P16(1,:)  P17(1,:)];
y4 = [P0(2,:)  P7(2,:)  P14(2,:)   P15(2,:)  P16(2,:)  P17(2,:)];
z4 = [P0(3,:)  P7(3,:)  P14(3,:)   P15(3,:)  P16(3,:)  P17(3,:)];                   %髋至左腕
% figure(xx)
% %%%%%绘制存在关键帧的骨架图
%
if xx == 10||xx == 170||xx == 330||xx == 450  %输入关键帧所在位置
    plot3(x,z,y,'ro-',x1,z1,y1,'ro-',x2,z2,y2,'ro-',x3,z3,y3,'ro-',x4,z4,y4,'ro-','lineWidth',2,'markerSize',5);
    set(gca,'FontWeight','bold','fontSize',15)
     hold on
else
    plot3(x,z,y,'ko-',x1,z1,y1,'ko-',x2,z2,y2,'ko-',x3,z3,y3,'ko-',x4,z4,y4,'ko-','lineWidth',1,'markerSize',5);
    set(gca,'FontWeight','bold','fontSize',15)
end
% title('下蹲')
  hold on
%plot3(x,z,y,'bo-',x1,z1,y1,'bo-',x2,z2,y2,'bo-',x3,z3,y3,'bo-',x4,z4,y4,'bo-');
 axis([-300 300 -1500 1500 -25 200]);
 view(185,5);
grid on;
%%
%%%%%%%%正常绘制骨架图
%  plot3(x,z,y,'ko-',x1,z1,y1,'ko-',x2,z2,y2,'ko-',x3,z3,y3,'ko-',x4,z4,y4,'ko-','lineWidth',1,'markerSize',5);
%     set(gca,'FontWeight','bold','fontSize',15)
%  hold on
% %plot3(x,z,y,'bo-',x1,z1,y1,'bo-',x2,z2,y2,'bo-',x3,z3,y3,'bo-',x4,z4,y4,'bo-');
%  axis([-300 300 -1500 1500 -25 200]);
% 
% %  title(['第',num2str(xx),'帧骨架图']);
% view(185,5);
% grid on;
%%
%%%骨骼段夹角计算部分%%%
Bcenter = P0-P7;
B1 = P1-P2;   %右大腿骨段
B2 = P2-P3;   %右下腿骨段
B3 = P4-P5;   %左大腿骨段
B4 = P4-P6;   %左下腿骨段
B5 = P10-P11; %右大臂骨段
B6 = P11-P12; %右下臂骨段
B7 = P14-P15; %左大臂骨段
B8 = P15-P16; %左下臂骨段
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
%%%%%%%%%%%%%右大臂与右小臂，左大臂和左小臂之间的夹角计算%%%%%%%%%%%%%
AngleRLsim = acosd((B1(:,1)'*B2(:,1))/(norm(B1(:,1))*norm(B2(:,1))));
AngleLLsim = acosd((B3(:,1)'*B4(:,1))/(norm(B3(:,1))*norm(B4(:,1))));
AngleRsim = acosd((B5(:,1)'*B6(:,1))/(norm(B5(:,1))*norm(B6(:,1))));
AngleLsim = acosd((B7(:,1)'*B8(:,1))/(norm(B7(:,1))*norm(B8(:,1))));
RLa = [AngleRLsim;AngleLLsim;AngleRsim;AngleLsim];
%%
%%%%%%各个骨段中点至中心关节点的距离%%%%%%%
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
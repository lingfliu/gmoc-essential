clear;
clc;
 tic
%%%所有bvh文件、脚本和函数需保存在同一文件夹下方可运行%%%%%
%%
%%%数据从bvh文件中拉取,并存入对应的.xlsx表格文件中%%%%
Data = importdata('walk1_2Char00.bvh','',inf);
init = 353;   %bvh文件中旋转角数据起始行，根据文件节点个数的不同修改
DATA = [];
for n = init : length(Data(:,1))
    data_str = Data{n,1};
    data_num = str2num(data_str);
    DATA = [DATA;data_num];
end
%%节点位置坐标重构%%%
A1 = DATA(:,1:3);
A2 = DATA(:,7:9);
A3 = DATA(:,13:15);
A4 = DATA(:,19:21);
A5 = DATA(:,25:27);
A6 = DATA(:,31:33);
A7 = DATA(:,37:39);
A8 = DATA(:,43:45);
A9 = DATA(:,67:69);
A10 = DATA(:,73:75);
A11 = DATA(:,79:81);
A12 = DATA(:,85:87);
A13 = DATA(:,91:93);
A14 = DATA(:,97:99);
A15 = DATA(:,217:219);
A16 = DATA(:,223:225);
A17 = DATA(:,229:231);
A18 = DATA(:,235:237);
DATA1 = [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18];

%%%节点旋转角坐标重构%%%
B1 = DATA(:,4:6);
B2 = DATA(:,10:12);
B3 = DATA(:,16:18);
B4 = DATA(:,22:24);
B5 = DATA(:,28:30);
B6 = DATA(:,34:36);
B7 = DATA(:,40:42);
B8 = DATA(:,46:48);
B9 = DATA(:,70:72);
B10 = DATA(:,76:78);
B11 = DATA(:,82:84);
B12 = DATA(:,88:90);
B13 = DATA(:,94:96);
B14 = DATA(:,100:102);
B15 = DATA(:,220:222);
B16 = DATA(:,226:228);
B17 = DATA(:,232:234);
B18 = DATA(:,238:240);
DATA2 = [A1,B1,B2,B3,B4,B5,B6,B7,B8,A9,B10,B11,B12,B13,B14,B15,B16,B17,B18];
xlswrite('location_data.xlsx',DATA1); %在图集文件夹下新建excel表格读入数据
xlswrite('rotation angle_data.xlsx',DATA2); %在图集文件夹下新建excel表格读入数据

%%
%%骨架图及骨段夹角计算%%%%%%
data = DATA2(:,4:end);
data0 = DATA2(:,1:3);

%%%xx代表帧数，data为旋转角部分的数据，data0为P0初始根节点坐标；
QQ = [];
LL = [];
RLA = [];
%  figure
for xx = 10:40:450 %输入起始帧，采样间隔和结束帧
 [Q,L,RLa] = weizhi_jisuan( xx ,data,data0 ); %实测数据计算；xx代表帧数，data为旋转角部分的数据，data0为P0初始根节点坐标；
% picname = [num2str(xx),'.bmp'];
% saveas(gcf,picname)
  QQ = [QQ,Q];        %QQ为计算的各帧骨段夹角集合
  LL = [LL,L];        %LL为计算的个帧的骨段中点与中心关节点的空间距离
  RLA = [RLA,RLa];
end
save('Feature', 'QQ','LL','RLA')
hold on
%%
%%%动图生成%%%
%gujiatu_gif(429,0.05 );  %动图生成； x1为起始帧，m为帧间间隔，x2为结束帧，y为延迟时间；
%%
%%%各个骨段均值%%%%%%
q1 =QQ(1:2,:);
q11 = mean(q1,1);
q2 = QQ(3:4,:);
q22 = mean(q2,1);
q3 =QQ(5:6,:);
q33 = mean(q3,1);
q4 =QQ(7:8,:);
q44 = mean(q4,1);
%%
QQM = [q11;q22;q33;q44];
save QQM
%%
t = toc; %计算代码运行时间
%  close all
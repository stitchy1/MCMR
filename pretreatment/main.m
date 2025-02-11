clc;
a=3;    %种类数3：AC,Light,TV
b=30;   %每个种类训练样本数,共3*30=90个

%% 数据存放目录,导入数据
%J=importasvariable('C:\Users\辰宇\Desktop\mind control recognization & manipulation\week_5\raw_data\',a,b);

%% 数据预处理，频段分离
%data=pretreatment(J);

%% 观察数据处理结果
m1=2;n1=5;      %第m1种，第n1个样本的数据图
m2=0;n2=0;      %第m2种，第n2个样本的数据图,不需要对比时设为0
%plotdata(data,m1,n1,m2,n2);

%% 提取CSP
p=1;        %是否画图
k=1;        %特征值个数为2k
CSP=data_CSP(data,p,k);

%% illustrate CSP
m=23;n=22;      %comparison figure of the mth trial in class1 and the nth trial in class2
illustrateCSP(data,23,22);
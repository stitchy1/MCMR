clc;
a=7;    %种类数3：AC,Light,TV   %blue,high,low,red,right,left,relax
        %          1   2   3    %  1    2   3   4    5     6    7
b=10;   %每个种类训练样本数,共3*30=90个

%% 数据存放目录,导入数据
%J=importasvariable('C:\Users\辰宇\Desktop\mind control recognization & manipulation\week_5\Data_905\Data\',a,b);

%% 数据预处理，频段分离
%data_L=pretreatment(J);

%% 观察数据处理结果
m1=7;n1=2;      %第m1类，第n1个样本的数据图
m2=0;n2=0;      %第m2类，第n2个样本的数据图,不需要对比时设为0
plotdata(data_L,m1,n1,m2,n2);

%% 提取CSP
p=1;        %是否画图
k=1;        %特征值个数为2k
CSP=data_CSP(data_L,p,k);

%% illustrate CSP
m1=5;n1=1;      %comparison figure of the m1th trial in class n1 and the m2th trial in class n2
m2=6;n2=1;
illustrateCSP(data_L,m1,n1,m2,n2);

%% illustrate CSP var
p=5;k=6;        %number of class
plotCSPvar(data_L,p,k);
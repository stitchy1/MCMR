clc;
a=7;    %������3��AC,Light,TV   %blue,high,low,red,right,left,relax
        %          1   2   3    %  1    2   3   4    5     6    7
b=10;   %ÿ������ѵ��������,��3*30=90��

%% ���ݴ��Ŀ¼,��������
%J=importasvariable('C:\Users\����\Desktop\mind control recognization & manipulation\week_5\Data_905\Data\',a,b);

%% ����Ԥ����Ƶ�η���
%data_L=pretreatment(J);

%% �۲����ݴ�����
m1=7;n1=2;      %��m1�࣬��n1������������ͼ
m2=0;n2=0;      %��m2�࣬��n2������������ͼ,����Ҫ�Ա�ʱ��Ϊ0
plotdata(data_L,m1,n1,m2,n2);

%% ��ȡCSP
p=1;        %�Ƿ�ͼ
k=1;        %����ֵ����Ϊ2k
CSP=data_CSP(data_L,p,k);

%% illustrate CSP
m1=5;n1=1;      %comparison figure of the m1th trial in class n1 and the m2th trial in class n2
m2=6;n2=1;
illustrateCSP(data_L,m1,n1,m2,n2);

%% illustrate CSP var
p=5;k=6;        %number of class
plotCSPvar(data_L,p,k);
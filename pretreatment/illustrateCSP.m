function illustrateCSP(A,p,k)
[a,b]=size(A);

%% CSP projection
% 1 vs 2
%EEGSignals.x样本输入
for i=1:b
    sample_j(:,:,i)=A{1,i}(:,2:9);
end
for i=b+1:2*b
    sample_j(:,:,i)=A{2,i-b}(:,2:9);
end

%EEGSignals.y标签输入
for i=1:b
    label(i)=1;
end
for i=b+1:2*b
    label(i)=0;
end
%EEGSignals.s频率输入
frequency=512;
%建立结构体
EEGSignals_j_12 = struct('x',sample_j,'y',label,'s',frequency);

%特征提取
CSPMatrix_j_12 = learnCSP(EEGSignals_j_12);
nbFilterPairs=1;
projection_j_12 = getprojection(EEGSignals_j_12, CSPMatrix_j_12, nbFilterPairs);

%% plot projection
[m,n]=size(projection_j_12);
t=1:n;
figure
v(1)=var(A{1,p}(:,1)',1,2);
v(2)=var(A{2,k}(:,1)',1,2);
v(3)=var(projection_j_12(p,:),1,2);
v(4)=var(projection_j_12(b+k,:),1,2);

% raw
subplot(2,2,1)
plot(t,A{1,p}(:,1)','b','linewidth',0.75);hold on;
plot(t,A{2,k}(:,1)'-120,'r','linewidth',0.75);hold off;
axis([0 1505 -inf 150]);
title('Raw Data');
xlabel('t/(1/512)s');
ylabel('Amplitude');
legend(['var:' num2str(v(1))],['var:' num2str(v(2))]);

% projection
subplot(2,2,3)
plot(t,projection_j_12(p,:),'b','linewidth',0.75);hold on;
plot(t,projection_j_12(b+k,:),'r','linewidth',0.75);hold off;
axis([0 1505 -inf inf]);
title('Projected Data');
xlabel('t/(1/512)s');
ylabel('Amplitude');
legend(['var:' num2str(v(3))],['var:' num2str(v(4))]);

%% plot spectrum
Fs=512;                 %取样频率
L=1506;                 %序列长度
f = Fs*(0:(L/2))/L;
Y=fft(A{1,p}(:,1)');  %傅里叶变换
P2 = abs(Y/L);          %双边谱
P1 = P2(1:L/2+1);       
P1(2:end-1) = 2*P1(2:end-1);%单边谱
subplot(2,2,2);
plot(f,P1,'b','linewidth',0.75);hold on;
Y=fft(A{1,p}(:,1)');  %傅里叶变换
P2 = abs(Y/L);          %双边谱
P1 = P2(1:L/2+1);       
P1(2:end-1) = 2*P1(2:end-1);%单边谱
plot(f,P1-20,'r','linewidth',0.75);hold off;
axis([0 128 -inf 30]);
title(['Single-Sided Spectrum of Raw Data(',num2str(a),',',num2str(b),')']);
xlabel('f/Hz');
ylabel('Amplitude');
legend('P1','P2-20');

Y=fft(projection_j_12(p,:));  %傅里叶变换
P2 = abs(Y/L);          %双边谱
P1 = P2(1:L/2+1);       
P1(2:end-1) = 2*P1(2:end-1);%单边谱
subplot(2,2,4);
plot(f,P1,'b','linewidth',0.75);hold on;
Y=fft(projection_j_12(b+k,:));  %傅里叶变换
P2 = abs(Y/L);          %双边谱
P1 = P2(1:L/2+1);       
P1(2:end-1) = 2*P1(2:end-1);%单边谱
plot(f,P1-10,'r','linewidth',0.75);hold off;
axis([0 128 -inf inf]);
title(['Single-Sided Spectrum of Raw Data(',num2str(a),',',num2str(b),')']);
xlabel('f/Hz');
ylabel('Amplitude');
legend('P1','P2-10');

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
v(1)=var(A{1,p}(:,1)',1,2)-350;
v(2)=var(A{2,k}(:,1)',1,2);
v(3)=var(projection_j_12(p,:),1,2);
v(4)=var(projection_j_12(b+k,:),1,2);

% raw
subplot(2,1,1)
plot(t,A{1,p}(:,1)','b','linewidth',0.75);hold on;
plot(t,A{2,k}(:,1)'-120,'r','linewidth',0.75);hold off;
axis([0 1505 -inf 150]);
title('Raw Data');
xlabel('t/(1/512)s');
ylabel('Amplitude');
legend(['Air-conditioner: ' num2str(v(1))],['Light: ' num2str(v(2))]);

% projection
subplot(2,1,2)
plot(t,projection_j_12(p,:),'b','linewidth',0.75);hold on;
plot(t,projection_j_12(b+k,:),'r','linewidth',0.75);hold off;
axis([0 1505 -inf inf]);
title('Projected Data');
xlabel('t/(1/512)s');
ylabel('Amplitude');
legend(['Air-conditioner: ' num2str(v(3))],['Light: ' num2str(v(4))]);

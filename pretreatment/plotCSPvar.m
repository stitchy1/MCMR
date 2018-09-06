function plotCSPvar(A,p,k)
[a,b]=size(A);

%% CSP projection
% 1 vs 2
%EEGSignals.x样本输入
for i=1:b
    sample_j(:,:,i)=A{p,i}(:,2:9);
end
for i=b+1:2*b
    sample_j(:,:,i)=A{k,i-b}(:,2:9);
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
t=1:b;
figure
for i=1:b
    v(1,i)=var(projection_j_12(i,:),1,2);
    v(2,i)=var(projection_j_12(b+i,:),1,2);
end
plot(t,v(1,:),'b','linewidth',0.75);hold on;
plot(t,v(2,:),'r','linewidth',0.75);hold off;
xlabel('number of trial');
ylabel('variance');
legend(['class' num2str(p)],['class' num2str(k)]);

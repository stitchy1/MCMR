function out = data_CSP_3d(A,p,k)
%data_CSP Summary of this function goes here
%   extract features applying CSP in three task;
[a,b]=size(A);
out = cell(a,b);
%% 特征提取-JCY
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
nbFilterPairs=k;
features_j_12 = extractCSPFeatures(EEGSignals_j_12, CSPMatrix_j_12, nbFilterPairs);

%% 特征提取-JCY
% 1 vs 3
%EEGSignals.x样本输入,EEGSignals.y标签输入
for i=1:b
    sample_j(:,:,i)=A{1,i}(:,2:9);
    label(i)=1;
end
for i=b+1:2*b
    sample_j(:,:,i)=A{3,i-b}(:,2:9);
    label(i)=0;
end
%EEGSignals.x频率输入
frequency=512;
%建立结构体
EEGSignals_j_13 = struct('x',sample_j,'y',label,'s',frequency);

%特征提取
CSPMatrix_j_13 = learnCSP(EEGSignals_j_13);
nbFilterPairs=k;
features_j_13 = extractCSPFeatures(EEGSignals_j_13, CSPMatrix_j_13, nbFilterPairs);

%% 特征提取-JCY
% 2 vs  3
%EEGSignals.x样本输入
for i=1:b
    sample_j(:,:,i)=A{2,i}(:,2:9);
    label(i)=1;
end
for i=b+1:2*b
    sample_j(:,:,i)=A{1,i-b}(:,2:9);
    label(i)=0;
end
%EEGSignals.x频率输入
frequency=512;
%建立结构体
EEGSignals_j_23 = struct('x',sample_j,'y',label,'s',frequency);

%特征提取
CSPMatrix_j_23 = learnCSP(EEGSignals_j_23);
nbFilterPairs=k;
features_j_23 = extractCSPFeatures(EEGSignals_j_23, CSPMatrix_j_23, nbFilterPairs);


%% 特征提取-WWS
% %EEGSignals.x样本输入
% for i=1:10
%     sample_w(:,:,i)=W{1,i}(:,2:12);
% end
% for i=11:20
%     sample_w(:,:,i)=W{2,i-10}(:,2:12);
% end
% %EEGSignals.y标签输入
% label=[1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0];
% %EEGSignals.x频率输入
% frequency=1;
% %建立结构体
% EEGSignals_w = struct('x',sample_w,'y',label,'s',frequency);
% 
% %特征提取
% CSPMatrix_w = learnCSP(EEGSignals_w);
% nbFilterPairs=1;
% features_w = extractCSPFeatures(EEGSignals_w, CSPMatrix_w, nbFilterPairs);

%% SVM-2分类
% train=features_j_12(6:14,1:2);
% group1=features_j_12(6:14,3);
% test=features_j_12(1:20,1:2);
% group2=features_j_12(1:20,3)';
% [classification,accuracy ] = SVM_2( train,group1,test,group2);

%% SVM-3分类
for j=1:b;
    out_1(j,:)=[features_j_12(j,1:k)+features_j_13(j,1:k),features_j_12(j,k+1:2*k),features_j_13(j,k+1:2*k)];
    out{1,j} = out_1(j,:);
    out_2(j,:)=[features_j_12(j+b,1:k),features_j_12(j+b,k+1:2*k)+features_j_23(j,1:k),features_j_23(j,k+1:2*k)];
    out{2,j} = out_2(j,:);
    out_3(j,:)=[features_j_13(j+b,1:k),features_j_23(j+b,1:k),features_j_13(j+b,k+1:2*k)+features_j_23(j,k+1:2*k)];
    out{3,j} = out_3(j,:);
end
if p==1;
    figure
    scatter3(out_1(1:b,1)',out_1(1:b,2)',out_1(1:b,3)','MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    scatter3(out_2(1:b,1)',out_2(1:b,2)',out_2(1:b,3)','MarkerFaceColor','r','MarkerEdgeColor','r');
    hold on;
    scatter3(out_3(1:b,1)',out_3(1:b,2)',out_3(1:b,3)','MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    legend('Air-conditioner','Light','TV')

end


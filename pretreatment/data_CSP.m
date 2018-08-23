function CSP=data_CSP(A,p,k)
[a,b]=size(A);
%% ������ȡ-JCY
% 1 vs 2
%EEGSignals.x��������
for i=1:b
    sample_j(:,:,i)=A{1,i}(:,2:9);
end
for i=b+1:2*b
    sample_j(:,:,i)=A{2,i-b}(:,2:9);
end

%EEGSignals.y��ǩ����
for i=1:b
    label(i)=1;
end
for i=b+1:2*b
    label(i)=0;
end
%EEGSignals.sƵ������
frequency=512;
%�����ṹ��
EEGSignals_j_12 = struct('x',sample_j,'y',label,'s',frequency);

%������ȡ
CSPMatrix_j_12 = learnCSP(EEGSignals_j_12);
nbFilterPairs=1;
features_j_12 = extractCSPFeatures(EEGSignals_j_12, CSPMatrix_j_12, nbFilterPairs);

%% ������ȡ-JCY
% 1 vs (2 or 3)
%EEGSignals.x��������,EEGSignals.y��ǩ����
for i=1:b
    sample_j(:,:,i)=A{1,i}(:,2:9);
    label(i)=1;
end
for i=b+1:1.5*b
    sample_j(:,:,i)=A{2,i-b}(:,2:9);
    label(i)=0;
end
for i=1.5*b+1:2*b
    sample_j(:,:,i)=A{3,i-1.5*b}(:,2:9);
    label(i)=0;
end
%EEGSignals.xƵ������
frequency=512;
%�����ṹ��
EEGSignals_j_1 = struct('x',sample_j,'y',label,'s',frequency);

%������ȡ
CSPMatrix_j_1 = learnCSP(EEGSignals_j_1);
nbFilterPairs=k;
features_j_1 = extractCSPFeatures(EEGSignals_j_1, CSPMatrix_j_1, nbFilterPairs);

%% ������ȡ-JCY
% 2 vs (1 or 3)
%EEGSignals.x��������
for i=1:b
    sample_j(:,:,i)=A{2,i}(:,2:9);
    label(i)=1;
end
for i=b+1:1.5*b
    sample_j(:,:,i)=A{1,i-b}(:,2:9);
    label(i)=0;
end
for i=1.5*b+1:2*b
    sample_j(:,:,i)=A{3,i-1.5*b}(:,2:9);
    label(i)=0;
end
%EEGSignals.xƵ������
frequency=512;
%�����ṹ��
EEGSignals_j_2 = struct('x',sample_j,'y',label,'s',frequency);

%������ȡ
CSPMatrix_j_2 = learnCSP(EEGSignals_j_2);
nbFilterPairs=k;
features_j_2 = extractCSPFeatures(EEGSignals_j_2, CSPMatrix_j_2, nbFilterPairs);

%% ������ȡ-JCY
% 3 vs (1 or 2)
%EEGSignals.x��������
for i=1:b
    sample_j(:,:,i)=A{3,i}(:,2:9);
    label(i)=1;
end
for i=b+1:1.5*b
    sample_j(:,:,i)=A{1,i-b}(:,2:9);
    label(i)=0;
end
for i=1.5*b+1:2*b
    sample_j(:,:,i)=A{2,i-1.5*b}(:,2:9);
    label(i)=0;
end
%EEGSignals.xƵ������
frequency=512;
%�����ṹ��
EEGSignals_j_3 = struct('x',sample_j,'y',label,'s',frequency);

%������ȡ
CSPMatrix_j_3 = learnCSP(EEGSignals_j_3);
nbFilterPairs=k;
features_j_3 = extractCSPFeatures(EEGSignals_j_3, CSPMatrix_j_3, nbFilterPairs);

%% ������ȡ-WWS
% %EEGSignals.x��������
% for i=1:10
%     sample_w(:,:,i)=W{1,i}(:,2:12);
% end
% for i=11:20
%     sample_w(:,:,i)=W{2,i-10}(:,2:12);
% end
% %EEGSignals.y��ǩ����
% label=[1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0];
% %EEGSignals.xƵ������
% frequency=1;
% %�����ṹ��
% EEGSignals_w = struct('x',sample_w,'y',label,'s',frequency);
% 
% %������ȡ
% CSPMatrix_w = learnCSP(EEGSignals_w);
% nbFilterPairs=1;
% features_w = extractCSPFeatures(EEGSignals_w, CSPMatrix_w, nbFilterPairs);

%% SVM-2����
% train=features_j_12(6:14,1:2);
% group1=features_j_12(6:14,3);
% test=features_j_12(1:20,1:2);
% group2=features_j_12(1:20,3)';
% [classification,accuracy ] = SVM_2( train,group1,test,group2);

%% SVM-3����
for j=1:b;
    CSP{1,j}(1,1:2*k)=features_j_1(j,1:2*k)';
end
for j=1:b;
    CSP{2,j}(1,1:2*k)=features_j_2(j,1:2*k)';
end
for j=1:b;
    CSP{3,j}(1,1:2*k)=features_j_3(j,1:2*k)';
end
if p==1;
    figure
    scatter(features_j_1(1:b,1)',features_j_1(1:b,2)','MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    scatter(features_j_2(1:b,1)',features_j_2(1:b,2)','MarkerFaceColor','r','MarkerEdgeColor','r');
    hold on;
    scatter(features_j_3(1:b,1)',features_j_3(1:b,2)','MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    legend('Air-conditioner','Light','TV')
end
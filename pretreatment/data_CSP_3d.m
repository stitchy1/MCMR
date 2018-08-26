function out = data_CSP_3d(A,p,k)
%data_CSP Summary of this function goes here
%   extract features applying CSP in three task;
[a,b]=size(A);
out = cell(a,b);
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
nbFilterPairs=k;
features_j_12 = extractCSPFeatures(EEGSignals_j_12, CSPMatrix_j_12, nbFilterPairs);

%% ������ȡ-JCY
% 1 vs 3
%EEGSignals.x��������,EEGSignals.y��ǩ����
for i=1:b
    sample_j(:,:,i)=A{1,i}(:,2:9);
    label(i)=1;
end
for i=b+1:2*b
    sample_j(:,:,i)=A{3,i-b}(:,2:9);
    label(i)=0;
end
%EEGSignals.xƵ������
frequency=512;
%�����ṹ��
EEGSignals_j_13 = struct('x',sample_j,'y',label,'s',frequency);

%������ȡ
CSPMatrix_j_13 = learnCSP(EEGSignals_j_13);
nbFilterPairs=k;
features_j_13 = extractCSPFeatures(EEGSignals_j_13, CSPMatrix_j_13, nbFilterPairs);

%% ������ȡ-JCY
% 2 vs  3
%EEGSignals.x��������
for i=1:b
    sample_j(:,:,i)=A{2,i}(:,2:9);
    label(i)=1;
end
for i=b+1:2*b
    sample_j(:,:,i)=A{1,i-b}(:,2:9);
    label(i)=0;
end
%EEGSignals.xƵ������
frequency=512;
%�����ṹ��
EEGSignals_j_23 = struct('x',sample_j,'y',label,'s',frequency);

%������ȡ
CSPMatrix_j_23 = learnCSP(EEGSignals_j_23);
nbFilterPairs=k;
features_j_23 = extractCSPFeatures(EEGSignals_j_23, CSPMatrix_j_23, nbFilterPairs);


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


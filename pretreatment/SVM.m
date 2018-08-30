function [pred, accuracy]= SVM(CSP)
%% 
[CSP_row,CSP_col]=size(CSP);
AC=[];
Light=[];
TV=[];
for i=1:CSP_col
    AC=[AC;CSP{1,i}];
    Light=[Light;CSP{2,i}];
    TV=[TV;CSP{3,i}];
end

%%
[Fea_row,Fea_col]=size(AC);
Train_num=0.8*Fea_row;
% Train_AC=[AC(1:Train_num,1:Fea_col);Light(1:Train_num/2,1:Fea_col);TV(1:Train_num/2,1:Fea_col)];
% Train_L=[Light(1:Train_num,1:Fea_col);AC(1:Train_num/2,1:Fea_col);TV(Train_num/2+1:Train_num,1:Fea_col)];
% Train_TV=[TV(1:Train_num,1:Fea_col);AC(Train_num/2+1:Train_num,1:Fea_col);Light(Train_num/2+1:Train_num,1:Fea_col)];
% Lable_tAC=[ones(Train_num,1);zeros(2*Train_num,1)];
% Lable_tL=[ones(Train_num,1);zeros(2*Train_num,1)];
% Lable_tTV=[ones(Train_num,1);zeros(2*Train_num,1)];
Train=[AC(1:Train_num,1:Fea_col);Light(1:Train_num,1:Fea_col);TV(1:Train_num,1:Fea_col)];
Lable=[ones(Train_num,1);2*ones(Train_num,1);3*ones(Train_num,1)];

Pre_num=0.2*Fea_row;
Test_AC=AC(Train_num+1:end,1:Fea_col);
Test_L=Light(Train_num+1:end,1:Fea_col);
Test_TV=TV(Train_num+1:end,1:Fea_col);
Test=[Test_AC;Test_L;Test_TV];
% Lable_pAC=[ones(Pre_num,1);zeros(2*Pre_num,1)];
% Lable_pL=[zeros(Pre_num,1);ones(Pre_num,1);zeros(Pre_num,1)];
% Lable_pTV=[zeros(2*Pre_num,1);ones(Pre_num,1)];
Lable_p=[ones(Pre_num,1);2*ones(Pre_num,1);3*ones(Pre_num,1)];
%% Train
% Model_1=SVMTrain(Train_AC,Lable_tAC);
% save model1.mat Model_1;
% Model_2=SVMTrain(Train_L,Lable_tL);
% save model2.mat Model_2;
% Model_3=SVMTrain(Train_TV,Lable_tTV);
% save model3.mat Model_3;
Model=SVMTrain(Train,Lable);
save Model.mat Model;
%% Predict
% load model1.mat;
% load model2.mat;
% load model3.mat;
load Model.mat;
[LVec,LDim]=size(Test);
% [pred_1,accuracy_1,decisionValues_1] = svmpredict(Lable_pAC,Test,Model_1); 
% [pred_2,accuracy_2,decisionValues_2] = svmpredict(Lable_pL,Test,Model_2);
% [pred_3,accuracy_3,decisionValues_3] = svmpredict(Lable_pTV,Test,Model_3); 
[pred,accuracy,decisionValues]=svmpredict(Lable_p,Test,Model);
% A=pred_1+1;
% B=pred_2+1;
% C=pred_3+1;
% Result=[A,B,C];
% [Num,Pred]=max(Result');
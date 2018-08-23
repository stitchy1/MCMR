function [classification,accuracy ] = SVM_2( train,group1,test,group2)
%SVM对线性不可分的数据进行处理
%在选择核函数时，尝试用linear以外的rbf,quadratic,polynomial等，观察获得的分类情况
%训练分类模型
%svmModel = svmtrain(train,group1,'kernel_function','rbf');
%分类
%classification=svmclassify(svmModel,test);
% count=0;
% for i=1:L
%    if strcmp(classfication(i),group2(i))
%       count=count+1;
%    end
% end
% accuracy=count/L;
% fprintf('Accuracy：%f\n' ,accuracy);
% end
model=fitcsvm(train,group1,'KernelFunction','rbf');
[classification,score]=predict(model,test);
count=0;
[m,n]=size(test);
for i=1:m
   if classification(i)==group2(i)
      count=count+1;
   end
end
accuracy=count/m;
fprintf('Accuracy：%.3f\n' ,accuracy);

sv = model.SupportVectors;
figure
scatter(test(1:10,1)',test(1:10,2)','MarkerFaceColor','b');
hold on
scatter(test(11:20,1)',test(11:20,2)','MarkerFaceColor','r');
hold on;
x=19:0.01:24;
y=0.25*(x-19)+20.4;
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10);
hold on;
legend('TV','Light','Support Vector');
plot(x,y,'k','linewidth',1.5);
hold off;
end
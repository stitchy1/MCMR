function model=SVMTrain(Train,Lable)

%% Initiation
[m,n]=size(Train);
p=randperm(m);
train=[];
lable=[];
for i=1:m
    train=[train;Train(p(i),:)];
    lable=[lable;Lable(p(i))];
end

% %% Normalization
% [numVec,numDim]=size(train);
% avgT=mean(train);
% stdT=std(train);
% for j=1:numVec
%     train(j,:)=(train(j,:)-avgT)./stdT;
% end

%% Search for the optimal 'C' and 'gamma' to make the recognition rate maximum.
%Search 'C' and 'gamma' in a crude scale.
CScale = -20:20;
gammaScale = -20:20;
C = 2.^CScale;
gamma = 2.^gammaScale;
maxRecognitionRate = 0;
for i = 1:length(C)
    for j = 1:length(gamma)
        cmd=['-t 2 -c ',num2str(C(i)),' -g ',num2str(gamma(j)),' -v 10'];
        recognitionRate = svmtrain(lable,train,cmd);
        if recognitionRate>maxRecognitionRate
            maxRecognitionRate = recognitionRate
            maxCIndex = i;
            maxGammaIndex = j;
        end;
    end;
end;

%% Then search for optimal C and gamma in a refined scale. 
n = 10;
minCScale = 0.5*(CScale(max(1,maxCIndex-1))+CScale(maxCIndex));
maxCScale = 0.5*(CScale(min(length(CScale),maxCIndex+1))+CScale(maxCIndex));
newCScale = [minCScale:(maxCScale-minCScale)/n:maxCScale];

minGammaScale = 0.5*(gammaScale(max(1,maxGammaIndex-1))+gammaScale(maxGammaIndex));
maxGammaScale = 0.5*(gammaScale(min(length(gammaScale),maxGammaIndex+1))+gammaScale(maxGammaIndex));
newGammaScale = [minGammaScale:(maxGammaScale-minGammaScale)/n:maxGammaScale];
newC = 2.^newCScale;
newGamma = 2.^newGammaScale;
maxRecognitionRate = 0;
for i = 1:length(newC)
    for j = 1:length(newGamma)
        cmd=['-t 2 -c ',num2str(newC(i)),' -g ',num2str(newGamma(j)),' -v 10'];
        recognitionRate = svmtrain(lable,train,cmd);
        if recognitionRate>maxRecognitionRate
            maxRecognitionRate = recognitionRate
            maxC = newC(i);
            maxGamma = newGamma(j);
        end;
    end;
end;

%% Train the SVM model by the optimal C and gamma.
cmd=['-t 2 -c ',num2str(maxC),' -g ',num2str(maxGamma)];
model = svmtrain(lable,train,cmd);
save model.mat model;

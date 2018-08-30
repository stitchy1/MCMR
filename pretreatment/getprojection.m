function projectedTrial = getprojection(EEGSignals, CSPMatrix, nbFilterPairs)

%initializations
nbTrials = size(EEGSignals.x,3);
features = zeros(nbTrials, 2*nbFilterPairs+1);
Filter = CSPMatrix([1:nbFilterPairs (end-nbFilterPairs+1):end],:);

%extracting the CSP features from each trial
for t=1:nbTrials    
    %projecting the data onto the CSP filters    
    projected = Filter * EEGSignals.x(:,:,t)';    
    projectedTrial(t,:)=projected(1,:);  
end
function raw_signal=pretreatment(raw_signal)

[a,b]=size(raw_signal); %数据种类数和样本数

for i=1:a;
    for j=1:b;
        
        %频段分离
        Delta = decompose_filter(raw_signal{i,j}(:,1),1,0.5,2.75,512);   %0.5-2.75Hz
        Theta= decompose_filter(raw_signal{i,j}(:,1),1,3.5,6.75,512);    %3.5-6.75Hz
        Alpha1= decompose_filter(raw_signal{i,j}(:,1),1,7.5,9.25,512);   %7.5-9.25Hz
        Alpha2= decompose_filter(raw_signal{i,j}(:,1),1,10,11.75,512);   %10-11.75Hz
        Beta1= decompose_filter(raw_signal{i,j}(:,1),1,13,16.75,512);    %13-16.75Hz
        Beta2= decompose_filter(raw_signal{i,j}(:,1),1,18,29.75,512);    %18-29.75Hz
        Gamma1= decompose_filter(raw_signal{i,j}(:,1),1,31,39.75,512);   %31-39.75Hz
        Gamma2= decompose_filter(raw_signal{i,j}(:,1),1,41,49.75,512);   %41-49.75Hz

        %写入数据
        raw_signal{i,j}(:,2)=Delta;
        raw_signal{i,j}(:,3)=Theta;
        raw_signal{i,j}(:,4)=Alpha1;
        raw_signal{i,j}(:,5)=Alpha2;
        raw_signal{i,j}(:,6)=Beta1;
        raw_signal{i,j}(:,7)=Beta2;
        raw_signal{i,j}(:,8)=Gamma1;
        raw_signal{i,j}(:,9)=Gamma2;
    end
end



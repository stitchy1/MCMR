function J=importasvariable(directory,a,b)
%% 创建文件索引目录
M=dir(directory);

%% 读取数据
for i=1:a
    for j=1:b
        J{i,j}=zeros(1506,9);
    end
end
for i=1:a
    for j=1:b
        J{i,j}(:,1)=importfile_raw([directory,M(3+(i-1)*30+j-1).name],'Raw_Data',1110,2615);
    end
end
function VarName2 = importfile_raw(workbookFile,sheetName,startRow,endRow)
%   VarName2 = importfile('AC_J_1.xls','Raw_Data',1052,2601);

%% 输入处理
% 如果未指定工作表，则将读取第一张工作表
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% 如果未指定行的起点和终点，则会定义默认值。
if nargin <= 3
    startRow = 1052;
    endRow = 2601;
end

%% 导入数据
data = xlsread(workbookFile, sheetName, sprintf('B%d:B%d',startRow(1),endRow(1)));
for block=2:length(startRow)
    tmpDataBlock = xlsread(workbookFile, sheetName, sprintf('B%d:B%d',startRow(block),endRow(block)));
    data = [data;tmpDataBlock]; %#ok<AGROW>
end

%% 将导入的数组分配给列变量名称
VarName2 = data(:,1);


function VarName2 = importfile_raw(workbookFile,sheetName,startRow,endRow)
%   VarName2 = importfile('AC_J_1.xls','Raw_Data',1052,2601);

%% ���봦��
% ���δָ���������򽫶�ȡ��һ�Ź�����
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% ���δָ���е������յ㣬��ᶨ��Ĭ��ֵ��
if nargin <= 3
    startRow = 1052;
    endRow = 2601;
end

%% ��������
data = xlsread(workbookFile, sheetName, sprintf('B%d:B%d',startRow(1),endRow(1)));
for block=2:length(startRow)
    tmpDataBlock = xlsread(workbookFile, sheetName, sprintf('B%d:B%d',startRow(block),endRow(block)));
    data = [data;tmpDataBlock]; %#ok<AGROW>
end

%% ����������������б�������
VarName2 = data(:,1);


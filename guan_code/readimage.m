%% ��ȡbmp�ļ�
directory = uigetdir('','ѡ��ָ���ļ��У�');%�����Ի����ֶ�ָ���ļ��У�������Ϊ�ҵ���Ϊ����źŵ��ļ���
for i = 1
filepath = fullfile(directory,['Testimage_' num2str(i,'%d') '.bmp']);
fid = imread(filepath);%���ļ�

end
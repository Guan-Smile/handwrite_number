
%% 读取bmp文件
directory = uigetdir('','选择指定文件夹：');%弹出对话框手动指定文件夹，本例即为找到名为组件信号的文件夹
num = 100;
train =zeros(num,long^2)
for i = 1:100
filepath = fullfile(directory,['Testimage_' num2str(i,'%d') '.bmp']);
fid = imread(filepath);%打开文件
train(i,:)= Getfeature_g(fid,long);
end
function [result] = parzenfun(feature,long,wainput)
%% parmain
Tr_all=load('../data_train_true3.mat');%data_train_true2.mat');
Test_all=load('../data_train_test3.mat');
% long =14;
num_all_X=long^2;
N = 0;
%% 求先验概率
[Cls,Pos ]=sort(Tr_all.train_label);
Px=tabulate(Cls)  
pw = Px(:,3)./100;
[Cls_test,Pos_test ]=sort(Test_all.train_label);%%测试集
Px_test=tabulate(Cls_test);
pw_test = Px_test(:,3)./100;
%% 对train数据进行排序
train_oder=Tr_all.train(Pos,:);%%将数据集按照0-9排序
test_order = Test_all.train(Pos_test,:);
flg=1;
flg_test=1;
samp_test =50;
% test = Test_all.train(1:samp_test,:);% 取前五个样本，1-3项特征 
test_true_lable = Test_all.train_label(1:samp_test);

for kk=1:10
Tra_cell{kk}=train_oder(flg:flg+Px(kk,2)-1,:);
w(:,:,kk) = Tra_cell{kk}(200:500,:);%%前30个样本，1-3项特征   %w = [样本数目，3维特征，10类分类]
Test_cell{kk}= test_order(flg_test:flg_test+Px_test(kk,2)-1,:);
Sum{kk} = sum(Tra_cell{kk});
flg = flg+Px(kk,2);
flg_test = flg_test+Px_test(kk,2);
% subplot(3,4,kk)
% hold on 
% mesh(reshape(Sum{kk},long,long));%%绘制特征提取图像
% title(['数字',num2str(kk-1,'%d'),'提取的特征']);
end


%% parzen main
h=[1, 4, 8, 16, 32, 64, 128, 256];
% i 为测试集个数

suc = [];

if (wainput~=1)
for c_h = 1:length(h)
    for kkk = 1:10     
        count=0;
        
       for i=1:samp_test
    
    test(i,:) = Test_cell{kkk}(i,:);
    
    
    r=parzen(w,h(c_h),test(i,:));
    result=find(r==max(r));
    X=['点[',num2str(test(i,:)),']落在三个类别的概率分别为：',num2str(r)];
    Y=['因此，点[',num2str(test(i,:)),']落在第',num2str(result),'类,正确为第',num2str(test_true_lable(i)+1),'类'];
%     disp(X);disp(Y);disp(' ');
% result
    if (result== kkk)
    count = count +1;
    end
         end
suc = [suc count/samp_test];
disp('please waiting..........')
    end   
end

suc_plot = reshape(suc,8,[]);
figure 
plot(1:8,suc_plot,'-*')

xlabel('h参数的值分别为=[1, 4, 8, 16, 32, 64, 128, 256]')
ylabel('判别准确率%')
title('Parzen窗法识别准确率');
%     save('zuoye2res.mat',suc);
hold on
M_p = mean(suc_plot,2);
plot(1:8,M_p,'-kP')
legend('数字0识别正确','数字1识别正确','数字2识别正确','数字3识别正确','数字4识别正确','数字5识别正确','数字6识别正确','数字7识别正确','数字8识别正确','数字9识别正确','平均');
else
    c_h=3;%调整h参数的值
     r=parzen(w,h(c_h),feature);
     result=find(r==max(r));
    X=['判断为：',num2str(result)-1];
    disp(X);
end

end
function [all_res,M_suc] = BayesLeasterror(feature,long,waibuinput)

Tr_all=load('../data_train_true3.mat');%data_train_true2.mat');
Test_all=load('../data_train_test3.mat');
num_all_X=long^2;
x = zeros(1,num_all_X);    %待测样品
xmeans = zeros(1,num_all_X);   %样品的均值
 S = zeros(num_all_X,num_all_X);   %协方差矩阵
S_ =zeros(num_all_X,num_all_X);   %S的逆矩阵
pw = zeros(1,10);    %先验概率P(wj)=n(i)/N
hx = zeros(1,10);   %判别函数
t = zeros(1,num_all_X);
mode = [];
N = 0;
%% 求先验概率
[Cls,Pos ]=sort(Tr_all.train_label);
Px=tabulate(Cls)  
pw = Px(:,3)./100;
[Cls_test,Pos_test ]=sort(Test_all.train_label);%%测试集
Px_test=tabulate(Cls_test)
pw_test = Px_test(:,3)./100;
%% 对train数据进行排序
train_oder=Tr_all.train(Pos,:);%%将数据集按照0-9排序
test_order = Test_all.train(Pos_test,:);
flg=1;
flg_test=1;

figure();%PLOT

for kk=1:10
Tra_cell{kk}=train_oder(flg:flg+Px(kk,2)-1,:);
Test_cell{kk}= test_order(flg_test:flg_test+Px_test(kk,2)-1,:);
Sum{kk} = sum(Tra_cell{kk});
flg = flg+Px(kk,2);
flg_test = flg_test+Px_test(kk,2);
subplot(3,4,kk)
hold on 
mesh(reshape(Sum{kk},long,long));%%绘制特征提取图像
title(['数字',num2str(kk-1,'%d'),'提取的特征']);
end

%% 求样品平均值
for num = 1:10  %数字类1-10
%     pnum = Px(num,2);%每一类中的样本个数
    xmeans(num,:) = Sum{num}./Px(num,2);%% Sum{kk}中已经进行除当前类样本数
end

result=[];
all_res=zeros(10,10)
for kkkk = 1:10
for kkk =1:50
    
    if waibuinput==0
     feature = Test_cell{kkkk}(kkk+22,:);
    end
%      feature= xmeans(kkk,:);
for n=1:10
     pnum = Px(n,2);%每一类中的样本个数
   copy=Tra_cell{n}-xmeans(n,:);
   
%   S= cov(xmeans(n,:));%[196,196]类型一中所有样本的协方差。
s=0;
for i = 1: long^2
    for j = 1:long^2
        for cut= 1:pnum
%         s = s + (Tra_cell{n}(cut,i)-xmeans(n,i))*(Tra_cell{n}(cut,j)-xmeans(n,j));
        s = s + copy(cut,i)*copy(cut,j);
        end 
        s=s/(pnum-1);
        S(i,j)=s;
        s=0;
    end
end

% S_all(n,:,:) = S;
% save('S_all.mat','S_all')
    %求S的逆矩阵
    S_ = pinv(S);   %求逆函数pinv
    dets = det(S);  %求行列式的值，函数det

    x=feature-xmeans(n,:);
    t = x*S_;
    t1 = t*x';
    t2 = log(pw(1));
    t3 = log(dets+1);
    hx(n) = -t1/2+t2-t3/2;
    result(kkk,n)=hx(n);
end
[tem,num] = max(hx);

succ(kkk)=num;

end
result;
Res = tabulate(succ);
all_res(1:size(Res,1),kkkk) = Res(:,3)
end
[tem,num] = max(hx);    %找到其中的最大值
num = num-1;
str = num2str(num);
str = ['应用最小错误率的Bayes方法识别结果：' str];
msgbox(str,'结果：');
 save('C:/Users/Think/Desktop/华工一年级/课程相关/模式识别/手写数字库/handwrite_number/result.mat','all_res')
M_suc=mean(diag(all_res))

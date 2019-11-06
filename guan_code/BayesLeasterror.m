function [all_res,M_suc] = BayesLeasterror(feature,long,waibuinput)

Tr_all=load('C:/Users/Think/Desktop/����һ�꼶/�γ����/ģʽʶ��/��д���ֿ�/handwrite_number/data_train_true3.mat');%data_train_true2.mat');
Test_all=load('C:/Users/Think/Desktop/����һ�꼶/�γ����/ģʽʶ��/��д���ֿ�/handwrite_number/data_train_true3.mat');
num_all_X=long^2;
x = zeros(1,num_all_X);    %������Ʒ
xmeans = zeros(1,num_all_X);   %��Ʒ�ľ�ֵ
 S = zeros(num_all_X,num_all_X);   %Э�������
S_ =zeros(num_all_X,num_all_X);   %S�������
pw = zeros(1,10);    %�������P(wj)=n(i)/N
hx = zeros(1,10);   %�б���
t = zeros(1,num_all_X);
mode = [];
N = 0;
%% ���������
[Cls,Pos ]=sort(Tr_all.train_label);
Px=tabulate(Cls)  
pw = Px(:,3)./100;
[Cls_test,Pos_test ]=sort(Test_all.train_label);%%���Լ�
Px_test=tabulate(Cls_test)
pw_test = Px_test(:,3)./100;
%% ��train���ݽ�������
train_oder=Tr_all.train(Pos,:);%%�����ݼ�����0-9����
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
mesh(reshape(Sum{kk},long,long));%%����������ȡͼ��
title(['����',num2str(kk-1,'%d'),'��ȡ������']);
end

%% ����Ʒƽ��ֵ
for num = 1:10  %������1-10
%     pnum = Px(num,2);%ÿһ���е���������
    xmeans(num,:) = Sum{num}./Px(num,2);%% Sum{kk}���Ѿ����г���ǰ��������
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
     pnum = Px(n,2);%ÿһ���е���������
   copy=Tra_cell{n};
   
  S= cov(xmeans(n,:));%[196,196]����һ������������Э���
    %��S�������
    S_ = pinv(S);   %���溯��pinv
    dets = det(S);  %������ʽ��ֵ������det

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
[tem,num] = max(hx);    %�ҵ����е����ֵ
num = num-1;
str = num2str(num);
str = ['Ӧ����С�����ʵ�Bayes����ʶ������' str];
msgbox(str,'�����');
 save('C:/Users/Think/Desktop/����һ�꼶/�γ����/ģʽʶ��/��д���ֿ�/handwrite_number/result.mat','all_res')
M_suc=mean(diag(all_res))
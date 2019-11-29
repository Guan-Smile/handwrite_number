function [result] = parzenfun(feature,long,wainput)
%% parmain
Tr_all=load('../data_train_true3.mat');%data_train_true2.mat');
Test_all=load('../data_train_test3.mat');
% long =14;
num_all_X=long^2;
N = 0;
%% ���������
[Cls,Pos ]=sort(Tr_all.train_label);
Px=tabulate(Cls)  
pw = Px(:,3)./100;
[Cls_test,Pos_test ]=sort(Test_all.train_label);%%���Լ�
Px_test=tabulate(Cls_test);
pw_test = Px_test(:,3)./100;
%% ��train���ݽ�������
train_oder=Tr_all.train(Pos,:);%%�����ݼ�����0-9����
test_order = Test_all.train(Pos_test,:);
flg=1;
flg_test=1;
samp_test =50;
% test = Test_all.train(1:samp_test,:);% ȡǰ���������1-3������ 
test_true_lable = Test_all.train_label(1:samp_test);

for kk=1:10
Tra_cell{kk}=train_oder(flg:flg+Px(kk,2)-1,:);
w(:,:,kk) = Tra_cell{kk}(200:500,:);%%ǰ30��������1-3������   %w = [������Ŀ��3ά������10�����]
Test_cell{kk}= test_order(flg_test:flg_test+Px_test(kk,2)-1,:);
Sum{kk} = sum(Tra_cell{kk});
flg = flg+Px(kk,2);
flg_test = flg_test+Px_test(kk,2);
% subplot(3,4,kk)
% hold on 
% mesh(reshape(Sum{kk},long,long));%%����������ȡͼ��
% title(['����',num2str(kk-1,'%d'),'��ȡ������']);
end


%% parzen main
h=[1, 4, 8, 16, 32, 64, 128, 256];
% i Ϊ���Լ�����

suc = [];

if (wainput~=1)
for c_h = 1:length(h)
    for kkk = 1:10     
        count=0;
        
       for i=1:samp_test
    
    test(i,:) = Test_cell{kkk}(i,:);
    
    
    r=parzen(w,h(c_h),test(i,:));
    result=find(r==max(r));
    X=['��[',num2str(test(i,:)),']�����������ĸ��ʷֱ�Ϊ��',num2str(r)];
    Y=['��ˣ���[',num2str(test(i,:)),']���ڵ�',num2str(result),'��,��ȷΪ��',num2str(test_true_lable(i)+1),'��'];
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

xlabel('h������ֵ�ֱ�Ϊ=[1, 4, 8, 16, 32, 64, 128, 256]')
ylabel('�б�׼ȷ��%')
title('Parzen����ʶ��׼ȷ��');
%     save('zuoye2res.mat',suc);
hold on
M_p = mean(suc_plot,2);
plot(1:8,M_p,'-kP')
legend('����0ʶ����ȷ','����1ʶ����ȷ','����2ʶ����ȷ','����3ʶ����ȷ','����4ʶ����ȷ','����5ʶ����ȷ','����6ʶ����ȷ','����7ʶ����ȷ','����8ʶ����ȷ','����9ʶ����ȷ','ƽ��');
else
    c_h=3;%����h������ֵ
     r=parzen(w,h(c_h),feature);
     result=find(r==max(r));
    X=['�ж�Ϊ��',num2str(result)-1];
    disp(X);
end

end
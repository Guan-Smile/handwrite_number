%parmain
Tr_all=load('../data_train_true3.mat')



h=1;
for i=1:3
    r=parzen(w,h,x(i,:));
    result=find(r==max(r));
    X=['��[',num2str(x(i,:)),']�����������ĸ��ʷֱ�Ϊ��',num2str(r)];
    Y=['��ˣ���[',num2str(x(i,:)),']���ڵ�',num2str(result),'��'];
    disp(X);disp(Y);disp(' ');
end

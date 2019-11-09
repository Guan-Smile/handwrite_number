%parmain
Tr_all=load('../data_train_true3.mat')



h=1;
for i=1:3
    r=parzen(w,h,x(i,:));
    result=find(r==max(r));
    X=['点[',num2str(x(i,:)),']落在三个类别的概率分别为：',num2str(r)];
    Y=['因此，点[',num2str(x(i,:)),']落在第',num2str(result),'类'];
    disp(X);disp(Y);disp(' ');
end

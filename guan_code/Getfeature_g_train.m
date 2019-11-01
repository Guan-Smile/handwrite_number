function feature = Getfeature_g(ima,long)
%% 针对训练数据集
feature = zeros(1,long^2);
im=imresize(ima,[long,long]);

count = 0;
k=1;
feature = zeros(1,long^2);

for i=1:1:long %从第一行开始
    for j=1:1:long  %从第一列开始
       
                if im(i,j)~=255   % 如果是黑色（有输入的区域）
                    count=count+1;
                end
  
        feature(k)=count;  %第k个特征分量  无输入区域特征值为0
        count=0;
        k=k+1;
    end
end
end
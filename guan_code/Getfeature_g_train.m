function feature = Getfeature_g(ima,long)
%% ���ѵ�����ݼ�
feature = zeros(1,long^2);
im=imresize(ima,[long,long]);

count = 0;
k=1;
feature = zeros(1,long^2);

for i=1:1:long %�ӵ�һ�п�ʼ
    for j=1:1:long  %�ӵ�һ�п�ʼ
       
                if im(i,j)~=255   % ����Ǻ�ɫ�������������
                    count=count+1;
                end
  
        feature(k)=count;  %��k����������  ��������������ֵΪ0
        count=0;
        k=k+1;
    end
end
end
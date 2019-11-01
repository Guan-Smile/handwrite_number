function feature = Getfeature(im)

[row,col] = find(im==0); %�õ�ͼƬ���������ҵı߽�
im = im(min(row):max(row),min(col):max(col));   %�ҵ�ͼƬ����д���ֵ�λ��

[row,col] = size(im);  %��д���ֵ��к���
w = fix(row/6);   % fix��Ϊ��ȡ��
h = fix(col/6);
count = 0;
k=1;
feature = zeros(1,36);

for i=1:1:6 %�ӵ�һ�п�ʼ
    for j=1:1:6  %�ӵ�һ�п�ʼ
        for m=(i-1)*w+1:i*w  
            for n=(j-1)*h+1:j*h  
                if im(m,n)==0
                    count=count+1;
                end
            end
        end
        feature(k)=count/(w*h);  %��k����������
        count=0;
        k=k+1;
    end
end
end
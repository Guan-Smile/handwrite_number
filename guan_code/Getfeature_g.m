function feature = Getfeature_g(im,long)
%% �Ľ������ֱ�Ե���
[row,col] = find(im==0); %�õ�ͼƬ���������ҵı߽�
bian=max(max(row)-min(row),max(col)-min(col));
center_row=min(row)+fix((max(row)-min(row))./2);
center_col=min(col)+fix((max(col)-min(col))./2);
row_l=center_row-fix(bian./2);
col_l=center_col-fix(bian./2);
row_r=center_row+fix(bian./2);
col_r=center_col+fix(bian./2);
bias =50;
if (row_l-bias)<=0
    row_l=1+bias;
end
if (col_l-bias)<=0
    col_l=1+bias;
end

if row_r>(size(im,1)-bias)
    row_r=size(im,1)-bias;
end
if col_r>(size(im,1)-bias)
    col_r=size(im,1)-bias;
end

im =  im(row_l-bias:row_r+bias,col_l-bias:col_r+bias);   %�ҵ�ͼƬ����д���ֵ�λ��
%% 
[row,col] = size(im);  %��д���ֵ��к���
w = fix(row/long);   % fix��Ϊ��ȡ��
h = fix(col/long);
count = 0;
k=1;
feature = zeros(1,long^2);

for i=1:1:long %�ӵ�һ�п�ʼ
    for j=1:1:long  %�ӵ�һ�п�ʼ
        for m=(i-1)*w+1:i*w  
            for n=(j-1)*h+1:j*h  
                if im(m,n)==0   % ����Ǻ�ɫ�������������
                    count=count+1;
                end
            end
        end
        feature(k)=count/(w*h);  %��k����������  ��������������ֵΪ0
        count=0;
        k=k+1;
    end
end
end
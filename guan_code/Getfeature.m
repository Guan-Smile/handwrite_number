function feature = Getfeature(im)

[row,col] = find(im==0); %得到图片的上下左右的边界
im = im(min(row):max(row),min(col):max(col));   %找到图片中手写数字的位置

[row,col] = size(im);  %手写数字的行和列
w = fix(row/6);   % fix是为了取整
h = fix(col/6);
count = 0;
k=1;
feature = zeros(1,36);

for i=1:1:6 %从第一行开始
    for j=1:1:6  %从第一列开始
        for m=(i-1)*w+1:i*w  
            for n=(j-1)*h+1:j*h  
                if im(m,n)==0
                    count=count+1;
                end
            end
        end
        feature(k)=count/(w*h);  %第k个特征分量
        count=0;
        k=k+1;
    end
end
end
function r=parzen(w,h,x)
[rows,dimension]=size(w);
r=zeros(1,dimension);
for i=1:dimension
    hn=h;
    for j=1:rows
        hn=hn/sqrt(j);
        r(i)=r(i)+exp(-(x-w(j,:,i))*(x-w(j,:,i))'/(2*power(hn,2)))/(sqrt(2*3.14)*hn);
    end
    r(i)=r(i)/rows;
end

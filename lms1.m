function [W,Error,filt_op]=lms1(x,d,mue,ord)
for i=1:3
    X(:,:,i)=convm(x(:,i),ord);
end
[M,N,L]=size(X);
a0 = zeros(1,N);%zero padding
r1=X(:,:,1);%input
r2=X(:,:,2);%input
r3=X(:,:,3);%input
filt_op(1)=a0*r1(1,:)'+a0*r2(1,:)'+a0*r3(1,:)';
Error(1)=d(1)-filt_op(1); 
W(1,:) = a0 + mue*Error(1)*(conj(r1(1,:)+conj(r2(1,:))+conj(r3(1,:))));
    for k=2:M-ord+1;
        ss=W(k-1,:)*r1(k,:)'+W(k-1,:)*r2(k,:)'+W(k-1,:)*r3(k,:)';
        filt_op(k)=ss;
        Error(k)=d(k)-filt_op(k);
        W(k,:)=W(k-1,:)+mue*Error(k)*(conj(r1(k,:)+conj(r2(k,:))+conj(r3(k,:))));
    end
end


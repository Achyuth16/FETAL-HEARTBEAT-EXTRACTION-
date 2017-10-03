function [W,Error,filt_op ] = nlms1( x,d,beta,nord )
for i=1:3
X(:,:,i)=convm(x(:,i),nord);
end
[M,N,L]=size(X);
a0 = zeros(1,N);%zero padding
r1=X(:,:,1);%input
r2=X(:,:,2);%input
r3=X(:,:,3);%input
filt_op(1)=a0*r1(1,:)'+a0*r2(1,:)'+a0*r3(1,:)'; 
Error(1)=d(1)-filt_op(1);
denom=(r1(1,:)*r1(1,:)'+r2(1,:)*r2(1,:)'+r3(1,:)*r3(1,:)')+0.0001;
W(1,:) = a0 + beta/denom*Error(1)*(conj(r1(1,:)+conj(r2(1,:))+conj(r3(1,:))));
for k=2:M-nord+1;        
        ss=W(k-1,:)*r1(k,:)'+W(k-1,:)*r2(k,:)'+W(k-1,:)*r3(k,:)';
        filt_op(k)=ss;
        Error(k) = d(k) - filt_op(k);
        denom=(r1(k,:)*r1(k,:)'+r2(k,:)*r2(k,:)'+r3(k,:)*r3(k,:)')+0.0001;
        W(k,:)=W(k-1,:)+beta/denom*Error(k)*(conj(r1(k,:)+conj(r2(k,:))+conj(r3(k,:))));     
end
end


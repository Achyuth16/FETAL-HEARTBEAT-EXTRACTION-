function [W,Error,filt_op] = lms(x,d,mu,nord)
%lms function
X=convm(x,nord);
[M,N]=size(X);
if nargin < 5, a0 = zeros(1,N); end
a0=a0(:).';
filt_op(1)=a0*X(1,:).';
Error(1)=d(1) - filt_op(1);
W(1,:) = a0 + mu*Error(1)*conj(X(1,:));
if M>1
    for k=2:M-nord+1;
        filt_op(k,:)=W(k-1,:)*X(k,:).';
        Error(k,:) = d(k) - filt_op(k,:);
        W(k,:)=W(k-1,:)+mu*Error(k)*conj(X(k,:));%updated weights
    end;
end;
%%

function Y = convm(y,q)
N    = length(y)+2*q-2;
y    = y(:);
ypad = [zeros(q-1,1);y;zeros(q-1,1)];
for  i=1:q
     Y(:,i)=ypad(q-i+1:N-i+1);
     end; 


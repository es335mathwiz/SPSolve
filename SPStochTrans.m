%  [bTrans,dTrans] = SPStochTrans(h,scof)
%
%  Build the companion matrix
%  Solve for x_{t-nlag+1},...,x_{t} in terms of x_{t-nlag},...,x_{t-1}.
%  and conformable random shock impact on same

function   [bTrans,dTrans] = SPStochTrans(h,scof)
[hrows,hcols]=size(h);
[srows,scols]=size(scof);
neq=hrows;
nlags=(scols/neq)-1;

sinv=inv(scof(:,nlags*neq+1:(nlags+1)*neq));
if(nlags>1)
bTrans=[zeros((nlags-1)*neq,neq) eye((nlags-1)*neq);-sinv * scof(:,1:nlags*neq)];
dTrans=[zeros((nlags-1)*neq,neq);sinv];
else
bTrans=[-sinv * scof(:,1:neq)];
dTrans=sinv;
end

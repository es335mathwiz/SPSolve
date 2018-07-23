%  [b,rts,ia,nexact,nnumeric,lgroots,phi,F,AMAcode] = ...
%                       SPAmalg(h,neq,nlag,nlead,condn,uprbnd)
%
%  Solve a linear perfect foresight model using the matlab eig
%  function to find the invariant subspace associated with the big
%  roots.  This procedure will fail if the companion matrix is
%  defective and does not have a linearly independent set of
%  eigenvectors associated with the big roots.
% 
%  Input arguments:
% 
%    h         Structural coefficient matrix (neq,neq*(nlag+1+nlead)).
%    neq       Number of equations.
%    nlag      Number of lags.
%    nlead     Number of leads.
%    condn     Zero tolerance used as a condition number test
%              by numeric_shift and reduced_form.
%    uprbnd    Inclusive upper bound for the modulus of roots
%              allowed in the reduced form.
% 
%  Output arguments:
% 
%    b         Reduced form coefficient matrix (neq,neq*nlag).
%    rts       Roots returned by eig.
%    ia        Dimension of companion matrix (number of non-trivial
%              elements in rts).
%    nexact    Number of exact shiftrights.
%    nnumeric  Number of numeric shiftrights.
%    lgroots   Number of roots greater in modulus than uprbnd.
%    AMAcode     Return code: see function AMAerr.

function [b,rts,ia,nexact,nnumeric,lgroots,phi,F,AMAcode] = ...
                        SPAmalg_findPhi_findF(h,neq,nlag,nlead,condn,uprbnd)

originalH = h;
                    
if(nlag<1 | nlead<1) 
    error('AMA_eig: model must have at least one lag and one lead.');
end

% Initialization.
nexact   = 0;
nnumeric = 0;
lgroots  = 0;
iq       = 0;
AMAcode    = 0;
b=0;
qrows = neq*nlead;
qcols = neq*(nlag+nlead);
bcols = neq*nlag;
q        = zeros(qrows,qcols);
rts      = zeros(qcols,1);

% Compute the auxiliary initial conditions and store them in q.

[h,q,iq,nexact] = SPExact_shift(h,q,iq,qrows,qcols,neq);
   if (iq>qrows) 
      AMAcode = 61;
      return;
   end

[h,q,iq,nnumeric] = SPNumeric_shift(h,q,iq,qrows,qcols,neq,condn);
   if (iq>qrows) 
      AMAcode = 62;
      return;
   end

%  Build the companion matrix.  Compute the stability conditions, and
%  combine them with the auxiliary initial conditions in q.  

[a,ia,js] = SPBuild_a(h,qcols,neq);

if (ia ~= 0)
   [w,rts,lgroots] = SPEigensystem(a,uprbnd);
   q = SPCopy_w(q,w,js,iq,qrows);
end

phi = SPmakePhi(q,originalH,nlag,nlead,neq);
disp('phi = ');
disp(' ');
disp(phi);

F = SPmakeF(phi,originalH,q,nlag,nlead,neq);
disp('F = ');
disp(' ');
disp(F);

test = nexact+nnumeric+lgroots;
   if (test > qrows) AMAcode = 3;
   elseif (test < qrows) AMAcode = 4;
   end

% If the right-hand block of q is invertible, compute the reduced form.

if(AMAcode==0)
[nonsing,b] = SPReduced_form(q,qrows,qcols,bcols,neq,condn);

if ( nonsing & AMAcode==0) AMAcode =  1;
elseif (~nonsing & AMAcode==0) AMAcode =  5;
elseif (~nonsing & AMAcode==3) AMAcode = 35;
elseif (~nonsing & AMAcode==4) AMAcode = 45;
end
end;

function [b,rts,ia,nexact,nnumeric,lgroots,AMAcode] = ...
                        SPGenTestMatsAmalg(modnam,h,neq,nlag,nlead,condn,uprbnd)
%  [b,rts,ia,nexact,nnumeric,lgroots,AMAcode] = ...
%                       SPGenTestMatsAmalg(h,neq,nlag,nlead,condn,uprbnd)
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

% Original author: Gary Anderson
% Original file downloaded from:
% http://www.federalreserve.gov/Pubs/oss/oss4/code.html
% Adapted for Dynare by Dynare Team, in order to deal
% with infinite or nan values.
%
% This code is in the public domain and may be used freely.
% However the authors would appreciate acknowledgement of the source by
% citation of any of the following papers:
%
% Anderson, G. and Moore, G.
% "A Linear Algebraic Procedure for Solving Linear Perfect Foresight
% Models."
% Economics Letters, 17, 1985.
%
% Anderson, G.
% "Solving Linear Rational Expectations Models: A Horse Race"
% Computational Economics, 2008, vol. 31, issue 2, pages 95-113
%
% Anderson, G.
% "A Reliable and Computationally Efficient Algorithm for Imposing the
% Saddle Point Property in Dynamic Models"
% Journal of Economic Dynamics and Control, 2010, vol. 34, issue 3,
% pages 472-489

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
hin=h;
[h,q,iq,nexact] = SPGenTestMatsExact_shift(h,q,iq,qrows,qcols,neq);
   if (iq>qrows) 
      AMAcode = 61;
      return;
   end
hexact=h;
qexact=q
[h,q,iq,nnumeric] = SPGenTestMatsNumeric_shift(h,q,iq,qrows,qcols,neq,condn);
   if (iq>qrows) 
      AMAcode = 62;
      return;
   end

%  Build the companion matrix.  Compute the stability conditions, and
%  combine them with the auxiliary initial conditions in q.  
hnumeric=h;qnumeric=q;
[a,ia,js] = SPGenTestMatsBuild_a(h,qcols,neq);

if (ia ~= 0)
    if any(any(isnan(a))) || any(any(isinf(a))) 
        disp('A is NAN or INF')
        AMAcode=63; 
        return 
    end 
    [w,rts,lgroots]=SPGenTestMatsEigensystem(a,uprbnd,min(length(js),qrows-iq+1));


    q = SPGenTestMatsCopy_w(q,w,js,iq,qrows);
end

test = nexact+nnumeric+lgroots;
if (test > qrows)
    AMAcode = 3;
elseif (test < qrows)
    AMAcode = 4;
end

% If the right-hand block of q is invertible, compute the reduced form.

if(AMAcode==0)
    [nonsing,b]=SPGenTestMatsReduced_form(q,qrows,qcols,bcols,neq,condn);
    if ( nonsing && AMAcode==0)
        AMAcode =  1;
    elseif (~nonsing && AMAcode==0)
        AMAcode =  5;
    elseif (~nonsing && AMAcode==3)
        AMAcode = 35;
    elseif (~nonsing && AMAcode==4)
        AMAcode = 45;
    end
    savefile=[modnam '.mat'];
    rroots=real(rts);iroots=imag(rts);
    if(nonsing)
        myNonsing=1;
    else
        myNonsing=0;
    end
    dims=[neq nlag nlead];  
    save(savefile,'hin','hexact','qexact','nexact','hnumeric',...
    'qnumeric','nnumeric','a','ia','js','w','rroots','iroots','lgroots',...
    'q','myNonsing','b','AMAcode','dims','-v4');
end;

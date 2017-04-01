%
%SPGenTestMatsFunction
% GenTestMats a linear rational expectations model with AMA.  
%function [cof, scof, cofb, param_, eqname_, endog_, 
%eqtype_, vtype_, neq, nlag, nlead, rts, lgrts] = ... 
%         SPGenTestMats(dirnam, modnam, parnam)
function [cof, scof, cofb, param_, eqname_, endog_,...
 eqtype_, vtype_, neq, nlag, nlead, rts, lgrts,AMAcode] = ... 
         SPGenTestMatsFunction(dirnam, modnam, parnam)
cof=[];
 scof=[];
 cofb=[];
 param_=[];
 eqname_=[];
 endog_=[];
 eqtype_=[];
 vtype_=[];
 neq=[];
 nlag=[];
 nlead=[];
 rts=[];
 lgrts=[];
if(not(SPInstallDoneQ))
error('execute SPInstall with pwd your sp_solve directory')
else
addpath(SPSolveDir);
eval(['chdir ',char(39) dirnam char(39)])

olddirnam = dirnam;
oldmodnam = modnam;
oldparnam = parnam;

%  Modelez syntax parser:


  [parserRetCode,...
param_,np,modname,neq,nlag,nlead,eqname_,eqtype_,endog_,delay_,vtype_]=...
SPParser(dirnam,modnam);
if(parserRetCode==0)
  %  Define the parameter vector.

  if( length(param_) )
    eval(parnam)
    [npar,ncols] = size(param_);
    p = zeros(npar,1);
    for i = 1:npar
      p(i) = eval(param_(i,:));
    end
  else
    p = [];
  end

  % Numerical tolerances for AMA

  epsi   = 2.2e-16;
  condn  = 1.e-10;
  uprbnd = 1 + 1.e-6;

  % ---------------------------------------------------------------------
  % Construct structural coefficient matrix.
  % ---------------------------------------------------------------------

  %  Run compute_AMA_matrices.

  eval([modnam,'_AMA_matrices']);

  % Construct cof matrix from cofg, cofh

  [rh,ch] = size(cofh);
  [rg,cg] = size(cofg);
  cof = zeros(rh,ch);
  cof(1:rg,1:cg) = cofg;
  cof = cof + cofh;

  [cofb,rts,ia,nex,nnum,lgrts,AMAcode] = SPGenTestMatsAmalg(modnam,cof,neq,nlag,nlead,condn,uprbnd);

  if AMAcode>1,
    disp(SPAMAerr(AMAcode));
  else
    scof = SPObstruct(cof,cofb,neq,nlag,nlead);
  end
else
  'parser signaled failure with non zero return code'
end
end


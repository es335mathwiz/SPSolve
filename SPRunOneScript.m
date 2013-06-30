function [varargout]=SPRunOneScript(oneVersionDir,dirnam,parnam,modnam)
%more output args gets you more from the list
%cofb,rts,ia,nex,nnum,lgrts,aimcode%[pgmUsed,theCofb]scof cof,neq,nlag,nlead,condn,uprbnd cofg cofh
parserRetCode=0;
oldPath=path;
addpath(oneVersionDir);
parseflag=1;trollflag=0;
solve_path=oneVersionDir;
addpath(oneVersionDir);
cd(oneVersionDir);
disp(['SPRunOneScript: using versionDir=' oneVersionDir]);
SPSolve
pgmUsed=which('SPSolve');
path(oldPath);
varargout{1}=pgmUsed;
if(parserRetCode==0)
%if(nargout>1)varargout{2}=[neq nlag nlead condn uprbnd]; end;
if(nargout>1)varargout{2}=[neq nlag nlead ]; end;
if(nargout>2)varargout{3}=cof; end;
%if(nargout>3)varargout{4}=[ia,nex,nnum,lgrts]; end;
if(nargout>3)varargout{4}=[lgrts]; end;
if(nargout>4)varargout{5}=rts; end;
if(nargout>5)varargout{6}=cofb; end;
if(nargout>6)varargout{7}=scof; end;
else
'parser return code non zero'
if(nargout>1)varargout{2}=[]; end;
if(nargout>2)varargout{3}=[]; end;
if(nargout>3)varargout{4}=[]; end;
if(nargout>4)varargout{5}=[]; end;
if(nargout>5)varargout{6}=[]; end;
if(nargout>6)varargout{7}=[]; end;
end;
disp('SPRunOneScript: done')

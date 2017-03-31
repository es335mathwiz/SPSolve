%
%SPSolve test matrices
% Solve a linear rational expectations model with AMA.  
%function [cof, scof, cofb, param_, eqname_, endog_, 
%eqtype_, vtype_, neq, nlag, nlead, rts, lgrts] = ... 
%         SPGenTestMats(dirnam, modnam, parnam)
function varargout = SPGenTestMats(varargin)
disp(['SPSolve version:' SPSolveVersion])
if(and(nargout==0,nargin==0))
warning('calling SPSolve as a script: not recommended') 



%SPClearGlobalOutputVars
disp(' ')
disp(' ')
disp('When using script form, it may be necessary to')
disp('use SPDeclareGlobals at the beginning')
disp('of your program and/or matlab session')
disp('in order to avoid matlab name conflict warnings.')
disp(' ')
disp(' ')

disp('Please substitute the following function call')
disp('for the old style SPSolve script reference')
disp(' ')
disp(' ')
disp('%***********************************************')
disp('%SPDeclareGlobals;%should precede dirnam,modnam,parnam assignments')
disp('%dirnam=xxx;')
disp('%modnam=yyy;')
disp('%parnam=zzz;')
disp('[cof, scof, cofb, param_, eqname_,...')
disp(' endog_, eqtype_, vtype_, neq, nlag, nlead, rts, lgrts,AMAcode]=...')
disp('SPSolve(dirnam, modnam, parnam)')
disp('%***********************************************')
disp(' ')
disp(' ')

%global dirnam modnam parnam;
SPDeclareGlobals;
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

[lcof, lscof, lcofb, lparam_, leqname_, lendog_,...
 leqtype_, lvtype_, lneq, lnlag, lnlead, lrts, llgrts,AMAcode]=...
SPGenTestMatsFunction(dirnam, modnam, parnam);



disp('SPGenTestMats resetting global output vars')
%clear global cof scof cofb param_ eqname_ ...
%endog_ eqtype_ vtype_ neq nlag nlead rts lgrts
%global cof scof cofb param_ eqname_ ...
%endog_ eqtype_ vtype_ neq nlag nlead rts lgrts

cof=lcof;scof=lscof;cofb=lcofb;param_=lparam_;eqname_=leqname_;endog_=lendog_;
eqtype_=leqtype_;vtype_=lvtype_;neq=lneq;nlag=lnlag;nlead=lnlead;
rts=lrts;lgrts=llgrts;
elseif(and(nargout==13,nargin==3))

[lcof, lscof, lcofb, lparam_, leqname_, lendog_,...
 leqtype_, lvtype_, lneq, lnlag, lnlead, lrts, llgrts]=...
SPGenTestMatsFunction(varargin{1},varargin{2},varargin{3});
varargout{1}=lcof;
varargout{2}=lscof;
varargout{3}=lcofb;
varargout{4}=lparam_;
varargout{5}=leqname_;
varargout{6}=lendog_;
varargout{7}=leqtype_;
varargout{8}=lvtype_;
varargout{9}=lneq;
varargout{10}=lnlag;
varargout{11}=lnlead;
varargout{12}=lrts;
varargout{13}=llgrts;
elseif(and(nargout==14,nargin==3))

[lcof, lscof, lcofb, lparam_, leqname_, lendog_,...
 leqtype_, lvtype_, lneq, lnlag, lnlead, lrts, llgrts,AMAcode]=...
SPGenTestMatsFunction(varargin{1},varargin{2},varargin{3});
varargout{1}=lcof;
varargout{2}=lscof;
varargout{3}=lcofb;
varargout{4}=lparam_;
varargout{5}=leqname_;
varargout{6}=lendog_;
varargout{7}=leqtype_;
varargout{8}=lvtype_;
varargout{9}=lneq;
varargout{10}=lnlag;
varargout{11}=lnlead;
varargout{12}=lrts;
varargout{13}=llgrts;
varargout{14}=AMAcode;
else

helpStr=help('SPGenTestMats');
error(['SPGenTestMats: wrong number of args. Instead, use' helpStr])
end


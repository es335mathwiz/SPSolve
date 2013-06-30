function res=SPMatrixMatchQ(varargin)
matA=varargin{1};
matB=varargin{2};
if(length(varargin)>2);
tol=varargin{3};
else;
tol=10e-8;
end;
%compare elements of two matrices 
res=(max(max(abs(matA-matB))))<tol;

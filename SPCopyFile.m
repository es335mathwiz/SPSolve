function res=SPCopyFile(fileA,fileB)
if(exist(fileA))
if(exist('SPSolveUtils.SPSolve'))
SPSolveUtils.SPSolve.copyFile(fileA,fileB);
res=0;
elseif(exist('javaaddpath'))
javaaddpath(SPJavaUtilsDir);
SPSolveUtils.SPSolve.copyFile(fileA,fileB);
res=0;
else
copyExpr=...
['java -classpath '  char(34) SPJavaUtilsDir  char(34) ...
	' SPSolveUtils.doCopy ', char(34) fileA char(34) ...
' ' char(34) fileB char(34) ]
msgval=unix(copyExpr);
end
end
%if(SPWindowsQ)
%[ss,mm]=system(['copy ' char(34) fileA char(34) ',' char(34) fileB char(34) ]);
%%['copy  ' char(34) fileA char(34) char(34) fileB char(34) ];
%else
%[ss,mm]=unix(['cp  ' char(39) fileA char(39) ' ' char(39) fileB char(39) ]);
%end
%res=ss;

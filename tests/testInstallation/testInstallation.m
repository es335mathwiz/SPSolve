function testRes=testInstallation
%SPDeclareGlobals
%template for program comparing Root cofb and oldVersion cofb
disp('running tests/testInstallation.m')
disp('testInstallation: should return [1 1 1]')
%clear all;
testRes=[];
%provide 
%name for test pgm(must be dir name also filename without .m added)

disp('');
disp('');
disp('');
disp('');
disp('********************************************************************');
disp('********************************************************************');
disp('testInstallation:example7')
testnam='testInstallation'; 
parnam='setexample';   %name for parameter file
modnam='example7';         %name for model file
%each of these file should be in a subdir of tests with name= testnam
%note, running ant substitutes actual path name for @string@ values

addpath(SPSolveDir);
if(SPWindowsQ)
dirnam=[strcat(SPSolveTestDir,'testInstallation\') ];
%system(['erase ' dirnam '*data.m']);
%system(['erase ' dirnam '*matrices.m']);
else
dirnam=[strcat(SPSolveTestDir,'testInstallation/') ];
%unix(['rm ' dirnam '*data.m']);
%unix(['rm ' dirnam '*matrices.m']);
end
SPEraseFile([dirnam,'example7_aim_data.m' ]);

[newUsed,newInParm,newInCof,newOutParm,newRts,newCofb,newScof]=...
		SPRunOne(SPSolveDir,dirnam,parnam,modnam);


load 'installBenchData';

inCofQ=SPMatrixMatchQ(newInCof,oldInCof);
cofbQ=SPMatrixMatchQ(newCofb,oldCofb);

%successful test should have last line evaluate to true value (ie 1.0 in matlab)
res=and(inCofQ,cofbQ);
testRes=[testRes res];
disp('done');
disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');



disp('********************************************************************');
disp('********************************************************************');
disp('testInstallation:SPParser applied to SPTrollPrimer')
if(SPWindowsQ)
theDir=[SPSolveTestDir 'testInstallation\'];
else
theDir=[SPSolveTestDir 'testInstallation/'];
end

SPEraseFile([theDir,'SPTrollPrimer_aim_data.m' ]);
 [nparserRetCode,...
      nparam_,nnp,nmodname,nneq,nnlag,nnlead,neqname_,neqtype_,nendog_,ndelay_,nvtype_]=...
    SPParser(theDir,'SPTrollPrimer');
testRes=[testRes not(nparserRetCode)];
cd(SPSolveDir);
disp('done');
disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');

disp('********************************************************************');
disp('********************************************************************');
disp('testInstallation:SPSolve old style script call')
%SPDeclareGlobals;


SPEraseFile([theDir,'example7_aim_data.m' ]);

clear dirnam modnam parnam;
SPDeclareGlobals

dirnam=theDir;
modnam='example7';
parnam='setexample';
SPSolve
%SPDeclareGlobals
inCofScriptQ=SPMatrixMatchQ(newInCof,cof);
cofbScriptQ=SPMatrixMatchQ(newCofb,cofb);


%successful test should have last line evaluate to true value (ie 1.0 in matlab)
res=and(inCofScriptQ,cofbScriptQ);
testRes=[testRes res];
disp('done');
disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');

function res=tryAMAcode
disp('********************************************************************');
disp('********************************************************************');
disp('tryAMAcode:')

res=0;
[ss,ww]=unix('uname');
testnam='tryAMAcode'; 
parnam='setexample';   %name for parameter file
modnam='example7';         %name for model file
%each of these file should be in a subdir of tests with name= testnam


if(SPWindowsQ)
dirnam=[strcat(SPSolveTestDir,'tryAMAcode\') ];
%system(['erase ' dirnam '*data.m']);
%system(['erase ' dirnam '*matrices.m']);
else
dirnam=[strcat(SPSolveTestDir,'tryAMAcode/') ];
%unix(['rm ' dirnam '*data.m']);
%unix(['rm ' dirnam '*matrices.m']);
end

SPEraseFile([dirnam,'example7_AMA_data.m' ]);


[cof, scof, newCofb, param_, eqname_, endog_,...
 eqtype_, vtype_, neq, nlag, nlead, rts, lgrts,AMAcode]=...
		SPSolve(dirnam,modnam,parnam);



%successful test should have last line evaluate to true value(ie 1.0 in matlab)
load 'tryAMAcodeData';

res=and(AMAcode,SPMatrixMatchQ(newCofb,oldCofb));

disp('done');
disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');

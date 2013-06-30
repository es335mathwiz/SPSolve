function testRes=runTests
[ss,ww]=unix('uname');
if(length(strmatch('SunOS',ww))==0)
disp('To be successful, must run on solaris machine so that C parser works.')
disp('Tests not run.')
else
disp('should return [1 1 1]')
testRes=[];
cd(SPSolveDir);
addpath(SPSolveDir);
addpath([SPSolveTestDir 'bobExample/'])
testRes=[testRes bobExample];
cd(SPSolveDir);
addpath([SPSolveTestDir 'spSolveAthan/'])
testRes=[testRes spSolveAthan];
cd(SPSolveDir);
addpath([SPSolveTestDir 'spSolveHabitmod/'])
testRes=[testRes spSolveHabitmod];
cd(SPSolveDir);
if(all(testRes))
disp('all tests successful')
else
disp('one or more errors')
end
end

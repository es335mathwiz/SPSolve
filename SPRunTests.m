function testRes=runTests
if(SPInstallDoneQ)
disp('runTests: should return [1 1 1 1 1]')
testRes=[];
cd(SPSolveDir);
addpath(SPSolveDir);
addpath([SPSolveTestDir 'testInstallation/'])
testRes=SPParsersAvailableQ;
testRes=[testRes testInstallation];
addpath([SPSolveTestDir 'tryAimcode/'])
testRes=[testRes tryAimcode];
if(all(testRes))
disp('all tests successful')
else
disp('one or more errors')
end


cd(SPSolveDir);
else
error('execute SPInstall with pwd your sp_solve directory')
end


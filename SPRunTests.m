function testRes=runTests
if(SPInstallDoneQ)
disp('runTests: should return [1 1 1 1 1]')
testRes=[];
cd(SPSolveDir);
addpath(SPSolveDir);
addpath([SPSolveTestDir 'testInstallation/'])
testRes=[testRes testInstallation];
testRes=[testRes SPParsersAvailableQ];
addpath([SPSolveTestDir 'tryAMAcode/'])
testRes=[testRes tryAMAcode];
if(all(testRes))
disp('all tests successful')
else
disp('one or more errors')
end


cd(SPSolveDir);
else
error('execute SPInstall with pwd your sp_solve directory')
end


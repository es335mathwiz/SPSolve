diaryFile='/tmp/SPSolveCronJob.txt';

if(exist(diaryFile))
SPEraseFile(diaryFile);
end
mailPgm='Mail'
diary(diaryFile);
[ss,mm]=unix('hostname');
theHostName=mm(1:end-1)
thePwd=pwd
addpath(pwd);
testRes=SPRunTests
goodSbjct=...
 [ mailPgm ' -s ' char(39) theHostName thePwd ...
' SPSolve Successful ' char(39) ...
' ' SPInstaller ' < ']
badSbjct= [ mailPgm ' -s ' ...
char(39) theHostName ' **************SPSolve Failed********* ' char(39) ...
' ' SPInstaller '  < ']
diary off
if(all(testRes))
unix([goodSbjct diaryFile '&'])
else
unix([badSbjct diaryFile])
end
if(exist(diaryFile))
SPEraseFile(diaryFile);
end
quit



function res=SPInstall
res=0;
osName=SPOsName;
theUser=char(java.lang.System.getProperty('user.name'));
fileSep=java.io.File.separatorChar;
solveDirName=['SPSolveDir' osName '.m'];
if(exist(solveDirName))
disp([solveDirName ' already present.']);
disp('To do/redo generic  initialization,');
disp(['SPEraseFile(' char(39) solveDirName char(39) ')']);
disp('then type SPInstall at  matlab prompts.');
else
aPwd=char(java.lang.System.getProperty('user.dir'));
%the FED uses an automounter, uwd gives a universally accessible filename
[ss,theUwd]=unix('uwd');
if(ss)
disp(['default SPSolve root dir=' aPwd]);
userInput=...
input(['enter SPSolve root dir or type enter to get default:'],'s');
if(isempty(userInput))
thePwd=aPwd
else
thePwd=userInput
end
else
thePwd=theUwd(1:end-1);
end
fileNameChk=[thePwd fileSep 'SPSolve.m'];
fileNameNow=[thePwd fileSep solveDirName];
fileNameCron=[thePwd fileSep 'SPCrontabFile'];
fileNameCronScript=[thePwd fileSep 'SPCron.sh'];
fileNameInstaller=[thePwd fileSep 'SPInstaller.m'];
if(exist(fileNameChk,'file'))
disp(['creating ' solveDirName]);
disp('edit this file if the root dir path is inappropriate');
disp(thePwd);
     fid = fopen(fileNameNow,'w');
     rootDir(fid,thePwd);
     fclose(fid);
     fid = fopen(fileNameCron,'w');
     cronPath(fid,thePwd);
     fclose(fid);
     fid = fopen(fileNameCronScript,'w');
     cronScript(fid,thePwd);
     fclose(fid);
     fid = fopen(fileNameInstaller,'w');
     installer(fid,theUser);
     fclose(fid);
res=SPClasspath;
else
error('SPSolve.m not in pwd: aborting initialization');
end

if(strcmp('Windows_XP',osName))
disp('installer note: windows users sharing')
disp('this program between machines will need to')
disp('map the same drive letter to the same directory')
disp('you used during this installation')
end
disp('SPInstall has run successfully');


clear all;
clear classes;
addpath('.');
rehash;
res=1;
end


function newres =rootDir(fid,thePwd)
fileSep=java.io.File.separatorChar;
     fprintf(fid,'function res=SPSolveDir\n');
     fprintf(fid,'res=[%c%s%c %c%c%c];\n',...
     char(39),thePwd,char(39),char(39),fileSep,char(39));
newres=1;



function newcron =cronPath(fid,thePwd)
fileSep=java.io.File.separatorChar;
     fprintf(fid,'16 3 * * 0-6 %s%cSPCron.sh\n',...
     thePwd,fileSep);
newcron=1;

function newscript =cronScript(fid,thePwd)
fileSep=java.io.File.separatorChar;
     fprintf(fid,'csh .cshrc\n');
     fprintf(fid,'cd %s\n',thePwd);
     fprintf(fid,'matlab -nosplash -nodesktop  -r SPCronMatlabCommands\n');
newscript=1;



function newres =installer(fid,theUser)
fileSep=java.io.File.separatorChar;
     fprintf(fid,'function res=SPInstaller\n');
     fprintf(fid,'res=[%c%s%c];\n',...
     char(39),theUser,char(39));
newres=1;

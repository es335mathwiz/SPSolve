function res=SPClasspath
osName=char(java.lang.System.getProperty('os.name'));
cFile=which('classpath.txt');
SPCopyFile(cFile,['SPClasspath' osName '.txt']);
fid=fopen(['SPClasspath' osName '.txt'],'a');
disp('creating augmented version of classpath.txt');
disp(['placing it in ./SPClasspath' osName '.txt']);
fprintf(fid,'\n');
fprintf(fid,strrep(SPModelezParserDir,'\','\\'));
fprintf(fid,'\n');
fprintf(fid,strrep(SPTrollParserDir,'\','\\'));
fprintf(fid,'\n');
res=cFile;

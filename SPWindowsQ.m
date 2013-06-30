function res=SPWindowsQ
osName=char(java.lang.System.getProperty('os.name'));
res=length(findstr('Windows',osName))>0;


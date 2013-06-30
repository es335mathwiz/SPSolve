function res=SPOsName
res=strrep(char(java.lang.System.getProperty('os.name')),' ','_');

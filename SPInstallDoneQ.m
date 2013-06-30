function res=SPInstallDoneQ
osName=SPOsName;
res=(exist(['SPSolveDir' osName '.m'])>0);



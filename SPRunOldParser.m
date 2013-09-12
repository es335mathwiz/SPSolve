function res= SPRunOldParser(dirnam,modnam)
disp('entering SPRunOldParser')
res=0;
theOs=SPOsName;


if(strcmp('Windows_XP',theOs))
dirNow=pwd;
cd(dirnam);
 parsexpr = ['!',...
 SPSolvePreviousVersionDir, 'mdlez-AMA ' dirnam,modnam  ]
cd(dirNow);
end
if(strcmp('Solaris',theOs))
 parsexpr = ['!', '(cd ' dirnam ';'...
 SPSolvePreviousVersionDir, 'mdlez-AMA ' dirnam,modnam ')']
end
if(strcmp('Linux',theOs))
 parsexpr = ['!','(cd ' dirnam ';'...
 SPSolvePreviousVersionDir, 'mdlez-AMALinux ' dirnam,modnam ')']
end
%msgval=eval(parsexpr);

eval(parsexpr);

disp('leaving SPRunOldParser')

function ...  
[parserRetCode,...
    param_,np,modname,neq,nlag,nlead,eqname_,eqtype_,endog_,delay_,vtype_]=...
    SPParser(dirnam,modnam) 
	global SPObnoxiouslyLongUniqueModelezName;
    global SPObnoxiouslyLongUniqueTrollName; 
	global SPObnoxiouslyLongUniqueParserRunQ; 
% Parser setup for modelez    syntax models
    if(and(isempty(SPObnoxiouslyLongUniqueParserRunQ),...
    exist('gov.frb.ma.msu.toMatlab.AMAtoMatlab','class')==8))
    'found AMA on system classpath' 
	disp('initializing parsers');
    parsexpr =...
   [ 'SPObnoxiouslyLongUniqueModelezName='...
	'gov.frb.ma.msu.toMatlab.AMAtoMatlab(java.lang.System.in);'];
    % ['gov.frb.ma.msu.toMatlab.AMAtoMatlab.notMain('...  
% char(39) SPSolveDir    'SPModelezPrimer' char(39) ')']
  
  eval(parsexpr);
  parsexpr =...
      'SPObnoxiouslyLongUniqueTrollName=gov.frb.ma.msu.AMA(java.lang.System.in);';
  %	['gov.frb.ma.msu.AMA.notMain('...
  %	  char(39) SPSolveDir 'SPTrollPrimer' char(39) ')']
  eval(parsexpr);
  SPObnoxiouslyLongUniqueParserRunQ=1;
else
  
  if(isempty(SPObnoxiouslyLongUniqueParserRunQ))
    disp('parser not yet run');
    disp('or not present on matlab classpath')
    if(exist('javaaddpath'))
      disp('dynamically adding parsers to java path');
      javaaddpath(SPModelezParserDir);
      javaaddpath(SPTrollParserDir);
      global SPObnoxiouslyLongUniqueModelezName;
      global SPObnoxiouslyLongUniqueTrollName;
      global SPObnoxiouslyLongUniqueParserRunQ;
    else
      disp('this matlab version cannot dynamically add parsers to java path');
      disp('you can add the appropriate classpath.txt to static java path');
      disp('review calling java from matlab in the external interfaces/API volume');
    end
    SPObnoxiouslyLongUniqueParserRunQ=1;
    
    if(exist('gov.frb.ma.msu.toMatlab.AMAtoMatlab','class')==8)
      %    'found AMA on classpath'
      disp('initializing parsers');
      parsexpr =...
	  'SPObnoxiouslyLongUniqueModelezName=gov.frb.ma.msu.toMatlab.AMAtoMatlab(java.lang.System.in);';
      %	['gov.frb.ma.msu.toMatlab.AMAtoMatlab.notMain('...
      %	  char(39) SPSolveDir 'SPModelezPrimer' char(39) ')']
      
      eval(parsexpr);
      parsexpr =...
	  'SPObnoxiouslyLongUniqueTrollName=gov.frb.ma.msu.AMA(java.lang.System.in);';
      %	['gov.frb.ma.msu.AMA.notMain('...
      %	  char(39) SPSolveDir 'SPTrollPrimer' char(39) ')']
      eval(parsexpr);
    end;
  else
    disp('no need to initialize parsers: already done or irrelevant');
  end
end;

parserRetCode=0;
msgval=[];
parseflag=1;
if(parseflag)
  dataFile=[ modnam '_AMA_data.m'];
  matricesFile=[modnam '_AMA_matrices.m'];
  %  disp('SPParser ignores global parse flag variable');
  %  disp('SPParser does not parse file if parse output exists');
  %  disp('and is newer than source');
  if(exist([ dirnam dataFile ]))
    if(targetFileNewerThanSrcFile(dirnam,dataFile,modnam))
      disp('Existing parse output newer than source.')
      disp('To force parsing, delete or rename: ')
      disp(    [char(34) dirnam dataFile char(34)]);
    else
      disp('existing parse output older than source')
      SPEraseFile([dirnam dataFile ]);
      SPEraseFile([ dirnam matricesFile ]);
      actuallyRunParser(  dirnam,modnam  )
    end
  else
    actuallyRunParser(  dirnam,modnam )
  end;
end  





if(exist([ dirnam dataFile ]))
  if(targetFileNewerThanSrcFile(dirnam,dataFile,modnam))
    
    % Run compute_AMA_data:
    if(parserRetCode==0)
      
      addpath(dirnam);
      
      
      [param_,np,modname,neq,nlag,nlead,eqname_,eqtype_,endog_,delay_,vtype_] = ...
	  eval([modnam,'_AMA_data']);
      
      if(parseflag)
	seq  = find(eqtype_==0);
	dvar = find(vtype_==0);
	if(length(seq)~=length(dvar))
	  disp(' ');
	  warning(...
	      'Number of data variables not equal to number of stochastic equations.');
	  disp(' ');
	end
      end
      param_  = setstr(param_);
      endog_  = setstr(endog_);
      eqname_ = setstr(eqname_);
      modname = setstr(modname');
      param_  =  SPNmfix(param_);
      endog_  =  SPNmfix(endog_);
      eqname_ =  SPNmfix(eqname_);
    else
      'parser signaled failure with non zero return code'
    end;
    parserRetCode=0;
  else
    disp('parser failed to produce new output')
    parserRetCode=1;
  end
else
  disp('parser failed to produce new output')
  parserRetCode=1;
end

function res=targetFileNewerThanSrcFile(theDir,targetFile,srcFile)
if(exist([  srcFile  ],'file'))
  if(exist([  targetFile  ],'file'))
    dirInfo=dir(theDir);
    dirNames={dirInfo.name};
    dirDates={dirInfo.date};
    aDateNum=datenum(dirDates(strmatch(targetFile,dirNames,'exact')));
    bDateNum=datenum(dirDates(strmatch(srcFile,dirNames,'exact')));
    res=aDateNum>bDateNum;
  else
    res=0;
  end
else
  error('src file not present');
end


function eRes=actuallyRunParser(dirnam,modnam)
SPCopyFile([SPSolveDir 'SPAMADataStub.m'],...
    [dirnam modnam,'_AMA_data.m']);
modFile=[dirnam,modnam];
theLang=SPModelLanguage(modFile);
if(strcmp(theLang,'troll'))
  actuallyRunTrollParser(modFile);
elseif(strcmp(theLang,'modelez'))
  actuallyRunModelezParser(modFile);
else
  error('model language not recognized and not parsed');
end
disp(['chose ' theLang ' parser'])

function tRes=actuallyRunTrollParser(modFile)
global SPObnoxiouslyLongUniqueModelezName;
global SPObnoxiouslyLongUniqueTrollName;
global SPObnoxiouslyLongUniqueParserRunQ;

if(exist('gov.frb.ma.msu.AMA','class')==8)
  %  disp('found AMA on classpath')
  parsexpr = ...
      ['SPObnoxiouslyLongUniqueTrollName.runParser(' char(39) modFile char(39) ')'];
  msgval=eval(parsexpr);
else
  
  disp('did not find AMA on matlab classpath, trying system call to java')
  parsexpr = ['java -classpath ' char(34) SPTrollParserDir  char(34) ...
	' gov.frb.ma.msu.AMA ',char(34) modFile char(34)];
  msgval=unix(parsexpr);
end;

function mRes=actuallyRunModelezParser(modFile)
global SPObnoxiouslyLongUniqueModelezName;
global SPObnoxiouslyLongUniqueTrollName;
global SPObnoxiouslyLongUniqueParserRunQ;

if(exist('gov.frb.ma.msu.toMatlab.AMAtoMatlab','class')==8)
  %  'found AMA on classpath'
  parsexpr = [...
	'SPObnoxiouslyLongUniqueModelezName.runParser('...
	char(39) modFile char(39) ')'];
  msgval=eval(parsexpr);
else
  
  disp('did not find AMA on classpath, trying system call to java');
  parsexpr = ['java -classpath '  char(34) SPModelezParserDir  char(34) ...
	' gov.frb.ma.msu.toMatlab.AMAtoMatlab ', char(34) modFile char(34)];
  msgval=unix(parsexpr);
end;
mlock;

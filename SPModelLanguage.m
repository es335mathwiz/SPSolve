function res=SPModelLanguage(fName)
%fid=fopen([char(39) fName char(39) ],'r');
fid=fopen([ fName  ],'r');
if(fid<0)
error(['cannot open file:' fName]);
end
res='notRecognized';
theChars=[' '];
aMatch=0;
anEndFile=0;
usemodPat='usemod';
modelPat='model';
while(not(or(aMatch,anEndFile)))
[cc,numChars]=fread(fid,6,'uint8=>char');
if(numChars~=0)
theChars=[theChars lower(cc)'];
else
anEndFile=1;
end
usemodPos=findstr(theChars,usemodPat);
modelPos=findstr(theChars,modelPat);
if(length(usemodPos)>0)
aMatch=1;
res='troll';
elseif(length(modelPos)>0)
aMatch=1;
res='modelez';
end
end


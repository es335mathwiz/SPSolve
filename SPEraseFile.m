function res=SPEraseFile(fileName)
res=0;
if(exist(fileName))
fileToGo=java.io.File(fileName);
res=fileToGo.delete;
end



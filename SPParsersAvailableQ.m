function res = SPParsersAvailableQ
res=and(exist('gov.frb.ma.msu.toMatlab.AMAtoMatlab','class')==8,...
exist('gov.frb.ma.msu.AMA','class')==8)
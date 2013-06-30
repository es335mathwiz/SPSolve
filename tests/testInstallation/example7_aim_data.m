function [param_,np,modname,neq,nlag,nlead,eqname_,eqtype_,endog_,delay_,vtype_] = ...
     example7_aim_data()

% example7_aim_data()
%     This function will return various information about the AIM model,
%     but will not compute the G and H matrices.

  eqname = cell(4, 1);
  param = cell(5, 1);
  endog = cell(4, 1);
  delay = zeros(4, 1);
  vtype = zeros(4, 1);
  eqtype = zeros(4, 1);

  modname = 'example7';
  neq = 4;
  np = 5;
  nlag = 1;
  nlead = 1;

  eqname(1) = cellstr('is');
  eqname(2) = cellstr('phillips');
  eqname(3) = cellstr('dr');
  eqname(4) = cellstr('policy');
  eqname_ = char(eqname);

  eqtype(1) = 1;     eqtype(2) = 1;     eqtype(3) = 1;   
  eqtype(4) = 1;     eqtype_ = eqtype;

  param(1) = cellstr('sigma');
  param(2) = cellstr('delta');
  param(3) = cellstr('lambda');
  param(4) = cellstr('rho');
  param(5) = cellstr('gampi');
  param_ = char(param);

  endog(1) = cellstr('y');
  endog(2) = cellstr('inf');
  endog(3) = cellstr('dr');
  endog(4) = cellstr('rs');
  endog_ = char(endog);

  delay(1) = 0;     delay(2) = 0;     delay(3) = 0;   
  delay(4) = 0;     delay_ = delay;

  vtype(1) = 1;     vtype(2) = 1;     vtype(3) = 1;   
  vtype(4) = 1;     vtype_ = vtype;




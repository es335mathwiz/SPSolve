function SPTabulate(T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15, ...
T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,T26,T27,T28,T29,T30,T31,T32,T33,...
T34,T35,T36,T37,T38,T39,T40,T41,T42,T43,T44,T45,T46,T47,T48,T49,T50)

%  SPTabulate(t1,t2,...)  
%
%  Display a tabular matrix of the input arguments.

if(nargin>50)
  error('No more than 50 input arguments');
  return;
end

table = SPTab(T1);

for k = 2:nargin

   next = eval(['SPTab(T',int2str(k),')']);
   [rnext, cnext]  = size(next);
   [rtable,ctable] = size(table);
   
   if(rnext>rtable)
      table = [table
               setstr(ones(rnext-rtable,ctable)*' ')];
   elseif(rtable>rnext)
      next = [next
              setstr(ones(rtable-rnext,cnext)*' ')];
   end

   [rtable,ctable] = size(table);
   table = [table, setstr(ones(rtable,2)*' '), next];

end

[rtable,ctable] = size(table);
table = [setstr(ones(1,ctable)*'_')
          setstr(ones(1,ctable)*' ')
          table,
          setstr(ones(1,ctable)*'_')];

disp(table)

return


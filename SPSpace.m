function SPSpace(n)

%  SPSpace(n)
%
%  Display n blank lines.

if(nargin==0)

   disp(' ')
   return

elseif(n>0)

   disp(setstr(ones(n,1)*' '));
   return

else
return
end

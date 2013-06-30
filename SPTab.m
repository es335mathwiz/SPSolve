function t = SPTab(x)

% t = tab(x)
%
% Convert the argument to a string matrix for the tabulator command.

% It's null:

if(isempty(x))
   t = '[]';

% It's a string:

elseif(isstr(x))
   t = x;

% It's complex:

elseif(any(any(imag(x))))

   [nr,nc] = size(x);
   t = [];

   for col = 1:nc

      t0 = setstr(ones(nr,1)*' ');   % Sign of real part
      c1 = 6;
      t1 = setstr(ones(nr,c1)*' ');  % Absolute value of real part
      t2 = setstr(ones(nr,3)*' ');   % Sign of imaginary paart
      c3 = 7;
      t3 = setstr(ones(nr,c3)*' ');  % Absolute value of imaginary part

      for row = 1:nr

         if(real(x(row,col)) < 0)
            line0 = '-';
         else
            line0 = ' ';
         end

         line1 = num2str(abs(real(x(row,col))));

         if(imag(x(row,col)) < 0)
            line2 = ' - ';
         else                
            line2 = ' + '; 
         end

         line3 = [num2str(abs(imag(x(row,col)))),'i'];

         l1 = length(line1);
         l3 = length(line3);
         if(l1>c1)
            t1 = [t1,setstr(ones(nr,l1-c1)*' ')];
            c1 = l1;
         end
         if(l3>c3)
            t3 = [t3,setstr(ones(nr,l3-c3)*' ')];
            c3 = l3;
         end

         t0(row,:)    = line0;
         t1(row,1:l1) = line1;
         t2(row,:)    = line2;
         t3(row,1:l3) = line3;

      end

      t = [t,setstr(ones(nr,3)*' '),t0,t1,t2,t3];

   end

% It's real:

elseif(any(any( x- fix(x) )))

   [nr,nc] = size(x);
   t = [];

   for col = 1:nc

      t0 = setstr(ones(nr,1)*' ');   % Sign
      c1 = 6;
      t1 = setstr(ones(nr,c1)*' ');  % Absolute value

      for row = 1:nr

         if(x(row,col) < 0)
            line0 = '-';
         else
            line0 = ' ';
         end

         line1 = num2str(abs(x(row,col)));

         l1 = length(line1);
         if(l1>c1)
            t1 = [t1,setstr(ones(nr,l1-c1)*' ')];
            c1 = l1;
         end

         t0(row,:)    = line0;
         t1(row,1:l1) = line1;

      end

      t = [t,setstr(ones(nr,3)*' '),t0,t1];

   end

% It's integer:

else

   [nr,nc] = size(x);
   t = [];

   for col = 1:nc

      t0 = setstr(ones(nr,1)*' ');  % Sign
      c1 = 1;
      t1 = setstr(ones(nr,c1)*' '); % Value

      for row = 1:nr

         if(x(row,col) < 0)
            line0 = '-';
         else
            line0 = ' ';
         end

         line1 = int2str(abs(x(row,col)));

         l1 = length(line1);
         if(l1>c1)
            t1 = [t1,setstr(ones(nr,l1-c1)*' ')];
            c1 = l1;
         end

         t0(row,:)    = line0;
         t1(row,1:l1) = line1;

      end

      t = [t,setstr(ones(nr,3)*' '),t0, t1];

   end

end

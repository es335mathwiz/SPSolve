% example7_aim_matrices()
%     This script will compute the G and H matrices.

  g = zeros(4, 8);
  h = zeros(4, 12);

  g(17) = g(17) + 1;
  g(29) = g(29) - (-1.0*((1.0*(sigma^-1.0))*1));
  h(33) = h(33) - 1;
  h(37) = h(37) - (-1.0*((1.0*(sigma^-1.0))*(-1.0*1)));
  g(22) = g(22) + 1;
  g(18) = g(18) - (lambda*1);
  h(38) = h(38) - (delta*1);
  g(27) = g(27) + 1;
  g(31) = g(31) - 1;
  g(15) = g(15) - (-1.0*1);
  g(32) = g(32) + 1;
  g(16) = g(16) - (rho*1);
  g(24) = g(24) - (gampi*1);

  cofg = g;
  cofh = h;

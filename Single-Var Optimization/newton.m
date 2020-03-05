function [xopt, fxopt, N] = newton(a, fx, ddx, d2dx)
%newton Solves for extrema of a given function
%   Uses the Newton Raphson method to deterime function extrema
xopt_temp(1) = a;
fxopt_temp(1) = fx(a);
N = 4;
i=2;
xi1 = a - ddx(a)/d2dx(a);
xopt_temp(i) = xi1;
fxopt_temp(i) = fx(xi1);
a = xi1;
while(abs((xopt_temp(i-1) - xopt_temp(i)))*100>=0.001*abs(xopt_temp(i-1)))
    N=N+3;
    i=i+1;
    xi1 = a - ddx(a)/d2dx(a);
    xopt_temp(i) = xi1;
    fxopt_temp(i) = fx(xi1);
    a = xi1;
end
xopt = xopt_temp(i);
fxopt = fxopt_temp(i);
end

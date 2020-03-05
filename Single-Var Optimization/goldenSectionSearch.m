function [ x_opt, fx_opt, N ] = goldenSectionSearch( fcn, x_int, max )
%goldenSectionSearch Search for extrema within an interval
%   Uses the Golden Section search to find an extrema of a function inside
%   of a given interval
    xL = x_int(1);
    xU = x_int(2);
    d = (((1+sqrt(5))/2) - 1) * (xU - xL);
    x1 = xL + d;
    x2 = xU - d;
    tmp = Inf;
    f1 = f(x1);
    f2 = f(x2);
    N = 2;
    while true
        if max
            if (f1 > f2)
                xL = x2;
                x2 = x1;
                f2 = f1;
                x_opt = x1;
                fx_opt = f1;
                if ((abs(x_opt - tmp)*100) < 0.001 * abs(x_opt))...
                        && x_opt~=tmp
                    break;
                else
                    d = (((1+sqrt(5))/2) - 1) * (xU - xL);
                    x1 = xL + d;
                    f1 = fcn(x1);
                    tmp = x_opt;
                    N = N+1;
                end
            else
                xU = x1;
                x1 = x2;
                f1 = f2;
                x_opt = x2;
                fx_opt = f2;
                if ((abs(x_opt - tmp) * 100) < 0.001 * abs(x_opt))...
                        && x_opt~=tmp
                    break;
                else
                    d = (((1+sqrt(5))/2) - 1) * (xU - xL);
                    x2 = xU - d;
                    f2 = fcn(x2);
                    N = N+1;
                    tmp = x_opt;
                end
            end
        else
            if (f1 < f2)
                xL = x2;
                x2 = x1;
                f2 = f1;
                x_opt = x1;
                fx_opt = f1;
                if ((abs(x_opt - tmp)* 100) < 0.001 * abs(x_opt))...
                        && x_opt~=tmp
                    break;
                else
                    d = (((1+sqrt(5))/2) - 1) * (xU - xL);
                    x1 = xL + d;
                    f1 = fcn(x1);
                    N = N+1;
                    tmp = x_opt;
                end
            else
                xU = x1;
                x1 = x2;
                f1 = f2;
                x_opt = x2;
                fx_opt = f2;
                if ((abs(x_opt - tmp) * 100) < 0.001 * abs(x_opt))...
                        && x_opt~=tmp
                    break;
                else
                    d = (((1+sqrt(5))/2) - 1) * (xU - xL);
                    x2 = xU - d;
                    f2 = fcn(x2);
                    N = N+1;
                    tmp = x_opt;
                end
            end
        end
    end
end


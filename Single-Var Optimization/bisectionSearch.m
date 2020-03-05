function [ x_opt, N ] = bisectionSearch( fcn, xint )
%bisectionSearch Search for zeros of a given function
%   Uses the bisection search to find a zero of a function
    xL = xint(1, 1);
    xU = xint(1, 2);
    x_opt = (xL + xU)/2;
    tmp = Inf;
    fL = fcn(xL);
    fU = fcn(xU);
    fx_opt = fcn(x_opt);
    N = 3;
    k = true;
    
    while (fL*fU >= 0)
        if k
            xL = xL - 1;
            fL = fcn(xL);
            N = N + 1;
            k = ~k;
        else
            xU = xU + 1;
            fU = fcn(xU);
            N = N + 1;
            k = ~k;
        end
    end
    while (abs(x_opt - tmp)*100) >= (0.001 * abs(x_opt))
        if (fL * fx_opt) < 0
            xU = x_opt;
            tmp = x_opt;
            x_opt = (xU + xL)/2;
            fx_opt = fcn(x_opt);
            N = N+1;
        elseif (fL * fx_opt) > 0
            xL = x_opt;
            tmp = x_opt;
            x_opt = (xU + xL)/2;
            fx_opt = fcn(x_opt);
            N = N+1;
        else
            break;
        end
    end
end


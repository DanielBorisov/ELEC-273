function fout = ffcn( x, y )
    fout = x.*y.*exp(-(x.^2 + y.^2));
end
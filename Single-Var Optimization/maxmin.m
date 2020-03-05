function c = maxmin( a, b, ddx ) 
%% Solves for critical points to det if fcn begins w/ a max or a min
k = 1;
for i=a:0.01:b
    j=i+0.01;
    x0=[i j];
    if((ddx(i)< 0 && ddx(j) < 0)|| (ddx(i)> 0 && ddx(j) > 0))
    else
       z(k)=fzero(@ddx,x0);       
       k = k+1;
    end
end
c = d2dx(z); 
end
function newtonRaphson( Xinitial, Yinitial, f, delf, hess, l)

%relative change between points 
epsilon=0.000001;

k=1;

Xp=[Xinitial, Yinitial]';

outputvalues(1,1)=Xp(1,1);
outputvalues(1,2)=Xp(2,1);
outputvalues(1,3)=double(f(Xp(1,1),Xp(2,1)));
f_opt = outputvalues(1,3);

loopBool = true;

while (loopBool && k<1000)
    k=k+1;
        
    gradF=[double(delf{1}(Xp(1,1),Xp(2,1)));...
           double(delf{2}(Xp(1,1),Xp(2,1)))];
    H = [double(hess{1,1}(Xp(1,1),Xp(2,1))) double(hess{1,2}(Xp(1,1),Xp(2,1))); ...
    double(hess{2,1}(Xp(1,1),Xp(2,1))) double(hess{2,2}(Xp(1,1),Xp(2,1)))];

    Xn = Xp - l*(H\gradF);
    tmp = f_opt;
    f_opt = f(Xn(1),Xn(2));
    
    loopBool = (abs(f_opt - tmp) >= epsilon*abs(tmp));
    
    Xp = Xn;
    
    outputvalues(k,1)=Xn(1,1);
    outputvalues(k,2)=Xn(2,1);
    outputvalues(k,3)=f(Xn(1,1),Xn(2,1));
end

title=[' Xopt       Yopt         f(x,y)'];
disp(title);
disp(outputvalues);

end
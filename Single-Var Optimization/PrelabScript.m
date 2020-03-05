%% ELEC 273 LAB 4 PRELAB
% D. Borisov, K.Fisher
intvl = [-6 9];
indx = (intvl(1,1)-intvl(1,1))+1:1:(intvl(1,2)-intvl(1,1))+1;
df0 = fzero(@df, intvl(1,1));

lm = [];

if (d2f(df0(1)) < 0)
    lm = [lm ; [f(df0(1)) 1]];
elseif (d2f(df0(1)) > 0)
    lm = [lm; [f(df0(1)) -1]];
elseif ((d2f(df0(1)+0.01))*d2f(df0(1)-0.01)) > 0
    if (d2f(df0(1)+0.01) < 0)
        lm = [lm; [f(df0(1)) 1]];
    elseif (d2f(df0(1)+0.01) > 0)
        lm = [lm; [f(df0(1)) -1]];
    end
end
k = 1;


for i = indx
    tmp = fzero(@df, intvl(1,1)+i);
    if floor(df0(k)*100000) ~= floor(tmp*100000) && tmp <= intvl(1,2);
        df0 = [df0 tmp];
        k = k+1;
        
        if (d2f(df0(k)) < 0)
            lm = [lm; [f(df0(k)) 1]];
        elseif (d2f(df0(k)) > 0)
            lm = [lm; [f(df0(k)) -1]];
        elseif ((d2f(df0(k)+0.01))*d2f(df0(k)-0.01)) > 0
            if (d2f(df0(k)+0.01) < 0)
                lm = [lm; [f(df0(k)) 1]];
            elseif (d2f(df0(k)+0.01) > 0)
                lm = [lm; [f(df0(k)) -1]];
            end
        end
    end
end

[gmaxY, gmaxX] = max(lm(:,1)');
[gminY, gminX] = min(lm(:,1)');
gmaxX = df0(gmaxX);
gminX = df0(gminX);

if gmaxY < f(intvl(1,1))
    gmaxY = f(intvl(1,1));
    gmaxX = intvl(1,1);
elseif gmaxY < f(intvl(1,2))
    gmaxY = f(intvl(1,2));
    gmaxX = intvl(1,2);
end
if gminY > f(intvl(1,1))
    gminY = f(intvl(1,1));
    gminX = intvl(1,1);
elseif gminY > f(intvl(1,2))
    gminY = f(intvl(1,2));
    gminX = intvl(1,2);
end


x = -6:0.1:9;

figure(1)
hold on
grid on
plot(x, f(x), x, df(x), x, d2f(x));
plot (df0, f(df0), 'b*');
plot (gmaxX, gmaxY, 'bs');
plot (gminX, gminY, 'bs');
xlabel ('x');
ylabel ('y');
legend ('f(x)', 'f''(x)', 'f''''(x)');
title ('f(x) = 2sin(x) - x^2/30');

fprintf ( 'The local minima of f(x) are given as\n');
    lm(find(lm(:,2) == -1), 1)
fprintf ( 'at x values of \n');
    df0(find(lm(:,2) == -1))'
fprintf ( 'The local maxima of f(x) are given as \n');
    lm(find(lm(:,2) == 1), 1)
fprintf ( 'at x values of \n');
    df0(find(lm(:,2) == 1))'
fprintf ( 'The global maximum of f(x) is %f \n at x = %f \n', ...
    gmaxY, gmaxX);
fprintf ( 'The global minimum of f(x) is %f \n at x = %f \n', ...
    gminY, gminX);
fprintf ( strcat('This is represented graphically in Fig. 1 using\n',...
    'stars for local extrema and squares for global extrema\n'));















%% Lab 5 Prelab
% K Fisher, D Borisov

fcn = @(x) x(1).*x(2).*exp(-(x(1).^2 + x(2).^2));
[xmin1, fmin1] = fminsearch (fcn, [1,-1]);
[xmin2, fmin2] = fminsearch (fcn, [-1,1]);
fcn = @(x) -fcn(x);
[xmax1, fmax1] = fminsearch (fcn, [1,1]);
[xmax2, fmax2] = fminsearch (fcn, [-1,-1]);
fmax1 = -fmax1;
fmax2 = -fmax2;

[X, Y] = meshgrid (-4:0.1:4, -4:0.1:4);
fxy = f(X, Y);
figure (1);
hold on
surf (X, Y, fxy);
plot3 (xmin1(1), xmin1(2), fmin1, 'm^', ...
    xmin2(1), xmin2(2), fmin2, 'm^')
plot3 (xmax1(1), xmax1(2), fmax1, 'mv', ...
    xmax2(1), xmax2(2), fmax2, 'mv');
hold off
grid on
view (3);

figure (2);
hold on
contour (X, Y, fxy, 40);
plot (xmin1(1), xmin1(2), 'b*', ...
    xmin2(1), xmin2(2), 'b*');
plot (xmax1(1), xmax1(2), 'r*', ...
    xmax2(1), xmax2(2), 'r*');
hold off
grid on

fprintf('Local Extrema:\n\n')
fprintf('    x_opt\ty_opt\t f_opt\n')
disp([xmin1(1) xmin1(2) fmin1;...
      xmin2(1) xmin2(2) fmin2;...
      xmax1(1) xmax1(2) fmax1;...
      xmax2(1) xmax2(2) fmax2]);
fprintf('These extrema are represented by the arrows on the surface ');
fprintf('plot and the stars on the level curves plot');
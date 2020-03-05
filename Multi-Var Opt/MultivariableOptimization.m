%% MultiVariable Optimization - D Borisov, K Fisher
% Uses Newton-Raphson and Gradient Descent to optimize function f(x,y)
close all
clear all
clc

f = @(x,y) (x.*y.*exp(-(x.^2 + y.^2)));
fx = @(x,y) y.*(-2*(x.^2)*exp(-1*((x.^2) + (y.^2))) + exp(-1.*((x.^2) +...
              (y.^2))));
fy = @(x,y) x.*(-2*(y.^2)*exp(-1*((x.^2) + (y.^2))) + exp(-1*((x.^2) +...
              (y.^2))));
delf = {fx;fy};
fxy = @(x,y) (-2*(x.^2)*exp(-1*((x.^2) + (y.^2))) + exp(-1.*((x.^2) +...
              (y.^2))) + (4*(x.^2)*(y.^2)*exp(-((x.^2) + (y.^2))) - ...
              2*(y.^2)*exp(-((x.^2) + (y.^2)))));
fxx = @(x,y) y*(-6*x*exp(-(x.^2 + y.^2)) + (4*(x.^3)*exp(-((x.^2) + ...
              (y.^2)))));
fyy = @(x,y) x*(-6*y*exp(-(x.^2 + y.^2)) + (4*(y.^3)*exp(-((x.^2) + ...
              (y.^2)))));
          
hessian = {fxx, fxy; fxy, fyy};

%%  Question 1-Newton-Raphson method

fprintf('Newton-Raphson Optimization, Step Size of 1\n\n');

step = 1;

newtonRaphson(-0.9,-0.9, f, delf, hessian, step);
newtonRaphson(0.9,-0.9, f, delf, hessian, step);
newtonRaphson(-0.9,0.9, f, delf, hessian, step);
newtonRaphson(0.9,0.9, f, delf, hessian, step);

%% Q2

xy0 = [0 1; 0 -1];

fprintf('Gradient descent with variable step size parameter\n');
fprintf('  optimizing g(lambda) to determine best step size\n');
fprintf('  using 1-D golden section optimization\n\n');
for i = 1:2
    [zmin, fmin, zmax, fmax, N] = gradientDescent(f, xy0(i,:), delf,...
        'both');
    result = [zmin fmin N(1) zmax fmax N(2)];
    fprintf ('\n\tMax/Min Determined from initial point (%0.2f,%0.2f):\n',...
        xy0(i,1), xy0(i,2));
    fprintf('\t\txmin\t  ymin\t\t fmin\t  Nmin\t\txmax\t   ymax\t\t');
    fprintf('fmax\t\tNmax\n\t')
    disp(result)
end

fprintf('\nSetting constant step size parameter lambda = 1.5\n\n');
for i = 1:2
    [zmin, fmin, zmax, fmax, N] = gradientDescent(f, xy0(i,:), delf,...
        'both', 'stepSizeParameter', 1.5);
    result = [zmin fmin N(1) zmax fmax N(2)];
    fprintf ('\n\tMax/Min Determined from initial point (%0.2f,%0.2f):\n',...
        xy0(i,1), xy0(i,2));
    fprintf('\t\txmin\t  ymin\t\t fmin\t  Nmin\t\txmax\t   ymax\t\t');
    fprintf('fmax\t\tNmax\n\t')
    disp(result)
end


%% Q3

fprintf('\nPlotting number of iterations, N, required to converge on a');
fprintf(' min\nvs lambda over the interval [0.02,2.7], step size of 0.01');
h = 0.02:0.01:2.7;
[~, hsize] = size(h);
numIt = zeros(2, hsize);
for i = 1:hsize
    [~, ~, ~, ~, numIt(:,i)] = gradientDescent(f, xy0(1,:), delf,...
        'min', 'stepSizeParameter', h(i), 'suppressOutputs', true);
end

figure(1);
grid on;
plot (h, numIt(1,:));
title('Step Size Parameter, \lambda, vs Number of Iterations, N');
xlabel ('Step Size Parameter, \lambda');
ylabel ('Number of Iterations, N');

%% Q5+6

fprintf('\n\n\nGradient descent with central difference gradient formulation\n');
fprintf('  Setting step size parameter lambda = 0.1, central difference step value h = 0.01\n');
f = @(x,y) (((x.^5) - (y.^3) - (2*(x.^2).*(y.^2))).*exp(-1*((x.^2)...
    + (y.^2))));
fprintf('  Optimizing function f(x,y) = (x^5 - y^3 - 2(x^2)(y^2))exp(');
fprintf('-(x^2 + y^2))\n');
xy0 = [-0.5 -1; 1.5 1];
for i = 1:2
    [zmin, fmin, ~, ~, N] = gradientDescent(f, xy0(i,:),{;},...
        'min', 'stepSizeParameter', 0.5, 'gradientFind', 0.01);
    result = [zmin fmin N(1)];
    fprintf ('\n\tMin Determined from initial point (%0.2f,%0.2f):\n',...
        xy0(i,1), xy0(i,2));
    fprintf('\t\txmin\t  ymin\t\t fmin\t  Nmin\n\t');
    disp(result)
end



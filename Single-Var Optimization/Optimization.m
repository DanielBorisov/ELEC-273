%% Lab 4 - Optimization.m Matlab Script
% D Borisov, K Fisher

%% %Q1 - Golden Section
x = [-6 -3; -3 0; 0 3; 3 6; 6 9];
k = true;
[intervals, ~] = size(x);
result = zeros(intervals, 3);

for i = 1:intervals
    [xo, fx, n] = goldenSectionSearch (@f, x(i,:), k);
    result(i,:) = [xo fx n];
    k = ~k;
end

fprintf('Golden Section Search:\n\n')
fprintf('\tx_opt\t  fx_opt\t N\n')
disp(result)

%% %Q2 - Bisection

x = [-6 -3; -3 0; 0 3; 3 6; 6 9];
[intervals, ~] = size(x);
result = zeros(intervals, 3);

for i = 1:intervals
    [xo, n] = bisectionSearch (@df, x(i,:));
    fx = f(xo);
    n = n+1;
    result(i,:) = [xo fx n];
end

fprintf('Bisection Search:\n\n')
fprintf('\tx_opt\t  fx_opt\t N\n')
disp(result)

%% %Question 3: Newton Raphson Method
test = [-5.5, -2.5, 0.5, 4, 7];
for q = 1:1:5
    [x, y, n] = newton(test(q), @f, @df, @d2f);
    result(q,:) = [x y n];
end
fprintf('Newton Raphson method:\n\n')
fprintf('\tx_opt\t  fx_opt\t N\n')
disp(result)

%% %Question 5: fminsearch Method
test = [-5.5 -2.5 0.5 4 7];
k = 1;
options = optimset ('TolX', 1e-3);
for q = 1:1:5
    func = @(x) k*f(x);
    [x, y, ~, n] = fminsearch(func, test(q), options);
    result(q,:) = [x k*y n.funcCount];
    k=-k;
end
fprintf('MATLAB fminsearch Function:\n\n')
fprintf('\tx_opt\t  fx_opt\t N\n')
disp(result)
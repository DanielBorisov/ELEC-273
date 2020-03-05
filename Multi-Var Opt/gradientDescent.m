function [ xymin, fmin, xymax, fmax, N, flag ] = gradientDescent(fcn,...
    xy0, delf, maxmin, varargin)
%gradientDescent Determine a max, min, or both of a multivariable function
%   Uses gradient descent method to determine the optima of a function
    stepSet = false;
    gradFind = false;
    suppress = false;
    itMax = 5000;
    tolF = 0.0001;
    flag = 1;
    if nargin > 4
        for i = 1:2:nargin - 4
            switch varargin{i}
                case 'stepSizeParameter'
                    stepSet = true;
                    stpParameter = varargin{i+1};
                case 'gradientFind'
                    gradFind = true;
                    h = varargin{i+1};
                case 'iterationMax'
                    itMax = varargin{i+1};
                case 'TolF'
                    tolF = varargin{i+1};
                case 'suppressOutputs'
                    suppress = varargin{i+1};
                otherwise
                    fprintf('Unrecognized input command: ');
                    disp(varargin{i});
            end
        end
    end
    
    switch maxmin
        case 'both'
            maxTest = true;
            minTest = true;
        case 'max'
            maxTest = true;
            minTest = false;
            fmin = NaN;
            xymin = [NaN NaN];
        case 'min'
            maxTest = false;
            minTest = true;
            fmax = NaN;
            xymax = [NaN NaN];
        otherwise
            maxTest = false;
            minTest = false;
            fmin = NaN;
            xymin = [NaN NaN];
            fmax = NaN;
            xymax = [NaN NaN];
            flag = 0;
            fprintf('Valid inputs for arg 4: ''both'',''max'',''min''\n');
    end
    xymin = xy0;
    xymax = xy0;
    conditionTest = maxTest || minTest;
    NMax = 0;
    NMin = 0;
    while conditionTest
        if gradFind
            delfx = @(x,y) ((fcn(x+h,y) - fcn(x-h,y))/(2*h));
            delfy = @(x,y) ((fcn(x,y+h) - fcn(x,y-h))/(2*h));
        else
            delfx = delf{1};
            delfy = delf{2};
        end
        
        x = @(lda,tmp) tmp(1) + lda.*delfx(tmp(1),tmp(2));
        y = @(lda,tmp) tmp(2) + lda.*delfy(tmp(1),tmp(2));
        if minTest
            if stepSet
                fmin = fcn(x(stpParameter, xymin), y(stpParameter,xymin));
                minTest = (abs(fmin - fcn(xymin(1),xymin(2)))*100 > ...
                    tolF*abs(fcn(xymin(1),xymin(2))));
                xymin = [x(-1*stpParameter, xymin) y(-1*stpParameter, ...
                    xymin)];
            else
                gmin = @(lda) fcn(x(-1*lda, xymin), y(-1*lda, xymin));
                [lmin, fmin, ~] = goldenSectionSearch(gmin, [0 10 ],...
                    false);
                minTest = (abs(fmin - fcn(xymin(1),xymin(2)))*100 > ...
                    tolF*abs(fcn(xymin(1),xymin(2))));
                xymin = [x(-1 * lmin, xymin) y(-1 * lmin, xymin)];
            end
            NMin = NMin + 1;
            
            if ~suppress
                fprintf ('Min Search:\n');
                fprintf ('\tIteration: %d\n', NMin);
                fprintf ('\tCurrent X,Y Estimate: (%0.4f,%0.4f)\n', xymin(1),...
                    xymin(2));
                fprintf ('\tCurrent max F Estimate: %0.4f\n', fmin);
            end
        end
        if maxTest
            if stepSet
                fmax = fcn(x(stpParameter, xymax), y(stpParameter,xymax));
                maxTest = (abs(fmax-fcn(xymax(1),xymax(2)))*100 >= ...
                    tolF*abs(fcn(xymax(1),xymax(2))));
                xymax = [x(stpParameter, xymax) y(stpParameter, xymax)];
            else
                gmax = @(lda) fcn(x(lda, xymax), y(lda, xymax));
                [lmax, fmax, ~] = goldenSectionSearch(gmax, [0 10],...
                    true);
                maxTest = (abs(fmax-fcn(xymax(1),xymax(2)))*100 >= ...
                    tolF*abs(fcn(xymax(1),xymax(2))));
                xymax = [x(lmax, xymax) y(lmax, xymax)];
            end
            NMax = NMax + 1;
            
            if ~suppress
                fprintf ('Max Search:\n');
                fprintf ('\tIteration: %d\n', NMax);
                fprintf ('\tCurrent X,Y Estimate: (%0.4f,%0.4f)\n', xymax(1),...
                    xymax(2));
                fprintf ('\tCurrent max F Estimate: %0.4f\n', fmax);
            end
        end
        
        NLim = max(NMin, NMax) > itMax;
        
        if NLim
            if NMin > itMax
                fprintf('Minimization failed to converge within ');
                fprintf('%d iterations\n', itMax);
                flag = -1;
            end
            if NMax > itMax
                fprintf('Maximization failed to converge within ');
                fprintf('%d iterations\n', itMax);
                flag = -1;
            end
        end
        
        conditionTest = (maxTest || minTest) && ~NLim;
    end
    N = [NMin NMax];
end

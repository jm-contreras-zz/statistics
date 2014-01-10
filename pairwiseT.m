function [Tp, Tt, Cd, Df] = pairwiseT(x, type, conds)

% [Tp, Tt, Cd, Df] = PAIRWISE(X, TYPE, CONDS) performs every possible
% pairwise t-test between the variables in X, an AxB matrix where A = number
% of subjects and B = number of conditions in a within-subjects design
% (TYPE = 'paired'). CONDS specifies the conditions to which subjects belong
% in between-subjects design (TYPE = 'independent').
%
% Outputs matrices with p-values (Tp), t-statistics (Tt), Cohen's Ds (Cd),
% and degrees of freedom (Df).
%
% Depends on wscohensd.m (Juan Manuel Contreras), which computes a within-
% subjects Cohen's D.
%
% Written by Juan Manuel Contreras (juan.manuel.contreras.87@gmail.com) on
% September 8, 2012.

if strcmp(type, 'paired')
    
    nConds = size(x, 2);
    Tp = nan(nConds - 1);
    Tt = Tp;
    Cd = Tp;
    Df = Tp;
    for i = 1:(nConds - 1)
        for j = (i + 1):nConds
            [~, P, ~, T] = ttest(x(:, i), x(:, j));
            Tp(i, j - 1) = P;
            Tt(i, j - 1) = T.tstat;
            Cd(i, j - 1) = wscohensd(x(:, i), x(:, j));
            Df(i, j - 1) = T.df;
        end
    end
    
elseif strcmp(type, 'independent')
    
    nConds = max(conds);
    Tp = nan(nConds - 1);
    Tt = Tp;
    Cd = Tp;
    Df = Tp;
    for i = 1:(nConds - 1)
        for j = (i + 1):nConds
            [~, P, ~, T] = ttest2(x(conds == i), x(conds == j));
            Tp(i, j - 1) = P;
            Tt(i, j - 1) = T.tstat;
            Cd(i, j - 1) = 2 * T.tstat / sqrt(T.df);
            Df(i, j - 1) = T.df;
        end
    end
    
end

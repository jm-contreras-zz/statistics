function a = anova_rm_multi(x, nFactors)

% A = RM_ANOVA(x, NFACTORS) computes a repeated measures ANOVA on X, an AxB
% matrix in which A = number of participants and B = number of levels by
% number of factors (NFACTORS). Returns a table with sums of squares,
% degrees of freedom, mean squares, F-statistics, and p-values.
%  
% Depends on anova_rm.m (Arash Salarian) and rm_anova2 (Aaron Schurger),
% which compute repeated measures ANOVAs for data with 1- and 2-factors,
% respectively.
%
% Written by Juan Manuel Contreras (juan.manuel.contreras.87@gmail.com) on
% December 10, 2011.

if nFactors == 1

    [~, a] = anova_rm(x, 'off');
    
elseif nFactors == 2

    %Create repeated-measures matrix (vector with 1 cell per beta value)
    a = size(x, 1); %Sample size
    b = size(x, 2); %Product of levels and factors
    y = nan(a * b, 1);
    k = 1;
    for i = 1:b
        for j = 1:a
            y(k) = x(j, i);
            k = k + 1;
        end
    end

    %Create subject matrix (vector with 1 cell per beta value)
    s = [];
    for i = 1:b
        s = [s;[1:a]']; %#ok<NBRAK,AGROW>
    end

    %Create factor matrices (vectors with 1 cell per beta value)
    sizeY = size(y, 1);
    f1 = [ones(sizeY / 2, 1); ones(sizeY / 2, 1) * 2];
    f2 = [ones(sizeY / 4, 1); ones(sizeY / 4, 1) * 2];
    f2 = [f2; f2]; %This is not a typo

    % Name factors
    f = {'f1' 'f2'};

    % Execute repeated measures ANOVA
    a = rm_anova2(y, s, f1, f2, f);
    
else
    
    error('anova_rm_multi can only analyze data with 1 or 2 factors.')

end
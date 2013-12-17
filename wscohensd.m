function d = wscohensd(x, y)

% D = WSCOHENSD(X, Y) calculates within-subjects Cohen's d with the formula
% d = t/sqrt(df).
%
% Written by Juan Manuel Contreras (juan.manuel.contreras.87@gmail.com) on
% May 11, 2012.

[~, ~, ~, stats] = ttest(x, y);
d = stats.tstat / sqrt(stats.df);
function y = sem(x)

% Y = SEM(X) computes the standard error of the mean.
%
% Written by Juan Manuel Conteras (juan.manuel.contreras.87@gmail.com) on
% September 8, 2012.

y = std(x) / sqrt(length(x));
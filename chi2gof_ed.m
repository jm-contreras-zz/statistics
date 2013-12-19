function [h, p, stats] = chi2gof_ed(x)

% [H, P, STATS] = CHI2GOF(X) generates an expected distribution of the
% variables in vector X and performs a chi-square goodness-of-fit test
% against this distribution.
%
% Written by Juan Manuel Conteras (juan.manuel.contreras.87@gmail.com) on
% September 8, 2012.

% Calculate frequencies
freq = tabulate(x);

% Compute the average frequency
counts = mean(freq(:, 2));

% Compute the sample size
nObservations = size(freq, 1);

% Generate the expected distribution
expected = repmat(counts, 1:nObservations);

% Compute the chi-squared goodness-of-fit test
[h, p, stats] = chi2gof(x, 'expected', expected);

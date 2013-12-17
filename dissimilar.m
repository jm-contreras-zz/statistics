function y = dissimilar(x)

% Y = DISSIMILAR(X)
% Computes a dissimilarity matrix from a row- or column-vector.
%
% Written by Juan Manuel Contreras (juan.manuel.contreras.87@gmail.com) on
% November 2, 2011.

% Initialize an empty matrix
n = length(x);
y = nan(n);

% Compute dissimilarity
for i = 1:n
    for j = 1:n
        y(i, j) = abs(x(i) - x(j));
    end
end
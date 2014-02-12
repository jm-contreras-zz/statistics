function [f p] = ws_lin_con(x, con)

% [F P] = WS_LIN_CON(X, CON) computes a within-subjects linear contrast with
% (1) an AxB data matrix X in which A = number of participants and B =
% number of conditions, and (2) a row vector CON that specifies the contrast
% weights. Uses the conditionXsubject error term from a one-way repeated
% measures ANOVA on conditions with contrast weights > 0.
%
% Keppel, G. & Wickens, T. D. (2004). Design and analysis: A researcher's
% handbook (4th ed.). Upper Saddle River, NJ; Prentice Hall.
% 
% Depends on anova_rm.m (Arash Salarian) and rm_anova2 (Aaron Schurger),
% which compute repeated measures ANOVAs for data with 1- and 2-factors,
% respectively, and their wrapper anova_rm_multi.m (Juan Manuel Contreras).
%
% Written by Juan Manuel Contreras (juan.manuel.contreras.87@gmail.com) on
% December 12, 2011.

% Restrict analysis to conditions specified by the contrast
con_ind = con ~= 0;
x = x(:, con_ind);

% Calculate sums of squares
n   = size(x,1);
psi = sum(mean(x) .* con(con_ind));
ss  = (n * psi ^ 2) / sum(con(con_ind) .^ 2);

% Perform one-way repeated measures ANOVA and extract its error term
a = anova_rm_multi(x, 1);
e = a{4, 4};

% Compute F- and p-values
f = ss / e;
p = 1 - fcdf(f, 1, a{4, 3});

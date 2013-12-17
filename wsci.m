function ci = wsci(data, nFactors, nTails)

% CI = WSCI(DATA, NFACTORS, NTAILS) computes a within-subjects confidence
% interval (CI) on the basis of the interaction mean square error, sample
% size, and the critical value from a t-distribution. Requires an AxB data
% matrix (DATA), where A = sample size and B = product of number of factors
% (NFACTORS) and levels. A two-tailed test is not assumed.
%
% Masson, M. E. J., & Loftus, G. R. (2003). Using confidence intervals for
% graphically based data interpretation. Canadian Journal of Experimental
% Psychology, 57(3), 203-220.
%
% Depends on anova_rm.m (Arash Salarian) and rm_anova2 (Aaron Schurger),
% which compute repeated measures ANOVAs for data with 1- and 2-factors,
% respectively, and their wrapper anova_rm_multi.m (Juan Manuel Contreras).
%
% Written by Juan Manuel Contreras (juan.manuel.contreras.87@gmail.com)
% on December 10, 2011.

% Ensure that inputs are of the appropriate type
checkinputs(data, nFactors, nTails)

% Determine if value are missing
missesValues = sum(sum(isnan(data))) > 0;

% If values are missing, then remove their rows
if missesValues
    for col = 1:size(data, 2)
        theseData = data(:, col);
        missValues = isnan(theseData);
        data(missValues, :) = [];
    end
end

% Declare the p-value and the sample size
p = .05;
n = size(data, 1);

% Compute repeated-measures ANOVA
a = rm_anova(data, nFactors);

% Extract degrees of freedom
if nFactors == 1
    df = a{4,3}; %Df
    er = a{4,4}; %Interaction df
elseif nFactors == 2
    df(1) = a{5,3};
    df(2) = a{6,3};
    er(1) = a{5,4};
    er(2) = a{6,4};
end

% Compute confidence intervals for every factor
ci = nan(1, nFactors);
for iFactor = 1:nFactors
    t  = abs(tinv(p / nTails, df(iFactor))); %Critical-t
    ci(iFactor) = sqrt(er(iFactor) / n) * t; %Masson & Loftus (2003), p. 207
end

end

% HELPER FUNCTION to ensure that inputs are of the appropriate type
function checkinputs(data, nFactors, nTails)
if ~isnumeric(data)
    error('data must be numeric.')
elseif nFactors ~= 1 && nFactors ~= 2
    error('nFactors must be 1 or 2.')
elseif nTails ~= 1 && nTails ~= 2
    error('nTails must be 1 or 2.')
end
end
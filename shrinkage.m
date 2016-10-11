function [Y] = shrinkage(X, t, p, pos)
% [Y] = shrinkage(X, t, p, pos)
% Element-wise shrinkage operator on arrays.
% INPUTS
%       X      an array of any dimensionality
%       t      the amount of shrinkage
%       p      the norm parameter for generalized shrinkage (optional)
%       pos    if true, the result can only be non-negative (optional)
% OUTPUTS
%       Y      the result of shrinking X
%
% George Papamakarios
% Imperial College London
% Apr 2014

if nargin < 3 || p == 1
    
    Y = sign(X) .* max(abs(X) - t, 0);
    
else
    
    if nargin < 4
        pos = false;
    end
    if isscalar(t)
        t = t * ones(size(X));
    end
    Y = shrinkage_p(X, t, p, pos);
    
end

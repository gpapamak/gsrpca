function [Y, info] = gsrpca(X, options)
% [Y, info] = gsrpca(X, options)
% Performs Generalized Scalable Robust Principal Component Analysis on X.
% INPUTS
%       X           data matrix with data points as columns
%       options     a struct with options (optional)
% OUTPUTS
%       Y           a struct containing the result
%       info        information about execution
%
% Based on the paper:
% G. Papamakarios, Y. Panagakis, and S. Zafeiriou, "Generalised Scalable
% Robust Principal Component Analysis," In Proceedings of the British
% Machine Vision Conference, 2014.
%
% George Papamakarios
% Imperial College London
% Apr 2014

[n1, n2] = size(X);

% options
if nargin < 2
    options = struct;
end
if ~isfield(options, 'error_weights') 
    options.error_weights = 1;
end
if ~isfield(options, 'return_error') 
    options.return_error = true; 
end
if ~isfield(options, 'return_factors') 
    options.return_factors = false; 
end
if ~isfield(options, 'numComp') 
    options.numComp = min(n1, n2); 
end
if ~isfield(options, 'p') 
    options.p = 1; 
end
if ~isfield(options, 'q') 
    options.q = 1; 
end
if ~isfield(options, 'lambda') 
    options.lambda = 1 / sqrt(max(n1, n2)); 
end
if ~isfield(options, 'delta')  
    options.delta = 1.0e-7; 
end
if ~isfield(options, 'initMu')  
    options.initMu = 1.0e-3; 
end
if ~isfield(options, 'maxMu')  
    options.maxMu = 1.0e+9; 
end
if ~isfield(options, 'rho')  
    options.rho = 1.2; 
end
if ~isfield(options, 'initU')  
    [options.initU, ~, ~] = svds(X, options.numComp); 
end
if ~isfield(options, 'initE')  
    options.initE = zeros(n1, n2); 
end
if ~isfield(options, 'verbose')  
    options.verbose = false; 
end
if ~isfield(options, 'maxIter')  
    options.maxIter = inf; 
end
if ~isfield(options, 'signal_norm')
    options.signal_norm = 'schatten'; 
end
if ~isfield(options, 'error_norm') 
    options.error_norm = 'elementwise'; 
end

% define norms
switch options.signal_norm
    case 'schatten'
        signal_shrinkage = @sv_shrinkage;
    case 'elementwise'
        signal_shrinkage = @shrinkage;
    otherwise
        error('Unknown signal norm.');
end
switch options.error_norm
    case 'schatten'
        error_shrinkage = @sv_shrinkage;
    case 'elementwise'
        error_shrinkage = @shrinkage;
    otherwise
        error('Unknown error norm.');
end

% initialization
W = double(options.error_weights);
p = options.p;
q = options.q;
U = options.initU;
E = options.initE;
L = zeros(n1, n2);
l = options.lambda;
m = options.initMu;
m_max = options.maxMu;
r = options.rho;
err = inf;
iter = 0;
datanorm = norm(X, 'fro');
termCrit = options.delta * datanorm;
store_info = nargout >= 2;
info.iter = [];
info.err  = [];

% iterating
while err > termCrit && iter < options.maxIter

    % update V, E
    V = signal_shrinkage(U' * (X - E + L/m), 1/m, p);
    E = error_shrinkage(X - U*V + L/m, W*l/m, q);

    % update U
    [Us, ~, Vs] = svd((X - E + L/m) * V', 'econ');
    U = Us * Vs';

    % update L, m
    L = L + m * (X - U*V - E);
    m = min(r*m, m_max);

    % calculate error
    err = norm(X - U*V - E, 'fro');
    iter = iter + 1;

    % print info
    if options.verbose
        fprintf('Iteration %d, error = %g \n', iter, err/datanorm);
    end
    
    % store info
    if store_info
        info.iter = [info.iter iter];
        info.err  = [info.err  err/datanorm];
    end

end

if options.return_factors
    Y.U = U;
    Y.V = V;
else
    Y.A = U * V;
end
if options.return_error
    Y.E = E;
end

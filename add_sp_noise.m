function [X] = add_sp_noise(X, noise_perc)
% [X] = add_sp_noise(X, noise_perc)
% Adds salt & pepper noise to an array that contains images.
% INPUTS
%       X           the array to add noise to
%       noise_perc  percentage of the image to corrupt
% OUTPUTS
%       X           same as X but with noise added
%
% George Papamakarios
% Imperial College London
% May 2014

noise = sign(randn(size(X)));
noise = (noise + 1) / 2;
idx = rand(size(X)) > 1 - noise_perc;
X(idx) = noise(idx);

% gsrpca_demo.m
%
% This is a demo of the Generalized Scalable Robust Principal Component
% Analysis (GSRPCA) algorithm.
%
% This demo corrupts a set of face images with noise, and then denoises
% them using GSRPCA.
%
% The set of face images used here is part of the Extended Yale B database,
% which is freely available from:
% http://vision.ucsd.edu/~leekc/ExtYaleDatabase/ExtYaleB.html
%
% GSRPCA is described in the following paper:
% G. Papamakarios, Y. Panagakis, and S. Zafeiriou, "Generalised Scalable
% Robust Principal Component Analysis," In Proceedings of the British
% Machine Vision Conference, 2014. 
%
% George Papamakarios
% Imperial College London
% Aug 2014

clear;
close all;

% load images
data_path = 'data';
data_file = 'yaleb10.mat';
load(fullfile(data_path, data_file));

% corrupt images with noise
X = add_sp_noise(X, 0.3);

% reshape images into a data matrix
sizeX = size(X);
imsize = sizeX(1:2);
X = reshape(X, prod(imsize), []);
range = [min(X(:)), max(X(:))];

% set options for GSRPCA
options.verbose = true;
options.numComp = 30;
options.p = 1;
options.q = 1;
options.lambda = 10;

% run GSRPCA
tic;
Y = gsrpca(X, options);
time = toc;

% show corrupted images, with the computed low-rank and sparse components
% navigate with left and right arrows to see all the images
% press ESC to close
fprintf('Total time = %g min\n', time/60);
disp_imdata(cat(3, X, Y.A, Y.E), imsize, {'Original', 'Low-rank', 'Sparse'}, [1 3], range);

% make_shrinkage_p.m
% Links the object file for shrinkage_p with MEX.
%
% George Papamakarios
% Imperial College London
% Aug 2014

!make shrinkage_p.o
mex -cxx shrinkage_p.o

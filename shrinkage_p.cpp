/*
 * shrinkage_p.cpp
 * Generalized shrinkage on an array. Implemented in C for efficiency.
 *
 * George Papamakarios
 * Imperial College London
 * Aug 2014
 */

#include "mex.h"
#include "matrix.h"
#include <cmath>

double newton_root(double x, double a, double m, double p)
{
	double err;
	const double delta = 1.0e-7;
	const double step = 1.0;

	do 
	{
		const double sgnx = x >= 0.0 ? 1.0 : -1.0;
		const double gx  = x - a + m*p*pow(fabs(x), p-1) * sgnx;
		const double dgx = 1 - m*p*(1-p)*pow(fabs(x), p-2);
		const double x_new = x - step * gx/dgx;
    	err = fabs(x - x_new);
	    x = x_new;
	}
	while (err > delta);

	return x;
}

double min_pnorm_reg_sq(double a, double m, double p, bool pos)
{
	if (m == 0) return a;
    
    const double v = pow(m*p*(1-p), 1/(2-p));
	const double v1 = v + m*p*pow(fabs(v), p-1);
	double x = 0.0;

	if (a > v1 || (a < -v1 && !pos))
	{
		x = newton_root(a, a, m, p);
	    const double hx = 0.5*(x-a)*(x-a) + m*pow(fabs(x), p);
	    const double h0 = 0.5*a*a;
	    if (hx > h0) x = 0.0;
	}

	return x;
}

void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[])
{
	if (nrhs != 4 && nrhs != 3) mexErrMsgTxt("Wrong number of inputs.");
	if (nlhs != 1) mexErrMsgTxt("Wrong number of ouputs.");

	// get inputs
	const mwSize numdims = mxGetNumberOfDimensions(prhs[0]);
	const mwSize* dims = mxGetDimensions(prhs[0]);
	const int numel = mxGetNumberOfElements(prhs[0]);
	const double* X = mxGetPr(prhs[0]);
	const double* m = mxGetPr(prhs[1]);
	const double p = *mxGetPr(prhs[2]);
	const bool pos = nrhs == 4 ? mxIsLogicalScalarTrue(prhs[3]) : false;

	// create output
	plhs[0] = mxCreateNumericArray(numdims, dims, mxDOUBLE_CLASS, mxREAL);
	double* Y = mxGetPr(plhs[0]);

	// iterate over array
	for (int i = 0; i < numel; i++)
	{
    	Y[i] = min_pnorm_reg_sq(X[i], m[i], p, pos);
	}
}

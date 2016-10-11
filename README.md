# Generalized Scalable Robust Principal Component Analysis

Implementation and demo of the GSRPCA algorithm from the paper:

> G. Papamakarios, Y. Panagakis, and S. Zafeiriou. _Generalised Scalable Robust Principal Component Analysis_. Proceedings of the British Machine Vision Conference. 2014.
> [[pdf]](http://www.bmva.org/bmvc/2014/files/paper113.pdf) [[bibtex]](http://homepages.inf.ed.ac.uk/s1459647/bibtex/gsrpca.bib)

## How to get started

Simply run ```gsrpca_demo.m``` to see a demonstration of GSRPCA in action. 

GSRPCA itself is implemented in ```gsrpca.m```.

The remaining files are implementations of various shrinkage operators, and a couple of helper functions for the demo.

## How to install

In order to use GSRPCA with generalized norms, i.e. with parameters p and q other than 1, you need to compile C file ```shrinkage_p.cpp```. A makefile for this has been added for your convenience. Simply run ```make_shrinkage_p.m```.

**NOTE:**
You need to set variable ```MATINC``` in ```makefile``` to point to your MATLAB include folder. This is the folder where files ```mex.h``` and ```matrix.h``` are. These files are needed as headers for ```shrinkage_p.cpp``` and therefore the compiler needs to know where they are during compile time.

## Data files

The demo uses part of the Extended Yale B dataset of face images. The data is in the ```data``` folder. The full dataset is freely available [[here]](http://vision.ucsd.edu/~leekc/ExtYaleDatabase/ExtYaleB.html).


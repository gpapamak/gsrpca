+---------------------------------------------------+
|                                                   |
|      Generalized Scalable Robust Principal        |
|                Component Analysis                 |
|                                                   |
|               George Papamakarios                 |
|                  September 2014                   |
|                                                   |
+---------------------------------------------------+

****************  How to run  ***********************

Simply run 

    gsrpca_demo.m

to see a demonstration of GSRPCA in action. 

GSRPCA itself is implemented in

    gsrpca.m

The remaining files are implementations of various 
shrinkage operators, and a couple of helper functions
for the demo.


*************  Compile instructions  ****************

In order to use GSRPCA with generalized norms, i.e.
with parameters p and q other than 1, you need to
compile C file shrinkage_p.cpp. A makefile for this
has been added for your convenience. Simply run

    make_shrinkage_p.m

HOWEVER!!
You need to set variable MATINC in "makefile" to 
point to your MATLAB include folder. This is the 
folder where files "mex.h" and "matrix.h" are. These
files are needed as headers for "shrinkage_p.cpp" and
therefore the compiler needs to know where they are
during compile time.
                              
*****************************************************

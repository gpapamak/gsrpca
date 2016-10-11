# makefile
# Makefile for compiling shrinkage_p.cpp.
#
# George Papamakarios
# Imperial College London
# Aug 2014

# NOTE!!
# Change this variable to point to your matlab include folder, which should
# contain header files "mex.h" and "matrix.h". Otherwise "shrinkage_p.cpp"
# will not compile!
MATINC = /opt/matlab-R2015a/extern/include

CC = gcc
CFLAGS = -fPIC -O3

shrinkage_p.o: shrinkage_p.cpp
	$(CC) -c shrinkage_p.cpp -o shrinkage_p.o $(CFLAGS) -I$(MATINC)

clean:
	rm -f shrinkage_p.o

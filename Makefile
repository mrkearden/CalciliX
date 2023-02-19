
CFLAGS = -I /usr/include/spooles -DARCH="Linux" -DSPOOLES -DARPACK -DMATRIXSTORAGE -DNETWORKOUT -ldl -fPIC
FFLAGS = -Wall -O2

CC=gcc
FC=gfortran

.c.o :
	$(CC) $(CFLAGS) -c $<
.f.o :
	$(FC) $(FFLAGS) -c $<

include Makefile.inc

SCCXMAIN = ccx_2.20.c

OCCXF = $(SCCXF:.f=.o)
OCCXC = $(SCCXC:.c=.o)
OCCXMAIN = $(SCCXMAIN:.c=.o)

DIR=/home/titan/spooles

LIBS = \
       $(DIR)/spooles.a \
	/home/titan/arpack-ng-master/SRC/.libs/libarpack.so \
       -lpthread -lm -lc

ccx_2.20: $(OCCXMAIN) ccx_2.20.a  
	./date.pl; $(CC) $(CFLAGS) -c ccx_2.20.c $(LIBS); $(FC) -O2 -fPIC -o $@ $(OCCXMAIN) ccx_2.20.a $(LIBS)

ccx_2.20.a: $(OCCXF) $(OCCXC) $(LIBS)
	ar vr $@ $?


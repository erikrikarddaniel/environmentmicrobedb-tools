DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

all: environmentmicrobedb.fraggenescan.makefile

clean:
	@rm -f */*.out

environmentmicrobedb.fraggenescan.makefile: environmentmicrobedb.fraggenescan.makefile.00

# Tests the basic functionality. Since %.fgs.length_sum is dependent on %.fgs.faa, the latter is also tested.
environmentmicrobedb.fraggenescan.makefile.00:
	@cd $@.d; make -f environmentmicrobedb.fraggenescan.makefile -n $@.contigs.fgs.length_sum | grep -v "^make" > $@.out
	@cd $@.d; $(CHECK)

DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

all: environmentmicrobedb.fraggenescan.makefile

clean:
	@rm -f */*.out

environmentmicrobedb.fraggenescan.makefile: environmentmicrobedb.fraggenescan.makefile.00

environmentmicrobedb.fraggenescan.makefile.00:
	@cd $@.d; make -f environmentmicrobedb.fraggenescan.makefile -n $@.contigs.fgs.faa | grep -v "^make" > $@.out
	@cd $@.d; $(CHECK)

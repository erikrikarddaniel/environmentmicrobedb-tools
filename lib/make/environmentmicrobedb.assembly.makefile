# This makefile requires that the MAKEFILE_REPOSITORY macro is set to a 
# directory containing the environmentmicrobedb.ray-outputdir.makefile file.
#
# The ASSEMBLY_OUTPUT_DIR_MAKEFILE macro is defined in the specific assembler's
# makefile, e.g. environmentmicrobedb.ray.makefile and 
# environmentmicrobedb.velvet.makefile.

CREATE_SUBDIRECTORY_LINK = [ ! -e Makefile ] && ln -s $(MAKEFILE_REPOSITORY)/$(ASSEMBLY_OUTPUT_DIR_MAKEFILE) Makefile

%.assemstats: %.contigfilelist
	assemstats 100 `cat $<`	> $@
	rm $<

%.assemstats.tsv: %.fna
	echo "minlen	sum	n	trim_n	min	med	mean	max	n50	n50_len	n90	n90_len	filename" > $@
	for n in 100 1000 10000 100000; do \
	  echo "$$n	`assemstats $$n $< | grep -v 'sum'`" >> $@; \
	done

%.mapback: %.contigfilelist
	for f in `cat $<`; do ( cd `dirname $$f`; $(CREATE_SUBDIRECTORY_LINK); make mapback); done
	rm $<

%.mapback-flagstats: %.contigfilelist
	for f in `cat $<`; do \
	  ( cd `dirname $$f`; $(CREATE_SUBDIRECTORY_LINK); make mapback-flagstat; grep "mapped (" *.mapback.flagstat|sed 's/[()%]//g' >> ../$@); \
	done
	rm $<

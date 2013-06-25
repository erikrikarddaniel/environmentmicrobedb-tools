ASSEMBLY_OUTPUT_DIR_MAKEFILE = environmentmicrobedb.velvet-outputdir.makefile

all_velveths: $(subst .interleaved.fastq.gz,.velveth,$(wildcard *.interleaved.fastq.gz))

%.velveth: %.interleaved.fastq.gz
	echo "`date`: $(basename $@): Running step1: velveth" > $@
	outdir=$(basename $@).d; \
	velveth-mp $$outdir $(KMERE_OPTS) -fastq.gz -shortPaired $<
	echo "`date`: $(basename $@): Done" >> $@

%.velvetg: %.velveth
	echo "`date`: $(basename $@): Running step2: velvetg" > $@
	outdir=$(basename $@).d; \
	for d in $${outdir}_*; do \
	  echo "`date`: $(basename $@): Running velvetg in $$d" >> $@; \
	  velvetg-mp $$d -read_trkg yes -scaffolding no -exp_cov auto ; \
	done
	echo "`date`: $(basename $@): Done" >> $@

%.contigfilelist:
	ls $(basename $@)*.d_*/contigs.fa > $@

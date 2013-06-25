all_velveths: $(subst .interleaved.fastq.gz,.velveth,$(wildcard *.interleaved.fastq.gz))

%.velveth: %.interleaved.fastq.gz
	echo "`date`: $@: Running" > $@
	outdir=$(basename $@).d; mkdir $$outdir; \
	velveth-mp $$outdir $(KMERE_OPTS) -fastq.gz -shortPaired $<
	echo "`date`: $@: Done" >> $@

%.velvetg: %.velveth
	echo "`date`: $@: Running" > $@
	outdir=$(basename $@).d; \
	for d in $${outdir}_*; do \
	  echo "`date`: $(basename $@): Running velvetg in $$d" >> $@; \
	  velvetg-mp $$d -read_trkg yes -scaffolding no -exp_cov auto ; \
	done
	echo "`date`: $@: Done" >> $@

%.contigfilelist:
	ls $(basename $@)*.d_*/contigs.fa > $@

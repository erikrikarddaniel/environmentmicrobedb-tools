%.all_velvet.step1: %.interleaved.fastq.gz
	echo "`date`: $(basename $@): Running step1: velveth" > $@
	outdir=$(basename $@).d; \
	velveth-mp $$outdir $(KMERE_OPTS) -fastq.gz -shortPaired $<

%.all_velvet.step2: %.all_velvet.step1
	echo "`date`: $(basename $@): Running step2: velvetg" > $@
	outdir=$(basename $@).d; \
	for d in $${outdir}_*; do \
	  echo "`date`: $(basename $@): Running velvetg in $$d" >> $@; \
	  velvetg-mp $$d -read_trkg yes -scaffolding no -exp_cov auto ; \
	done

# General targets, called by rule in environmentmicrobedb.assembly.makefile
mapback: contigs.mapback.bam

mapback-flagstat: contigs.mapback.flagstat

contigs.mapback.bam: inputpairs contigs.erne 
	erne-map --threads 8 `cat $<` --reference $(word 2,$^) --bam --output $$SNIC_TMP/$@ > $$SNIC_TMP/$(basename $@).out 2> $$SNIC_TMP/$(basename $@).err && mv $$SNIC_TMP/$(basename $@)* .

%.flagstat: %.bam
	samtools flagstat $< > $@

inputpairs:
	s=`pwd`; \
	s=`basename $$s|awk -F. '{print $$1}'`; \
	for i in 1 2; do echo --query$$i ..\/..\/$$s.mapback.read$$i.fastq.gz; done > $@

.SECONDARY:

%.erne: %.fa
	erne-create --fasta $< --reference $@

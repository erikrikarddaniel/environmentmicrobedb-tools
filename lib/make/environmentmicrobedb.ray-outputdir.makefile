# General targets, called by rule in environmentmicrobedb.assembly.makefile
mapback: Contigs.mapback.bam

mapback-flagstat: Contigs.mapback.flagstat

Contigs.mapback.bam: inputpairs Contigs.erne 
	erne-map --threads 8 `cat $<` --reference $(word 2,$^) --bam --output $$SNIC_TMP/$@ > $$SNIC_TMP/$(basename $@).out 2> $$SNIC_TMP/$(basename $@).err && mv $$SNIC_TMP/$(basename $@)* .

%.flagstat: %.bam
	samtools flagstat $< > $@

inputpairs: RayCommand.txt
	s=`grep fastq.gz $< | sed 's/^ *\([^.]\+\).*/\1/'`; \
	for i in 1 2; do echo --query$$i ..\/..\/$$s.mapback.read$$i.fastq.gz; done > $@

.SECONDARY:

%.erne: %.fasta
	erne-create --fasta $< --reference $@

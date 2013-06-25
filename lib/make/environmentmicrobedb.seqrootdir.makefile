%.seqcount: %.fastq.gz
	echo -n "$<: " > $@
	gunzip -c $< | grep -c '@HWI-' >> $@

%.interleaved.fastq.gz: %.read1.fastq.gz %.read2.fastq.gz
	interleave_fastq $^ | gzip -c > $@

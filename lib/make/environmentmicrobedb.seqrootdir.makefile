%.interleaved.fastq: %.read1.fastq %.read2.fastq
	shuffleSequences_fastq.pl $^ $@

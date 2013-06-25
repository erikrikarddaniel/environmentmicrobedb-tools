count_all_read1s: $(subst .fastq.gz,.count,$(wildcard *.read1.fastq.gz))

gzip_all_fastqs: $(subst .fastq,.fastq.gz,$(wildcard *.fastq))

%.count: %.fastq.gz
	@lines=`gunzip -c $< | wc -l`; \
	echo "$$lines/4" | bc | sed 's/\..*//' > $@

%.fastq.gz: %.fastq
	gzip $<

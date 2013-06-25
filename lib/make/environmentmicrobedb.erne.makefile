ERNE_CR_DB = erne-create --reference $(basename $@) --fasta $< $(ERNE_OPTS)

ERNE_FILTER = erne-filter --threads $(CORES_PER_NODE) --gzip --query1 $(word 1,$^) --query2 $(word 2,$^) --contamination-reference $(word 3,$^) --output-prefix $@

.SECONDARY:

%.eht: %.fna
	$(ERNE_CR_DB)

%.rnafiltered: %.read1.fastq.gz %.read2.fastq.gz $(RNA_FILTER_DB)
	$(ERNE_FILTER)

%.hsfiltered: %.rnafiltered.read1.fastq.gz %.rnafiltered.read2.fastq.gz $(HS_FILTER_DB)
	$(ERNE_FILTER)

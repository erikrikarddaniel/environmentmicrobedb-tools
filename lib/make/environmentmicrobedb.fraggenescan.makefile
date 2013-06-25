# This makefile requires the FRAG_GENE_SCAN_PATH macro to be set to the 
# directory where the run_FragGeneScan.pl script is installed.
#
# Input files should end with assembly.contigs.fna, where `assembly' is the 
# name of the assembly program, e.g. `ray' or `velvet'.

USEARCH = usearch -cluster_smallmem $< -id 1.0 -centroids $@.centroids.fna -consout $@.consout.fna -uc $@

all_fgs: $(subst .contigs.fna,.fgs.faa,$(wildcard *.contigs.fna))

%.fgs.faa: %.contigs.fna
	$(FRAG_GENE_SCAN_PATH)/run_FragGeneScan.pl -genome=$< -out=$(basename $@) -complete=1 -train=complete

%.fgs.length_sum: %.fgs.faa
	grep -o "length_[0-9]*" $< | sed 's/length_//' | readlensum > $@

%.faa: %.fna
	translate --frames=1 $< | sed '/^>/s/_1$$//' > $@

all_samples.fgs.sorted.fna: $(wildcard *.all.fgs.ffn)
	sortfasta --field=seqlength $^ > $@

%.sorted.ffn: %.ffn
	sortfasta --field=seqlength $< > $@

%.uc: %.sorted.ffn
	usearch -cluster_smallmem $< -id 1.0 -centroids $@.centroids.fna -consout $@.consout.fna -uc $@

%.eht: %.fna
	erne-create --fasta $< --reference $(basename $@) --k 15

%.assemstats: %.fna
	assemstats 100 $< > $@

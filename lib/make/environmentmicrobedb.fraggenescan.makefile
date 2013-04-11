# This makefile requires the FRAG_GENE_SCAN_PATH macro to be set to the 
# directory where the run_FragGeneScan.pl script is installed.
#
# Input files should end with assembly.contigs.fna, where `assembly' is the 
# name of the assembly program, e.g. `ray' or `velvet'.
all_fgs: $(subst .contigs.fna,.fgs.faa,$(wildcard *.contigs.fna))

%.fgs.faa: %.contigs.fna
	$(FRAG_GENE_SCAN_PATH)/run_FragGeneScan.pl -genome=$< -out=$(basename $@) -complete=1 -train=complete

%.fgs.length_sum: %.fgs.faa
	grep -o "length_[0-9]*" $< | sed 's/length_//' | readlensum > $@

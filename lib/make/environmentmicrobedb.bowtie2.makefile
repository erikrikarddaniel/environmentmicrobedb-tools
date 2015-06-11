SHELL = /bin/bash

BOWTIE_N_CPUS = 1

BOWTIE2_LOCAL = gunzip -c $(wordlist 1,2,$^) | bowtie2 -p $(BOWTIE_N_CPUS) -x $$SNIC_TMP/$(word 3, $^) -U - --phred33 --local --no-unal | samtools view -S -b - > $@
BOWTIE2_END2END = gunzip -c $(wordlist 1,2,$^) | bowtie2 -p $(BOWTIE_N_CPUS) -x $$SNIC_TMP/$(word 3, $^) -U - --phred33 --end-to-end --no-unal | samtools view -S -b - > $@
BOWTIE2_PE_END2END = bowtie2 -p $(BOWTIE_N_CPUS) -x $$SNIC_TMP/$(word 3, $^) -1 <(gunzip -c $<) -2 <(gunzip -c $(wordlist 2,2,$^)) --phred33 --end-to-end --no-unal | samtools view -S -b - > $@

%.bt2: %.fna
	bowtie2-build --seed 12345 -f $< $@ >$@.out 2>$@.err
	touch $@


SHELL = /bin/bash

BOWTIE_N_CPUS = 1

BOWTIE2 = gunzip -c $(wordlist 1,2,$^) | bowtie2 -p $(BOWTIE_N_CPUS) -x $$SNIC_TMP/$(word 3, $^) -U - --phred33 --local --no-unal | samtools view -S -b - > $@

%.bt2: %.fna
	bowtie2-build --seed 12345 -f $< $@ >$@.out 2>$@.err
	touch $@


.SECONDARY:

%.flagstat: %.bam
	samtools flagstat $< > $@

%.idxstats: %.bam.bai
	samtools idxstats $(basename $<) | grep -Pv "\t0\t0$$" > $@

%.bam.bai: %.bam.sorted
	samtools index $(basename $<)
		        
%.bam.sorted: %.bam
	samtools sort $< $(basename $<)
	touch $@


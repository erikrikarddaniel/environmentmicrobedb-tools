%.contigs.fgs.faa: %.fna
	/proj/b2010008/FragGeneScan/run_FragGeneScan.pl -genome=$< -out=$(basename $@) -complete=1 -train=complete

%.fgs.length_sum: %.fgs.faa
	grep -o "length_[0-9]*" $< | sed 's/length_//' | readlensum > $@

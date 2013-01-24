%.contigs.fgs.faa: %.fna
	/proj/b2010008/FragGeneScan/run_FragGeneScan.pl -genome=$< -out=$(basename $@) -complete=1 -train=complete

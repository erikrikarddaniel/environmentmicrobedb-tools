DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

SIZE_CHECK = if [ ` stat -c "%s" $@.out ` -eq ` stat -c "%s" $@.expect ` ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ($@.out and $@.expect different sizes) ***"; exit 1; fi

GREP_CHECK = pattern=`cat $@.expect`; if [ `grep "$$pattern" $@.out | wc -l` -gt 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Didn't find $$pattern in output"; exit 1; fi

XML_CHECK =

all: addobs_to_annotations sam2meganannot 

clean:
	@rm -rf *.out *.tmp err sam2meganannot.*.out*

addobs_to_annotations: addobs_to_annotations.00 addobs_to_annotations.01 addobs_to_annotations.02

sam2meganannot: sam2meganannot.00 sam2meganannot.01

addobs_to_annotations.00:
	@../../scripts/addobs_to_annotations --header > $@.out
	@$(CHECK)

addobs_to_annotations.01:
	@../../scripts/addobs_to_annotations --header=$@.header --orf2id=taxon:NCBI:$@.orf2taxid --name2orf=function:SEED:$@.seedname2orf --name2orf=function:KEGG:$@.keggname2orf $@.orfs.sam | ruby -r json -e "puts JSON.pretty_generate(JSON.parse(ARGF.read))" > $@.out
	@$(CHECK)

addobs_to_annotations.02:
	@../../scripts/addobs_to_annotations --header=$@.header --orf2id=taxon:NCBI:$@.orf2taxid --name2orf=function:SEED:$@.seedname2orf --name2orf=function:KEGG:$@.keggname2orf $@.orfs.sam | ruby -r json -e "puts JSON.pretty_generate(JSON.parse(ARGF.read))" > $@.out
	@$(CHECK)

sam2meganannot.00:
	@../../scripts/sam2meganannot --basename=$@.out --megantaxcsv=$@.megantax.csv --meganseedcsv=$@.meganseed.csv --megankeggcsv=$@.megankegg.csv --full_names_fasta=$@.faa $@.*.sam
	@echo "TAXONOMY" > $@.out
	@sort $@.out.taxonomy.csv >> $@.out
	@echo "SEED" >> $@.out
	@sort $@.out.seed.csv >> $@.out
	@echo "KEGG" >> $@.out
	@sort $@.out.kegg.csv >> $@.out
	@$(CHECK)

sam2meganannot.01:
	@../../scripts/sam2meganannot --verbose --basename=$@.out --megantaxcsv=$@.megantax.csv --meganseedcsv=$@.meganseed.csv --megankeggcsv=$@.megankegg.csv --full_names_fasta=$@.faa $@.*.sam
	@echo "TAXONOMY" > $@.out
	@sort $@.out.taxonomy.csv >> $@.out
	@echo "SEED" >> $@.out
	@sort $@.out.seed.csv >> $@.out
	@echo "KEGG" >> $@.out
	@sort $@.out.kegg.csv >> $@.out
	@$(CHECK)

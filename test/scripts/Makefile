DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

SIZE_CHECK = if [ ` stat -c "%s" $@.out ` -eq ` stat -c "%s" $@.expect ` ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ($@.out and $@.expect different sizes) ***"; exit 1; fi

GREP_CHECK = pattern=`cat $@.expect`; if [ `grep "$$pattern" $@.out | wc -l` -gt 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Didn't find $$pattern in output"; exit 1; fi

XML_CHECK =

all: cdnaobservations m5nr2annot sam2meganannot 

clean:
	@rm -rf *.out *.tmp err sam2meganannot.*.out*

cdnaobservations: cdnaobservations.00 cdnaobservations.01 cdnaobservations.02

m5nr2annot: m5nr2annot.00

sam2meganannot: sam2meganannot.00 sam2meganannot.01

cdnaobservations.00:
	@../../scripts/cdnaobservations --header > $@.out
	@$(CHECK)

cdnaobservations.01:
	@../../scripts/cdnaobservations --header=$@.header --orf2id=taxon:NCBI:$@.orf2taxid --name2orf=function:SEED:$@.seedname2orf --name2orf=function:KEGG:$@.keggname2orf $@.orfs.sam | ruby -r json -e "puts JSON.pretty_generate(JSON.parse(ARGF.read))" > $@.out
	@$(CHECK)

cdnaobservations.02:
	@../../scripts/cdnaobservations --verbose --header=$@.header --orf2id=taxon:NCBI:$@.orf2taxid --name2orf=function:SEED:$@.seedname2orf --name2orf=function:KEGG:$@.keggname2orf $@.orfs.sam | ruby -r json -e "puts JSON.pretty_generate(JSON.parse(ARGF.read))" > $@.out
	@$(CHECK)

m5nr2annot.00:
	@rm -f $@.seed
	@../../scripts/m5nr2annot --verbose --datadir=$@.data --basename=$@ --fracfrombestbitscore=0.75 $@.blasttab > $@.out 2>&1
	@echo "--> SEED <--" >> $@.out
	@cat $@.seed >> $@.out
	@$(CHECK)

# This needs a symbolic link to a real M5nr data repository
m5nr2annot.large:
	@rm -f $@.seed
	@../../scripts/m5nr2annot --verbose --datadir=$@.data --basename=$@ --fracfrombestbitscore=0.75 $@.blasttab
	@echo "--> KEGG <--" >> $@.out
	@echo "--> RefSeq <--" >> $@.out
	@echo "--> SEED <--" >> $@.out
	@cat $@.seed >> $@.out
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

DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

SIZE_CHECK = if [ ` stat -c "%s" $@.out ` -eq ` stat -c "%s" $@.expect ` ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ($@.out and $@.expect different sizes) ***"; exit 1; fi

GREP_CHECK = pattern=`cat $@.expect`; if [ `grep "$$pattern" $@.out | wc -l` -gt 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Didn't find $$pattern in output"; exit 1; fi

XML_CHECK =

all: cdnaobservations m5nr2annot sam2meganannot split_seed_branches

clean:
	@rm -rf *.out *.tmp err m5nr2annot.*.kegg* m5nr2annot.*.refseq* m5nr2annot.*.seed* organisms2lca.*.names.gz sam2meganannot.*.out*

cdnaobservations: cdnaobservations.00 cdnaobservations.01 cdnaobservations.02

m5nr2annot: m5nr2annot.00

organisms2lca: organisms2lca.00 organisms2lca.01

sam2meganannot: sam2meganannot.00 sam2meganannot.01

split_seed_branches: split_seed_branches.00

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
	@echo "--> KEGG <--" >> $@.out
	@cat $@.kegg >> $@.out
	@echo "--> RefSeq <--" >> $@.out
	@echo "\taccnos" >> $@.out
	@cat $@.refseq.accnos >> $@.out
	@echo "\trefseq accnos" >> $@.out
	@cat $@.refseq.refseq_accnos >> $@.out
	@echo "\torganisms" >> $@.out
	@cat $@.refseq.organisms >> $@.out
	@echo "\tproteins" >> $@.out
	@cat $@.refseq.proteins >> $@.out
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

organisms2lca.00:
	@../../scripts/organisms2lca --field=2 --service="http://biosql.scilifelab.se/ncbi_taxon_id2full_taxon_hierarchy.json?name=" $@.organisms > $@.out
	@$(CHECK)

organisms2lca.01:
	@../../scripts/organisms2lca --verbose --field=2 --names_in=$@.namecache --names_out=$@.names.gz --service="http://biosql.scilifelab.se/ncbi_taxon_id2full_taxon_hierarchy.json?name=" $@.organisms > $@.out 2>&1
	@echo "---" >> $@.out
	@gunzip -c $@.names.gz | sort >> $@.out
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

split_seed_branches.00:
	@../../scripts/split_seed_branches --basename=$@.split $@.tsv
	@cat $@.split.* > $@.out
	@$(CHECK)

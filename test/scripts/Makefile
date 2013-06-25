DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

SIZE_CHECK = if [ ` stat -c "%s" $@.out ` -eq ` stat -c "%s" $@.expect ` ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ($@.out and $@.expect different sizes) ***"; exit 1; fi

GREP_CHECK = pattern=`cat $@.expect`; if [ `grep "$$pattern" $@.out | wc -l` -gt 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Didn't find $$pattern in output"; exit 1; fi

XML_CHECK =

all: cdnaobservations

clean:
	@rm -rf *.out *.tmp err

cdnaobservations: cdnaobservations.00 cdnaobservations.01 cdnaobservations.02

cdnaobservations.00:
	@../../scripts/cdnaobservations --header > $@.out
	@$(CHECK)

cdnaobservations.01:
	@../../scripts/cdnaobservations --header=$@.header --orf2id=taxon:NCBI:$@.orf2taxid --name2orf=function:SEED:$@.seedname2orf --name2orf=function:KEGG:$@.keggname2orf $@.orfs.sam | ruby -r json -e "puts JSON.pretty_generate(JSON.parse(ARGF.read))" > $@.out
	@$(CHECK)

cdnaobservations.02:
	@../../scripts/cdnaobservations --verbose --header=$@.header --orf2id=taxon:NCBI:$@.orf2taxid --name2orf=function:SEED:$@.seedname2orf --name2orf=function:KEGG:$@.keggname2orf $@.orfs.sam | ruby -r json -e "puts JSON.pretty_generate(JSON.parse(ARGF.read))" > $@.out
	@$(CHECK)

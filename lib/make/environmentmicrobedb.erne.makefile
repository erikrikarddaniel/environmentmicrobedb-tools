ERNE_CR_DB = erne-create --reference $@ --fasta $< --bl $(ERNE_BL) --k $(ERNE_K)

.SECONDARY:

%.erne: %.fna
	$(ERNE_CR_DB)

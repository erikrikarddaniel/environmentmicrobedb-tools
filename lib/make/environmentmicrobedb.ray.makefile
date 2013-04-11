ASSEMBLY_OUTPUT_DIR_MAKEFILE = environmentmicrobedb.ray-outputdir.makefile

%.contigfilelist:
	ls -d $(basename $@)*.d/Contigs.fasta > $@

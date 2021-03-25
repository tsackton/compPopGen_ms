#!/bin/bash

#assume once snakemake-ified will have access to  config options:
# 1) the species code
# 2) the path to use for coverage files
# 3) the path to bam files

# once snakemake-ified should run a separate job for each bam file, so currently writing to take a specific file
# this will presumably be auto-generated by snakemake eventually

set -o errexit

SPECIES=$1
COVPATH=$2
BAMPATH=$3
INDV=$4
BAMFILE="$BAMPATH""$INDV"

bedtools genomecov -bga -ibam ${BAMFILE} -g ${COVPATH}/${SPECIES}.chrom.sizes | tee ${COVPATH}/$INDV.bg | gzip > ${COVPATH}/$INDV.bg.gz
sort -k1,1 -k2,2n ${COVPATH}/$INDV.bg | bedGraphToBigWig - ${COVPATH}/${SPECIES}.chrom.sizes ${COVPATH}/${INDV}.bw
rm ${COVPATH}/$INDV.bg
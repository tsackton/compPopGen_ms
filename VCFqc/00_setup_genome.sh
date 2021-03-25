#!/bin/bash

#assume once snake-make-ified will have access to three config options:
# 1) the location of the reference genome
# 2) the species code
# 3) the path to use for coverage files

REFGENOME=$1
SPECIES=$2
COVPATH=$3

faToTwoBit ${REFGENOME} ${COVPATH}/${SPECIES}.2bit
twoBitInfo ${COVPATH}/${SPECIES}.2bit stdout | sort -k2rn > ${COVPATH}/${SPECIES}.chrom.sizes
awk 'BEGIN{FS=OFS="\t"}{print $1, 0, $2, $1}' ${COVPATH}/${SPECIES}.chrom.sizes > ${COVPATH}/${SPECIES}.genome.bed

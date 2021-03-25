
#!/bin/bash

#assume once snakemake-ified will have access to  config options:
# 1) the species code
# 2) the path to use for coverage files

# once snakemake-ified should run a separate job for each bam file, so currently writing to take a specific file
# this will presumably be auto-generated by snakemake eventually

set -o errexit

SPECIES=$1
COVPATH=$2

mean=$(awk '{sum = sum+$4}{size=size+$2}{avg=sum/size}END{print avg}' ${COVPATH}/${SPECIES}.summary.tab)

gzip -dc ${COVPATH}/${SPECIES}.merge.bg.gz | awk -v avg="$mean" -v spp=${COVPATH}/$SPECIES {
    cov = $4
    if (cov < 0.5*avg)
        print $1, $2, $3, cov >> spp"_coverage_sites_low.bed"
    else if (cov > 2.0*avg)
        print $1, $2, $3, cov >> spp"_coverage_sites_high.bed"
    else
        print $1, $2, $3, cov >> spp"_coverage_sites_clean.bed"
}

#code to clean up bed files, e.g. merge, etc, goes here once we figure it out
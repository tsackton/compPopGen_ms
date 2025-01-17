#!/bin/bash

# run from /n/holylfs/LABS/informatics/ashultz/CompPopGen/SPECIES_DATASETS/gatherVCFs_dir/vcfs

# ./vcfHeaderClean.sh spp_name

module load htslib/1.5-fasrc02 bcftools/1.5-fasrc02

zcat $1_updatedFilter.vcf.gz | \
sed -e '/^##FILTER=<ID=LowQual,Description=/d' \
-e '/^##FILTER=<ID=GATK_default,Description=/d' \
-e '/^##FILTER=<ID=FS_SOR_filter,Description=/s/.*/##FS_SOR_filter,Description="filter SNPs for strand bias with Phred-scaled p-value for Fishers exact test above 60 and Symmetric Odds Ratio above 3; or indels; or if mixed, a Phred-scaled p-value above 200 and a Symmetric Odds Ratio above 10"/' \
-e '/^##FILTER=<ID=MQ_filter,Description=/s/.*/##MQ_filter,Description="filter SNPs with RMS mapping quality less than 40 and Z-score for Wilcoxon rank sum test for read mapping quality less than -12.5"/' \
-e '/^##FILTER=<ID=RPRS_filter,Description=/s/.*/##RPRS_filter,Description="filter SNPs with Z-Score for Wilcoxon rank sum test for read position bias less than -8; or indels; or if mixed, a Z-Score for Wilcoxon rank sum test less than -20"/' | \
bgzip -c > $1_final.clean.vcf.gz

bcftools index -t $1_final.clean.vcf.gz

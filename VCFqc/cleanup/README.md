### Standalone scripts for clean up and standardization of output

VCFs: bringing output from previous scripts to match snakemake output & fix filtering from snakemake to match previous scripts  

Coverage: coverage bedgraphs and histograms per BAM  

Site filtering: callable and mappable regions to annotate each VCF with filtering thresholds  

QC: filter VCFs for individual missingness and depth, site coverage and mappability, compute SNPs and callable sites per 50 kb, create sample metadata, data exploration

### Description of scripts ###

(roughly in order one would run them after the fastq2vcf snakemake finishes)

chromSizes.sh: create file of chromosome sizes from a reference fasta
run_genomecov.sh: create a coverage bedgraph for each bam file
run_compressBedg.sh: gzip bedgraphs
run_bedg2bw.sh: uncompress bedgraphs, sort, convert to bigWig, merge bigWigs
run_bwSummaries.sh: make genome bed, convert merged bedgraph to bigwig, run bigWigAverageOverBed to get summary, gzip merged bedgraph
write_coverage_beds.sh: output clean coverage, high coverage, and low coverage bed files using sum_cov.awk awk script

(helper scripts that might be needed for "production" runs)
vcfHeaderClean.sh: update description of GATK filters to be more descriptive

(helper scripts that shouldn't be needed for "production" runs)

run_moveBedgraphs.sh: move bedgraphs around directory structure
run_concatVCFs.sh: concatenate interval VCFs into a single vcf with bcftools
run_gatkUpdate_cpg.sh and run_gatkUpdate.sh: rename and clean up filters for VCF files
run_removeVCF.sh: remove interval VCFs
vcfLineCheck.sh: check that concatVCFs worked

### Proposed refactor ###

00_setup_genome.sh: create file of chromosome sizes from a reference fasta, make genome bed
01_genomecov.sh: create a coverage bedgraph for each bam file, sort, compress
02_mergeBedgraphs.sh: convert bedGraphs to bigWig, merge bigWigs, convert to bigWig, make summary file, gzip merged bedGraph
03_write_coverage_beds.sh: output clean coverage, high coverage, and low coverage bed files using sum_cov.awk awk script 

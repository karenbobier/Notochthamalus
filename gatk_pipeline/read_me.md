scripts in this folder are to analyse sequence data from fastq files to generating vcf files

scripts 1-3 are based on a tutorial for using gatk to mark duplicates

https://gatkforums.broadinstitute.org/gatk/discussion/2799#latest

script1.sh Generate a SAM file containing aligned reads
script2.sh Convert to BAM, and sort
script3.sh runs MarkDuplicates


#################################################
Next we need to run HaplotypeCaller and make vcf files

script4.sh will write and submit a script  to run HaplotypeCaller for each sample and produce a gvcf file

script5.sh will combine the individual gvcf files into one and make a joint vcf files

script6.sh will calculate the coverage in the bam files

script7.sh will create a table of variants from a vcf

script8.sh will run bqsr and output a recalibrated .bam file

scripts in this folder are based on a tutorial for using gatk to mark duplicates

https://gatkforums.broadinstitute.org/gatk/discussion/2799#latest

script1.sh Generate a SAM file containing aligned reads
script2.sh Convert to BAM, and sort
script3.sh runs MarkDuplicates


#################################################
Next we need to run HaplotypeCaller

script4.sh will write and submit a script  to run HaplotypeCaller for each sample

script5.sh will combine the individual gvcf files into one and make a joint vcf files

script6.sh will calculate the coverage in the bam files

#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_isomerase_aln
#PBS -l nodes=1:ppn=1
#PBS -l walltime=1:00:00
#PBS -l mem=50gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_isomerase.out.$PBS_JOBID
#PBS -e $HOME/noto_isomerase.err.$PBS_JOBID



#set base directory and move there
basedir="/scratch/keb27269/noto/isomerase_stuff"
#mkdir $basedir
cd $basedir

#load programs
samtools_module="SAMtools/1.9-foss-2016b"
module load Python/3.5.2-foss-2016b
#location of picard module
picard_module="picard/2.4.1-Java-1.8.0_144"
#location of GATK module
GATK_module="GATK/4.0.3.0-Java-1.8.0_144"
#location of BWA module
bwa_module="BWA/0.7.15-foss-2016b"

module load ${picard_module}
module load ${bwa_module}
module load ${samtools_module}
module load ${GATK_module}

ref_genome="/scratch/keb27269/noto/isomerase_stuff/semibalanus_MK955540.fasta"
#
# #samtools faidx ${ref_genome}
#
# #bwa index ${ref_genome}
# BASE="ARG10"
# read_group="@RG\tID:${BASE}\tSM:${BASE}\tPL:illumina\tLB:${BASE}"
# bwa mem -M -t 6 -R ${read_group} ${ref_genome} /scratch/keb27269/noto/dna_reads/${BASE}_R1_001.fastq > ${basedir}/reads_aligned_to_mpi.sam
#
# time java -Xmx20g -classpath "/usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144" -jar \
# /usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144/picard.jar SortSam \
#     INPUT=${basedir}/reads_aligned_to_mpi.sam \
#     OUTPUT=${basedir}/reads_aligned_to_mpi.bam \
#     SORT_ORDER=coordinate
#
# #remove duplicates
# time java -Xmx20g -classpath "/usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144" -jar \
# /usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144/picard.jar MarkDuplicates \
# REMOVE_DUPLICATES=TRUE \
# I=${basedir}/reads_aligned_to_mpi.bam \
# O=${basedir}/reads_aligned_to_mpi_removedDuplicates.bam \
# M=${basedir}/reads_aligned_to_mpi_removedDupsMetrics.txt

#index the bam files
# samtools index ${basedir}/reads_aligned_to_mpi_removedDuplicates.bam

# #create a .dict file for cds reference
# java -Xmx20g -classpath "/usr/local/apps/eb/picard/2.4.1-Java-1.8.0_144" -jar  \
# /usr/local/apps/eb/picard/2.4.1-Java-1.8.0_144/picard.jar CreateSequenceDictionary \
#       R="/scratch/keb27269/noto/isomerase_stuff/semibalanus_MK955540.fasta" \
#       O="/scratch/keb27269/noto/isomerase_stuff/semibalanus_MK955540.dict"/
#
#run haplotype caller
# time gatk HaplotypeCaller -R $ref_genome \
# -ERC GVCF -I ${basedir}/reads_aligned_to_mpi_removedDuplicates.bam -ploidy 2 \
# --dont-use-soft-clipped-bases -sample-name ARG10 --standard-min-confidence-threshold-for-calling 20.0 \
# -O ${basedir}/reads_aligned_to_mpi_ARG10_haplotypes.g.vcf

#genotype gvcfs
time gatk GenotypeGVCFs \
        -R ${ref_genome} \
        --variant ${basedir}/reads_aligned_to_mpi_ARG10_haplotypes.g.vcf \
        -O ${basedir}/reads_aligned_to_mpi_ARG10_haplotypes.vcf

#zip and index vcf
cat reads_aligned_to_mpi_ARG10_haplotypes.vcf| bgzip -c > reads_aligned_to_mpi_ARG10_haplotypes.vcf.gz
tabix reads_aligned_to_mpi_ARG10_haplotypes.vcf.gz

module load BCFtools/1.9-foss-2016b
bcftools mpileup -f $ref_genome reads_aligned_to_mpi_removedDuplicates.bam| bcftools call -m | vcfutils.pl vcf2fq > reads_aligned_to_mpi_removedDuplicates.fq
#samtools mpileup -uf $ref_genome reads_aligned_to_mpi_removedDuplicates.bam| bcftools call -m | vcfutils.pl vcf2fq > reads_aligned_to_mpi_removedDuplicates.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds /scratch/keb27269/noto/last/sort* | bcftools call -mv > varLAST.raw.vcf
bcftools filter -s LowQual -e '%QUAL<20 || DP>100' varLAST.raw.vcf  > varLAST.flt.vcf

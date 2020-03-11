#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_gakt8
#PBS -l nodes=1:ppn=6
#PBS -l walltime=4:00:00:00
#PBS -l mem=200gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_gatk.out.$PBS_JOBID
#PBS -e $HOME/noto_gatk.err.$PBS_JOBID

#set base directory and move there
basedir="/scratch/keb27269/noto/"
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

#set path to reference genome (noto transcritome cds file)
ref_genome="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.fasta"

######################################
#This script will run base quality score recalibraiton
##########################################
#recalibrate base quality scores in all samples to mask consensus variants
##############################################################################
# for file in ${basedir}removed_duplicates/*_removedDuplicates.bam
# do
#
# FBASE=$(basename $file _removedDuplicates.bam)
# BASE=${FBASE%_removedDuplicates.bam}
#
# time gatk BaseRecalibrator \
#   -I ${basedir}removed_duplicates/${BASE}_removedDuplicates.bam \
#   --known-sites ${basedir}noto_all_invd.vcf \
#   -O ${basedir}${BASE}_recal_data.table \
#   -R ${ref_genome}
#
# done
################################################################
#apply BQSR ro bam files
################################################################
mkdir ${basedir}recalibrated

for file in ${basedir}removed_duplicates/*_removedDuplicates.bam
do

FBASE=$(basename $file _removedDuplicates.bam)
BASE=${FBASE%_removedDuplicates.bam}

gatk ApplyBQSR \
  -R ${ref_genome} \
  -I ${basedir}removed_duplicates/${BASE}_removedDuplicates.bam \
  -bqsr ${basedir}${BASE}_recal_data.table \
  -O ${basedir}recalibrated/${BASE}_recalibrated.bam

done

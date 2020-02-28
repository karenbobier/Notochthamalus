#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_gakt1
#PBS -l nodes=1:ppn=12
#PBS -l walltime=6:00:00:00
#PBS -l mem=400gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_gatk.out.$PBS_JOBID
#PBS -e $HOME/noto_gatk.err.$PBS_JOBID


basedir="/scratch/keb27269/noto/last/"
#mkdir $basedir
cd $basedir

module load SAMtools/1.9-foss-2016b

################################################################################
#index the sorted bam files
################################################################################
for file in ${basedir}/sort*.bam
do
  samtools index -@12 $file
done

################################################################################
#use picard to mark duplicates
################################################################################
module load  picard/2.4.1-Java-1.8.0_144
module load Python/3.5.2-foss-2016b

for file in ${basedir}/sort*.bam
do
FBASE=$(basename $file .bam)
BASE=${FBASE%.bam}
time java -Xmx20g -classpath "/usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144" -jar \
/usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144/picard.jar MarkDuplicates \
REMOVE_DUPLICATES=TRUE \
I=${basedir}/${BASE}.bam \
O=${basedir}/${BASE}_removedDuplicates.bam \
M=${basedir}/${BASE}_removedDupsMetrics.txt

done

################################################################################
#use gatk haplotype caller
################################################################################

#

#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_gakt1
#PBS -l nodes=1:ppn=6
#PBS -l walltime=2:00:00:00
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

# this script will run mark duplicates

# Run the following Picard command to mark duplicates:
# java -jar picard.jar MarkDuplicates \
#     INPUT=sorted_reads.bam \
#     OUTPUT=dedup_reads.bam \
#     METRICS_FILE=metrics.txt

mkdir ${basedir}removed_duplicates

for file in ${basedir}sorted_reads/*_sorted_reads.bam
do
FBASE=$(basename $file _sorted_reads.bam)
BASE=${FBASE%.bam}
time java -Xmx20g -classpath "/usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144" -jar \
/usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144/picard.jar MarkDuplicates \
REMOVE_DUPLICATES=TRUE \
I=${basedir}sorted_reads/${BASE}_sorted_reads.bam \
O=${basedir}removed_duplicates/${BASE}_removedDuplicates.bam \
M=${basedir}removed_duplicates/${BASE}_removedDupsMetrics.txt

done

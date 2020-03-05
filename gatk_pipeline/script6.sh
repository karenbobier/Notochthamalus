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
deeptools_module="deepTools/3.2.1-foss-2018a-Python-3.6.4"
module load ${deeptools_module}

##################################################################################################
### Find coverage and put into 10k chunks
###################################################################################################

for file in ${basedir}removed_duplicates/*_removedDuplicates.bam
do
FBASE=$(basename $file _removedDuplicates.bam)
BASE=${FBASE%_removedDuplicates.bam}
bamCoverage -b ${basedir}removed_duplicates/${BASE}_removedDuplicates.bam \
-o ${basedir}removed_duplicates/${BASE}.bedgraph -of bedgraph -bs 10000
done

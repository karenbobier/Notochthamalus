#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N noto_freebayes
#PBS -l nodes=1:ppn=6
#PBS -l walltime=2:00:00:00
#PBS -l mem=200gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_freebayes.out.$PBS_JOBID
#PBS -e $HOME/noto_freebayes.err.$PBS_JOBID

#set base directory and move there
basedir="/scratch/keb27269/noto/freebayes/"
#mkdir $basedir
cd ${basedir}2_fastqc

for fq in ../1_data/*.fastq.gz; do
  ln -s $fq
done

module load  parallel/20200422-GCCcore-8.3.0
module load FastQC/0.11.8-Java-11

parallel "fastqc {}"" ::: *.fastq

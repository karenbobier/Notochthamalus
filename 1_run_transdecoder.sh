#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N 1_transdecoder_noto
#PBS -l nodes=1:ppn=20
#PBS -l walltime=30:00:00:00
#PBS -l mem=200gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/1_transdecoder_noto.out.$PBS_JOBID
#PBS -e $HOME/1_transdecoder_noto.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/"
#mkdir $basedir
cd $basedir

module load TransDecoder/2.1.0-foss-2016b-Perl-5.24.1
#module load HMMER/3.1b2-foss-2016b
#module load BLAST+/2.7.1-foss-2016b-Python-2.7.14

TransDecoder.LongOrfs -t /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta \
-m 100 --cpu 20 -T

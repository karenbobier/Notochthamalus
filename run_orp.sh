#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N ORP_test_noto_1
#PBS -l nodes=1:ppn=16
#PBS -l walltime=30:00:00:00
#PBS -l mem=300gb
#PBS -M keb27269@uga.edu
#PBS -m ae
#PBS -o $HOME/orp_noto1.4.out.$PBS_JOBID
#PBS -e $HOME/orp_noto1.4.err.$PBS_JOBID

basedir="/lustre1/keb27269/noto/"
#mkdir $basedir
cd $basedir

ml ORP/2.0.0

. $ORPCONDAPATH/conda.sh

source activate orp_v2

$ORPHOME/oyster.mk main \
MEM=300 \
CPU=16 \
READ1=Noto_read_1.fq.gz \
READ2=Noto_read_2.fq.gz \
RUNOUT=noto_1.4

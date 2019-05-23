#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N ORP_noto
#PBS -l nodes=1:ppn=20
#PBS -l walltime=30:00:00:00
#PBS -l mem=400gb
#PBS -M keb27269@uga.edu
#PBS -m ae
#PBS -o $HOME/orp_noto.out.$PBS_JOBID
#PBS -e $HOME/orp_noto.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/"
#mkdir $basedir
cd $basedir

ml ORP/2.0.0

. $ORPCONDAPATH/conda.sh

source activate orp_v2

$ORPHOME/oyster.mk main \
MEM=400 \
CPU=20 \
READ1=Noto_read_1.fq.gz \
READ2=Noto_read_2.fq.gz \
RUNOUT=noto \
#--dry-run # 1>std.out 2>std.err

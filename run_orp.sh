#PBS -S /bin/bash
#PBS -q eupathdb_q
#PBS -N ORP_test_noto_1
#PBS -l nodes=1:ppn=28
#PBS -l walltime=240:00:00
#PBS -l mem=480gb
#PBS -M shtsai@uga.edu
#PBS -m ae

#basedir="/scratch/keb27269/noto/"
#mkdir $basedir
#cd $basedir
cd $PBS_O_WORKDIR

ml ORP/2.0.0

. $ORPCONDAPATH/conda.sh

source activate orp_v2

$ORPHOME/oyster.mk main \
MEM=470 \
CPU=28 \
READ1=Noto_read_1.fq.gz \
READ2=Noto_read_2.fq.gz \
RUNOUT=noto_1.5

#Shan-ho at gacrc helped troubleshoot this script to get ORP to run wihtout errors
#--dry-run # 1>std.out 2>std.err

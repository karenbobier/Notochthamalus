#PBS -S /bin/bash
#PBS -q batch
#PBS -N ORP_test
#PBS -l nodes=1:ppn=6:highmem_q:AMD
#PBS -l walltime=30:00:00:00
#PBS -l mem=200gb
#PBS -M keb27269@uga.edu
#PBS -m ae
#PBS -o $HOME/opr_test.out
#PBS -e $HOME/orp_test.err

basedir="/lustre1/keb27269/noto/"
mkdir $basedir
cd $basedir

ml ORP/2.0.0

. $ORPCONDAPATH/conda.sh

source activate orp_v2

$ORPHOME/oyster.mk main \
MEM=15 \
CPU=8 \
READ1=Noto2_USR18000676L_HCCTGDMXX_L1_1.fq.gz \
READ2=Noto2_USR18000676L_HCCTGDMXX_L2_1.fq.gz \
RUNOUT=stest

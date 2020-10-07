#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_spades_semibal
#PBS -l nodes=1:ppn=16
#PBS -l walltime=5:00:00:00
#PBS -l mem=250gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_spades_semibal.out.$PBS_JOBID
#PBS -e $HOME/noto_spades_semibal.err.$PBS_JOBID

#set base directory and move there
basedir="/scratch/keb27269/"
#mkdir $basedir
cd $basedir

#set path to Semibalanus reference genome (noto transcritome cds file)
ref_genome="/scratch/keb27269/noto/GCA_014673585.1_Sbal3.1_genomic.fna"
mkdir ${basedir}Semibalanus/spades_assembly
module load spades/3.12.0-k_245

python /usr/local/apps/gb/spades/3.12.0-k_245/bin/spades.py \
-1 ${basedir}noto/dna_reads/Arg21_ATGTCA_L008_R1_001_val_1.fq \
-2 ${basedir}noto/dna_reads/Arg21_ATGTCA_L008_R2_001_val_2.fq \
-o ${basedir}Semibalanus/spades_assembly/ \
-t 16 -m 250

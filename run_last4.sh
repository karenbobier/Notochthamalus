#PBS -S /bin/bash
#PBS -q batch
#PBS -N last4_noto
#PBS -l nodes=1:ppn=1
#PBS -l walltime=4:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/last4.out.$PBS_JOBID
#PBS -e $HOME/last4.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/last/"
#mkdir $basedir
cd $basedir

#module load LAST/956-foss-2016b
module load LAST/959-foss-2018a
#module load SAMtools/1.6-foss-2016b
module load SAMtools/1.9-foss-2016b
module load BCFtools/1.9-foss-2016b

samtools mpileup -uf filtered_Trinity.fasta /scratch/keb27269/noto/last/sort* | bcftools call -mv > varLAST.raw.vcf
bcftools filter -s LowQual -e '%QUAL<20 || DP>100' varLAST.raw.vcf  > varLAST.flt.vcf

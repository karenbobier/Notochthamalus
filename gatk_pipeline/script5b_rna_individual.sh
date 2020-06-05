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

module load VCFtools/0.1.15-foss-2016b-Perl-5.24.1
################################################################################
#this script will seperate snps and indels into seperate vcf files
################################################################################


#set path to reference genome (noto transcritome cds file)
ref_genome="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.fasta"

##################################################################################


# separate indels
vcftools --vcf $vcf --keep-only-indels --recode --recode-INFO-all --out output_indels-only.vcf
# separate SNPs
vcftools --vcf $vcf --remove-indels --recode --recode-INFO-all --out output_snps-only.vcf

for file in ${basedir}gvcfs_rna/*.rna.vcf
do
FBASE=$(basename $file .rna.vcf)
BASE=${FBASE%.bam}
# separate indels
vcftools --vcf $file --keep-only-indels --recode --recode-INFO-all --out ${basedir}gvcfs_rna/${BASE}output_indels_only
# separate SNPs
vcftools --vcf $file --remove-indels --recode --recode-INFO-all --out ${basedir}gvcfs_rna/${BASE}output_snps_only
done

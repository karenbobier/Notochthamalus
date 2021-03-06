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
samtools_module="SAMtools/1.9-foss-2016b"
module load Python/3.5.2-foss-2016b
#location of picard module
picard_module="picard/2.4.1-Java-1.8.0_144"
#location of GATK module
GATK_module="GATK/4.0.3.0-Java-1.8.0_144"
#location of BWA module
bwa_module="BWA/0.7.15-foss-2016b"

module load ${picard_module}
module load ${bwa_module}
module load ${samtools_module}
module load ${GATK_module}

################################################################################
#this script willl combine the individual gvcf files into one gvcf
################################################################################
#note  this took 16.5 hrs to run for 13 diploids

#set path to reference genome (noto transcritome cds file)
ref_genome="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.fasta"

#combine vcf files into one

#time gatk CombineGVCFs \
# -O ${basedir}noto_all_invd.rna.g.vcf \
# -R ${ref_genome} \
# --variant ${basedir}gvcfs_rna/ARI4_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARI6_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARI10_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARI11_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARI12_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARI102_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARG10_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARG18_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARG19_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARG21_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARG25_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARG27_haplotypes.g.vcf \
# --variant ${basedir}gvcfs_rna/ARG29_haplotypes.g.vcf

###################################################################################################
### EDIT GENOTYPE INDIVIDUAL SAMPLES not Jointly genotype samples to identify consensus sequences
###################################################################################################

for file in ${basedir}gvcfs_rna/*.g.vcf
do
FBASE=$(basename $file .g.vcf)
BASE=${FBASE%.bam}
time gatk GenotypeGVCFs \
         -R ${ref_genome} \
         --variant ${basedir}gvcfs_rna/${BASE}.g.vcf \
         -O ${basedir}gvcfs_rna/${BASE}.rna.vcf
done


##################################################################################################
###zip and index vcf
##################################################################################################

for file in ${basedir}gvcfs_rna/*.g.vcf
do
FBASE=$(basename $file .g.vcf)
BASE=${FBASE%.bam}

cat  ${basedir}gvcf_rna/${BASE}.rna.vcf | bgzip -c >  ${basedir}gvcf_rna/${BASE}.rna.vcf.gz
tabix  ${basedir}gvcf_rna/${BASE}.rna.vcf.gz

done

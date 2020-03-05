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

#set path to reference genome (noto transcritome cds file)
ref_genome="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.fasta"

#combine vcf files into one

time gatk CombineGVCFs \
 -O ${basedir}noto_all_invd.g.vcf \
 -R ${ref_genome} \
 --variant ${basedir}gvcfs/sortARI4_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARI6_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARI10_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARI11_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARI12_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARI102_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARG10_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARG18_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARG19_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARG21_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARG25_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARG27_haplotypes.g.vcf \
 --variant ${basedir}gvcfs/sortARG29_haplotypes.g.vcf

###################################################################################################
### Jointly genotype samples to identify consensus sequences
###################################################################################################

 time gatk GenotypeGVCFs \
         -R ${ref_genome} \
         --variant ${basedir}noto_all_invd.g.vcf \
         -O ${basedir}noto_all_invd.vcf

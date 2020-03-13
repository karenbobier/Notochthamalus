#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_gakt8
#PBS -l nodes=1:ppn=6
#PBS -l walltime=4:00:00:00
#PBS -l mem=300gb
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

#set path to reference genome (noto transcritome cds file)
ref_genome="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.fasta"

###################################################################################################
## Run HaplotypeCaller again on recalibrated samples
###################################################################################################

mkdir ${basedir}recal_gvcf

for file in ${basedir}recalibrated/*_recalibrated.bam
do

FBASE=$(basename $file _recalibrated.bam)
BASE=${FBASE%_recalibrated.bam}

time gatk HaplotypeCaller \
-R ${ref_genome} \
-ERC GVCF \
-I ${basedir}recalibrated/${BASE}_recalibrated.bam \
-ploidy 2 \
-O ${basedir}recal_gvcf/${BASE}_variants.Recal.g.vcf
done

##################################################################################################
## Combine gvcfs
###################################################################################################

module load ${GATK_module}

       time gatk CombineGVCFs \
          -R ${ref_genome} \
          -O ${basedir}Noto_all_recal.g.vcf \
          -V ${basedir}recal_gvcf/ARI4_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARI6_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARI10_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARI11_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARI12_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARI102_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARG10__variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARG18_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARG19_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARG21_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARG25_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARG27_variants.Recal.g.vcf \
          -V ${basedir}recal_gvcf/ARG29_variants.Recal.g.vcf

###################################################################################################
## Genotype gVCFs (jointly)
###################################################################################################
###################################################################################################
time gatk GenotypeGVCFs \
    -R ${ref_genome} \
    -ploidy 2 \
    --variant ${basedir}Noto_all_recal.g.vcf \
    -O ${basedir}Noto_all_recal.vcf

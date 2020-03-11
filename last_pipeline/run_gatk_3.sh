#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_gakt1
#PBS -l nodes=1:ppn=12
#PBS -l walltime=6:00:00:00
#PBS -l mem=400gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_gatk.out.$PBS_JOBID
#PBS -e $HOME/noto_gatk.err.$PBS_JOBID


basedir="/scratch/keb27269/noto/last/"
#mkdir $basedir
cd $basedir

module load SAMtools/1.9-foss-2016b

################################################################################
#combine vcf files into one
################################################################################

time gatk CombineGVCFs \
 -O ${basedir}/D1_cohortNewRef.g.vcf \
 -R ${ref_genome} \
 --variant ${basedir}/sortARI4_haplotypes.g.vcf \
 --variant ${basedir}/sortARI6_haplotypes.g.vcf \
 --variant ${basedir}/sortARI10_haplotypes.g.vcf \
 --variant ${basedir}/sortARI11_haplotypes.g.vcf \
 --variant ${basedir}/sortARI12_haplotypes.g.vcf \
 --variant ${basedir}/sortARI102_haplotypes.g.vcf \
 --variant ${basedir}/sortARG10_haplotypes.g.vcf \
 --variant ${basedir}/sortARG18_haplotypes.g.vcf \
 --variant ${basedir}/sortARG19_haplotypes.g.vcf \
 --variant ${basedir}/sortARG21_haplotypes.g.vcf \
 --variant ${basedir}/sortARG25_haplotypes.g.vcf \
 --variant ${basedir}/sortARG27_haplotypes.g.vcf \
 --variant ${basedir}/sortARG29_haplotypes.g.vcf


#####################################################################################################
### Run GenotypeGVCFs on recalibrated samples
# ###################################################################################################
# ###################################################################################################
# #
for file in ${basedir}/*_haplotypes.g.vcf

do

FBASE=$(basename $file _haplotypes.g.vcf)
BASE=${FBASE%_haplotypes.g.vcf}

time gatk GenotypeGVCFs \
     -R ${ref_genome} \
     --variant ${basedir}/${BASE}_variants.g.vcf \
     -O ${basedir}/${BASE}.vcf

done

gatk VariantFiltration \
-V ${output_directory}/HM-D1-A.vcf \
-O ${output_directory}/HM-D1-A_hetsFil.vcf \
--genotype-filter-expression "isHet == 1" \
--genotype-filter-name "isHetFilter"


gatk SelectVariants \
-V ${output_directory}/HM-D1-A_hetsFil.vcf \
--set-filtered-gt-to-nocall \
-O ${output_directory}/HM-D1-A_hetsFil_SV.vcf


time gatk SelectVariants \
       -R ${ref_genome} \
       -V ${output_directory}/HM-D1-A_hetsFil_SV.vcf \
       -O ${output_directory}/HM-D1-A_hetsFil_SV_noNoCalls.vcf \
       --max-nocall-number 0


# # ###################################################################################################
# ### Combine VCFs together
# # ###################################################################################################
module load GATK/3.8-1-Java-1.8.0_144

java -jar $EBROOTGATK/GenomeAnalysisTK.jar \
   -T CombineVariants \
   -R ${ref_genome} \
   -V ${output_directory}/HM-D1-A_hetsFil_SV_noNoCalls.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-10.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-20.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-31.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-42.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-21.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-32.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-44.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-11.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-22.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-33.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-45.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-12.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-24.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-35.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-46.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-13.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-25.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-36.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-4.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-14.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-26.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-37.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-5.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-15.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-27.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-38.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-6.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-16.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-28.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-39.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-7.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-17.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-29.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-3.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-8.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-18.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-2.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-9.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-19.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-30.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-40.vcf \
      -V /scratch/hcm14449/TE_MA_Paradoxus/Illumina_Data/Out/D1/HM-D1-41.vcf \
      -o ${output_directory}/fullCohort.vcf \
      -genotypeMergeOptions UNIQUIFY

module unload GATK/3.8-1-Java-1.8.0_144



module load ${GATK_module}

gatk VariantsToTable \
            -V ${output_directory}/fullCohort.vcf \
            -F CHROM -F POS -F REF -F ALT -F QUAL -F DP -F GT \
            -GF AD -GF GT -GF DP \
            -O ${output_directory}/fullCohort.txt

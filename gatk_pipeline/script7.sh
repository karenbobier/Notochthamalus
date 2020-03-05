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

#location of GATK module
GATK_module="GATK/4.0.3.0-Java-1.8.0_144"
module load ${GATK_module}

###########################################################################
#This script will make a table of variants from a vcf file
###########################################################################

gatk VariantsToTable \
            -V ${basedir}noto_all_invd.vcf \
            -F CHROM -F POS -F REF -F ALT -F QUAL -F DP -F GT \
            -GF AD -GF GT -GF DP \
            -O ${basedir}noto_all_indv_variants.txt

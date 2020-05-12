#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_gakt1
#PBS -l nodes=1:ppn=1
#PBS -l walltime=6:00:00:00
#PBS -l mem=50gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_gatk.out.$PBS_JOBID
#PBS -e $HOME/noto_gatk.err.$PBS_JOBID

####################################################################################
#this script will write and submit a script to run HaplotypeCaller for each sample
####################################################################################

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

#create a .dict file for cds reference
#java -Xmx20g -classpath "/usr/local/apps/eb/picard/2.4.1-Java-1.8.0_144" -jar  \
#/usr/local/apps/eb/picard/2.4.1-Java-1.8.0_144/picard.jar CreateSequenceDictionary \
#       R="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.fasta" \
#       O="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.dict"


mkdir ${basedir}gvcfs_rna

# #RNAseq dataset :
# java ‐jar GenomeAnalysisTK.jar ‐T HaplotypeCaller \
# ‐R ref/human_g1k_b37_20.fasta \
# ‐I bams/exp_design/NA12878_rnaseq_pp_20.bam \
# ‐o sandbox/NA12878_rnaseq_20_HC_calls.vcf \
# ‐L 20:15,800,000‐16,100,000 \
# ‐dontUseSoftClippedBases \
# ‐stand_call_conf 20.0 ‐stand_emit_conf 20.0

#loop to make scripts to run haplotpe caller
for file in ${basedir}removed_duplicates/*_removedDuplicates.bam
do
FBASE=$(basename $file _removedDuplicates.bam)
BASE=${FBASE%_removedDuplicates.bam}
OUT="${BASE}_gatk2.sh"
echo "#!/bin/bash" >> ${OUT}
echo "#PBS -N ${BASE}_gatk2" >> ${OUT}
echo "#PBS -l walltime=4:00:00:00" >> ${OUT}
echo "#PBS -l nodes=1:ppn=1:HIGHMEM" >> ${OUT}
echo "#PBS -q highmem_q" >> ${OUT}
echo "#PBS -l mem=200gb" >> ${OUT}
echo "" >> ${OUT}
echo "module load ${GATK_module}" >> ${OUT}
echo "" >> ${OUT}
echo "time gatk HaplotypeCaller \
-R ${ref_genome} \
-ERC GVCF \
-I ${basedir}removed_duplicates/${BASE}_removedDuplicates.bam \
-ploidy 2 \
--dont-use-soft-clipped-bases \
-sample-name ${BASE} \
-‐stand_emit_conf 20.0 \
-O ${basedir}gvcfs_rna/${BASE}_haplotypes.g.vcf" >> ${OUT}
qsub ${OUT}

done

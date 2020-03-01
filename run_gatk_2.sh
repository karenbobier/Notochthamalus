#PBS -S /bin/bash
#PBS -q batch
#PBS -N noto_gakt2
#PBS -l nodes=1:ppn=1
#PBS -l walltime=6:00:00:00
#PBS -l mem=50gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_gatk2.out.$PBS_JOBID
#PBS -e $HOME/noto_gatk2.err.$PBS_JOBID

#set base directory and move there
basedir="/scratch/keb27269/noto/last/"
#mkdir $basedir
cd $basedir

#load programs
module load SAMtools/1.9-foss-2016b
module load  picard/2.4.1-Java-1.8.0_144
module load Python/3.5.2-foss-2016b
#location of GATK module
GATK_module="GATK/4.0.3.0-Java-1.8.0_144"

#create a .dict file for cds reference
#java -Xmx20g -classpath "/usr/local/apps/eb/picard/2.4.1-Java-1.8.0_144" -jar  \
#/usr/local/apps/eb/picard/2.4.1-Java-1.8.0_144/picard.jar CreateSequenceDictionary \
#       R="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.fasta" \
#       O="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.dict"


#set path to reference genome (noto transcritome cds file)
ref_genome="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.fasta"

################################################################################
#use gatk haplotype caller
#this creates a script and submits a job for each sample
################################################################################

for file in ${basedir}/*_removedDuplicates.bam
do
FBASE=$(basename $file _removedDuplicates.bam)
BASE=${FBASE%_removedDuplicates.bam}
OUT="${BASE}_gatk2.sh"
echo "#!/bin/bash" >> ${OUT}
echo "#PBS -N ${BASE}_gatk2" >> ${OUT}
echo "#PBS -l walltime=72:00:00" >> ${OUT}
echo "#PBS -l nodes=1:ppn=1:HIGHMEM" >> ${OUT}
echo "#PBS -q highmem_q" >> ${OUT}
echo "#PBS -l mem=200gb" >> ${OUT}
echo "" >> ${OUT}
echo "module load ${GATK_module}" >> ${OUT}
echo "" >> ${OUT}
echo "time gatk HaplotypeCaller \
-R ${ref_genome} \
-ERC GVCF \
-I ${raw_data}/${BASE}_removedDuplicates.bam \
-ploidy 2 \
-O ${output_directory}/${BASE}_haplotypes.g.vcf" >> ${OUT}
qsub ${OUT}

done

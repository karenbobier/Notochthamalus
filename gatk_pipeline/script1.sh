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

#This script will Generate a SAM file containing aligned reads from fastq sequencing files

#set path to reference genome (noto transcritome cds file)
ref_genome="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds.fasta"
#bwa index ${ref_genome}

#readgroup info format
#@RG\tID:group1\tSM:sample1\tPL:illumina\tLB:lib1\tPU:unit1
#mkdir ${basedir}/aligned_reads

for file in ${basedir}/dna_reads/*_R1_001.fastq
do
FBASE=$(basename $file _R1_001.fastq)
BASE=${FBASE%_R1_001.fastq}
read_group="@RG\tID:${BASE}\tSM:${BASE}\tPL:illumina\tLB:${BASE}"
bwa mem -M -t 6 -R ${read_group} ${ref_genome} ${basedir}/dna_reads/${BASE}_R1_001.fastq ${basedir}/dna_reads/${BASE}_R2_001.fastq > ${basedir}/aligned_reads/${BASE}_aligned_reads.sam

done

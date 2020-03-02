Arg29#PBS -S /bin/bash
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
module load SAMtools/1.9-foss-2016b
module load Python/3.5.2-foss-2016b
#location of picard module
picard_module=  "picard/2.4.1-Java-1.8.0_144"
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

# # rename files
# mv Arg10*R1_001_val_1.fq ARG10_R1_001.fastq
# mv Arg10*R2_001_val_2.fq ARG10_R2_001.fastq
# mv Arg18*R1_001_val_1.fq ARG18_R1_001.fastq
# mv Arg18*R2_001_val_2.fq ARG18_R2_001.fastq
# mv Arg19*R1_001_val_1.fq ARG19_R1_001.fastq
# mv Arg19*R2_001_val_2.fq ARG19_R2_001.fastq
# mv Arg21*R1_001_val_1.fq ARG21_R1_001.fastq
# mv Arg21*R2_001_val_2.fq ARG21_R2_001.fastq
# mv Arg25*R1_001_val_1.fq ARG25_R1_001.fastq
# mv Arg25*R2_001_val_2.fq ARG25_R2_001.fastq
# mv Arg27*R1_001_val_1.fq ARG27_R1_001.fastq
# mv Arg27*R2_001_val_2.fq ARG27_R2_001.fastq
# mv Arg29*R1_001_val_1.fq ARG29_R1_001.fastq
# mv Arg29*R2_001_val_2.fq ARG29_R2_001.fastq
# mv NAri4*R1_001_val_1.fq ARI4_R1_001.fastq
# mv NAri4*R2_001_val_2.fq ARI4_R2_001.fastq
# mv NAri6*R1_001_val_1.fq ARI6_R1_001.fastq
# mv NAri6*R2_001_val_2.fq ARI6_R2_001.fastq
# mv Ari12*R1_001_val_1.fq ARI12_R1_001.fastq
# mv Ari12*R2_001_val_2.fq ARI12_R2_001.fastq
# mv NAri10*R1_001_val_1.fq ARI10_R1_001.fastq
# mv NAri10*R2_001_val_2.fq ARI10_R2_001.fastq
# mv NAR111*R1_001_val_1.fq ARI11_R1_001.fastq
# mv NAR111*R2_001_val_2.fq ARI11_R2_001.fastq
# mv NotoV2_S1_L001_R1_001.fastq ARI102_R1_001.fastq
# mv NotoV2_S1_L001_R2_001.fastq ARI102_R2_001.fastq


######################################################################################
create a uBAM file
######################################################################################
mkdir ${basedir}/ubams

for file in ${basedir}/dna_reads/*_R1_001.fastq

do

FBASE=$(basename $file _R1_001.fastq)
BASE=${FBASE%_R1_001.fastq}
java -Xmx20g -classpath "/usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144" -jar  \
/usr/local/apps/eb/picard/2.16.0-Java-1.8.0_144/picard.jar FastqToSam \
    FASTQ=${basedir}/dna_reads/${BASE}_R1_001.fastq \
    FASTQ2=${basedir}/dna_reads/${BASE}_R2_001.fastq  \
    OUTPUT=${basedir}/ubams/${BASE}_fastqtosam.bam \
    READ_GROUP_NAME=${BASE} \
    SAMPLE_NAME=${BASE} \
    LIBRARY_NAME=Noto \
    PLATFORM=illumina

done

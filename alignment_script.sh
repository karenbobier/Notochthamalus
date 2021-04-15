#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_aln_to_semibal
#PBS -l nodes=1:ppn=6
#PBS -l walltime=2:00:00:00
#PBS -l mem=200gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_aln_to_semibal.out.$PBS_JOBID
#PBS -e $HOME/noto_aln_to_semibal.err.$PBS_JOBID

#set base directory and move there
basedir="/scratch/keb27269/"
#mkdir $basedir
cd $basedir

#location of BWA module
bwa_module="BWA/0.7.15-foss-2016b"
module load ${bwa_module}


#mkdir ${basedir}Semibalanus_genome/aligned_reads
#set path to reference genome (noto transcritome cds file)
ref_genome="/scratch/keb27269/Semibalanus_genome/GCA_014673585.1_Sbal3.1_genomic.fna"
bwa index ${ref_genome}

read_group="@RG\tID:${BASE}\tSM:${BASE}\tPL:illumina\tLB:${BASE}"
bwa mem -M -t 6 -R ${read_group} \
${ref_genome} ${basedir}noto/dna_reads/Arg21_ATGTCA_L008_R1_001_val_1.fq \
${basedir}noto/dna_reads/Arg21_ATGTCA_L008_R2_001_val_2.fq \
> ${basedir}Semibalanus_genome/aligned_reads/ARG21_aligned_reads.sam

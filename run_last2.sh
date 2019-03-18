#PBS -S /bin/bash
#PBS -q batch
#PBS -N last2_noto
#PBS -l nodes=1:ppn=1
#PBS -l walltime=10:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m ae
#PBS -o $HOME/last2.out.$PBS_JOBID
#PBS -e $HOME/last2.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/"
#mkdir $basedir
cd $basedir

module load LAST/956-foss-2016b
#module load LAST/959-foss-2018a
module load SAMtools/1.9-foss-2016b

samtools view -bt filtered_Trinity.fasta.fai last/ARI4.sam > last/ARI4.bam
samtools sort last/ARI4.bam last/sortARI4

samtools view -bt filtered_Trinity.fasta.fai last/ARI6.sam > last/ARI6.bam
samtools sort last/ARI6.bam last/sortARI6

samtools view -bt filtered_Trinity.fasta.fai last/ARI10.sam > last/ARI10.bam
samtools sort last/ARI10.bam last/sortARI10

samtools view -bt filtered_Trinity.fasta.fai last/ARI11.sam > last/ARI11.bam
samtools sort last/ARI11.bam last/sortARI11

samtools view -bt filtered_Trinity.fasta.fai last/ARI12.sam > last/ARI12.bam
samtools sort last/ARI12.bam last/sortARI12

samtools view -bt filtered_Trinity.fasta.fai last/ARG10.sam > last/ARG10.bam
samtools sort last/ARG10.bam last/sortARG10

samtools view -bt filtered_Trinity.fasta.fai last/ARG18.sam > last/ARG18.bam
samtools sort last/ARG18.bam last/sortARG18

samtools view -bt filtered_Trinity.fasta.fai last/ARG19.sam > last/ARG19.bam
samtools sort last/ARG19.bam last/sortARG19

samtools view -bt filtered_Trinity.fasta.fai last/ARG21.sam > last/ARG21.bam
samtools sort last/ARG21.bam last/sortARG21

samtools view -bt filtered_Trinity.fasta.fai last/ARG25.sam > last/ARG25.bam
samtools sort last/ARG21.bam last/sortARG25

samtools view -bt filtered_Trinity.fasta.fai last/ARG27.sam > last/ARG27.bam
samtools sort last/ARG27.bam last/sortARG27

samtools view -bt filtered_Trinity.fasta.fai last/ARG29.sam >last/ARG29.bam
samtools sort last/ARG29.bam last/sortARG29

samtools view -bt filtered_Trinity.fasta.fai last/ARI102.sam > last/ARI102.bam
samtools sort last/ARI102.bam last/sortARI102

samtools view -bt filtered_Trinity.fasta.fai last/ARI103.sam > last/ARI103.bam
samtools sort last/ARI103.bam last/sortARI103

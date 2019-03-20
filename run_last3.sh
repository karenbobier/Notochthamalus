#PBS -S /bin/bash
#PBS -q batch
#PBS -N last3_noto
#PBS -l nodes=1:ppn=1
#PBS -l walltime=7:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/last3.out.$PBS_JOBID
#PBS -e $HOME/last3.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/last/"
#mkdir $basedir
cd $basedir

module load LAST/956-foss-2016b
#module load LAST/959-foss-2018a
module load SAMtools/1.9-foss-2016b

mkdir /scratch/keb27269/noto/last/consensus/

samtools mpileup -uf filtered_Trinity.fasta sortARI4.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI4.fq

samtools mpileup -uf filtered_Trinity.fasta sortARI6.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI6.fq

samtools mpileup -uf filtered_Trinity.fasta sortARI10.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI10.fq

samtools mpileup -uf filtered_Trinity.fasta sortARI11.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI11.fq

samtools mpileup -uf filtered_Trinity.fasta sortARI12.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI12.fq

samtools mpileup -uf filtered_Trinity.fasta sortARG10.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG10.fq

samtools mpileup -uf filtered_Trinity.fasta sortARG18.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG18.fq

samtools mpileup -uf filtered_Trinity.fasta sortARG19.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG19.fq

samtools mpileup -uf filtered_Trinity.fasta sortARG21.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG21.fq

samtools mpileup -uf filtered_Trinity.fasta sortARG25.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG25.fq

samtools mpileup -uf filtered_Trinity.fasta sortARG27.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG27.fq

samtools mpileup -uf filtered_Trinity.fasta sortARG29.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG29.fq

samtools mpileup -uf filtered_Trinity.fasta sortARI102.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI102.fq

#samtools mpileup -uf filtered_Trinity.fasta sortARI103.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI103.fq

#PBS -S /bin/bash
#PBS -q batch
#PBS -N last3_noto
#PBS -l nodes=1:ppn=1
#PBS -l walltime=4:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/last3.out.$PBS_JOBID
#PBS -e $HOME/last3.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/last/"
#mkdir $basedir
cd $basedir

#module load LAST/956-foss-2016b
module load LAST/959-foss-2018a
#module load SAMtools/1.6-foss-2016b
module load SAMtools/1.9-foss-2016b
module load BCFtools/1.9-foss-2016b

mkdir /scratch/keb27269/noto/last/multiallelic/

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARI4.bam | bcftools call -m | vcfutils.pl vcf2fq > multiallelic/ARI4.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARI6.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI6.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARI10.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI10.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARI11.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI11.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARI12.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI12.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARG10.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG10.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARG18.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG18.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARG19.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG19.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARG21.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG21.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARG25.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG25.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARG27.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG27.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARG29.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARG29.fq

samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARI102.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI102.fq

#samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARI103.bam | bcftools call -c | vcfutils.pl vcf2fq > consensus/ARI103.fq

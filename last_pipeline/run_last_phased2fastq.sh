#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N last3_noto
#PBS -l nodes=1:ppn=3
#PBS -l walltime=6:00:00:00
#PBS -l mem=200gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/last_phase2fasta.out.$PBS_JOBID
#PBS -e $HOME/last_phase2fasta.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/last/"
#mkdir $basedir
cd $basedir

#module load LAST/956-foss-2016b
module load LAST/959-foss-2018a
#module load SAMtools/1.6-foss-2016b
module load SAMtools/1.9-foss-2016b
module load BCFtools/1.9-foss-2016b
module load VCFtools/0.1.15-foss-2016b-Perl-5.24.1

NAMES="ARI4
ARI6
ARI10
ARI11
ARI12
ARG10
ARG18
ARG19
ARG21
ARG25
ARG27
ARG29
ARI102
"
for i in $NAMES
do
samtools sort  phased/phased$i.0.bam -o phased/phased$i.0.sorted.bam 
samtools sort  phased/phased$i.1.bam -o phased/phased$i.1.sorted.bam
done

for i in $NAMES
do
samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phased$i.0.sorted.bam | bcftools call -c | vcfutils.pl vcf2fq > haplotypes/$i.0.fq
samtools mpileup -uf /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phased$i.1.sorted.bam | bcftools call -c | vcfutils.pl vcf2fq > haplotypes/$i.1.fq
done

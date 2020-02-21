#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N last3_noto
#PBS -l nodes=1:ppn=3
#PBS -l walltime=6:00:00:00
#PBS -l mem=200gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/last_phase.out.$PBS_JOBID
#PBS -e $HOME/last_phase.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/last/"
#mkdir $basedir
cd $basedir

#module load LAST/956-foss-2016b
module load LAST/959-foss-2018a
#module load SAMtools/1.6-foss-2016b
module load SAMtools/1.9-foss-2016b
module load BCFtools/1.9-foss-2016b
module load VCFtools/0.1.15-foss-2016b-Perl-5.24.1


#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI4.0.bam  phased/phasedARI4.1.bam | bcftools call -m -o ./multiallelic/outARI4.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI6.0.bam  phased/phasedARI6.1.bam | bcftools call -m -o ./multiallelic/outARI6.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI10.0.bam  phased/phasedARI10.1.bam | bcftools call -m -o ./multiallelic/outARI10.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI11.0.bam  phased/phasedARI11.1.bam | bcftools call -m -o ./multiallelic/outARI11.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI12.0.bam  phased/phasedARI12.1.bam | bcftools call -m -o ./multiallelic/outARI12.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG10.0.bam  phased/phasedARG10.1.bam | bcftools call -m -o ./multiallelic/outARG10.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG18.0.bam  phased/phasedARG18.1.bam | bcftools call -m -o ./multiallelic/outARG18.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG19.0.bam  phased/phasedARG19.1.bam | bcftools call -m -o ./multiallelic/outARG19.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG21.0.bam  phased/phasedARG21.1.bam | bcftools call -m -o ./multiallelic/outARG21.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG25.0.bam  phased/phasedARG25.1.bam | bcftools call -m -o ./multiallelic/outARG25.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG27.0.bam  phased/phasedARG27.1.bam | bcftools call -m -o ./multiallelic/outARG27.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG29.0.bam  phased/phasedARG29.1.bam | bcftools call -m -o ./multiallelic/outARG29.vcf -O v
#bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI102.0.bam  phased/phasedARI102.1.bam | bcftools call -m -o ./multiallelic/outARI102.vcf -O v

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

#need to index before running merge
#for i in $NAMES
#do
#bgzip multiallelic/out$i.vcf
#tabix multiallelic/out$i.vcf.gz
#done
#merge all individual.vcf files into one vcf
#vcf-merge multiallelic/*.vcf.gz |  bgzip -c > all.phased.raw.vcf.gz

bcftools filter -s LowQual -e '%QUAL<20 || DP>100' all.phased.raw.vcf.gz |bgzip -c > all.phased.flt.vcf.gz

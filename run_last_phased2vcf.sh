#PBS -S /bin/bash
#PBS -q batch
#PBS -N last3_noto
#PBS -l nodes=1:ppn=1
#PBS -l walltime=4:00:00:00
#PBS -l mem=100gb
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


bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI4.0.bam  phased/phasedARI4.1.bam | bcftools call -m -o ./multiallelic/outARI4.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI6.0.bam  phased/phasedARI6.1.bam | bcftools call -m -o ./multiallelic/outARI6.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI10.0.bam  phased/phasedARI10.1.bam | bcftools call -m -o ./multiallelic/outARI10.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI11.0.bam  phased/phasedARI11.1.bam | bcftools call -m -o ./multiallelic/outARI11.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI12.0.bam  phased/phasedARI12.1.bam | bcftools call -m -o ./multiallelic/outARI12.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG10.0.bam  phased/phasedARG10.1.bam | bcftools call -m -o ./multiallelic/outARG10.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG18.0.bam  phased/phasedARG18.1.bam | bcftools call -m -o ./multiallelic/outARG18.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARIG19.0.bam  phased/phasedARG19.1.bam | bcftools call -m -o ./multiallelic/outARIG19.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG21.0.bam  phased/phasedARG21.1.bam | bcftools call -m -o ./multiallelic/outARG21.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG25.0.bam  phased/phasedARIG25.1.bam | bcftools call -m -o ./multiallelic/outARG25.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG27.0.bam  phased/phasedARG27.1.bam | bcftools call -m -o ./multiallelic/outARG27.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARG29.0.bam  phased/phasedARG29.1.bam | bcftools call -m -o ./multiallelic/outARG29.vcf -O v
bcftools mpileup -Ou -f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds phased/phasedARI102.0.bam  phased/phasedARI102.1.bam | bcftools call -m -o ./multiallelic/outARI102.vcf -O v

#merge all individual.vcf files into one vcf
vcf-merge multiallelic/*.vcf >  all.raw.vcf

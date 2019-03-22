#PBS -S /bin/bash
#PBS -q batch
#PBS -N last2_noto
#PBS -l nodes=1:ppn=1
#PBS -l walltime=4:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/last2.out.$PBS_JOBID
#PBS -e $HOME/last2.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/last/"
#mkdir $basedir
cd $basedir

module load LAST/956-foss-2016b
#module load LAST/959-foss-2018a
module load SAMtools/1.9-foss-2016b

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI4.sam > ARI4.bam
samtools sort ARI4.bam -o sortARI4.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI6.sam > ARI6.bam
samtools sort ARI6.bam -o sortARI6.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI10.sam > ARI10.bam
samtools sort ARI10.bam -o sortARI10.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI11.sam > ARI11.bam
samtools sort ARI11.bam -o sortARI11.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI12.sam > ARI12.bam
samtools sort ARI12.bam -o sortARI12.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG10.sam > ARG10.bam
samtools sort ARG10.bam -o sortARG10.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG18.sam > ARG18.bam
samtools sort ARG18.bam -o sortARG18.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG19.sam > ARG19.bam
samtools sort ARG19.bam -o sortARG19.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG21.sam > ARG21.bam
samtools sort ARG21.bam -o sortARG21.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG25.sam > ARG25.bam
samtools sort ARG21.bam -o sortARG25.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG27.sam > ARG27.bam
samtools sort ARG27.bam -o sortARG27.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG29.sam >ARG29.bam
samtools sort ARG29.bam -o sortARG29.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI102.sam > ARI102.bam
samtools sort ARI102.bam -o sortARI102.bam

#samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI103.sam > ARI103.bam
#samtools sort ARI103.bam -o sortARI103.bam

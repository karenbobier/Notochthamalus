#PBS -S /bin/bash
#PBS -q batch
#PBS -N last2_noto
#PBS -l nodes=1:ppn=1
#PBS -l walltime=7:00:00:00
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

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI4.sam > ARI4.bam
samtools sort ARI4.bam sortARI4

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI6.sam > ARI6.bam
samtools sort ARI6.bam sortARI6

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI10.sam > ARI10.bam
samtools sort ARI10.bam sortARI10

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI11.sam > ARI11.bam
samtools sort ARI11.bam sortARI11

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI12.sam > ARI12.bam
samtools sort ARI12.bam sortARI12

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG10.sam > ARG10.bam
samtools sort ARG10.bam sortARG10

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG18.sam > ARG18.bam
samtools sort ARG18.bam sortARG18

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG19.sam > ARG19.bam
samtools sort ARG19.bam sortARG19

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG21.sam > ARG21.bam
samtools sort ARG21.bam sortARG21

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG25.sam > ARG25.bam
samtools sort ARG21.bam sortARG25

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG27.sam > ARG27.bam
samtools sort ARG27.bam sortARG27

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARG29.sam >ARG29.bam
samtools sort ARG29.bam sortARG29

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI102.sam > ARI102.bam
samtools sort ARI102.bam sortARI102

samtools view -bt  /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta.fai ARI103.sam > ARI103.bam
samtools sort ARI103.bam sortARI103

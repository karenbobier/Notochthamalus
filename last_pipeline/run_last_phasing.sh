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

#mkdir /scratch/keb27269/noto/last/phased/
#mkdir /scratch/keb27269/noto/last/multiallelic/

#samtools phase /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.cds sortARI4.bam > phased/ARI4_phased.fq

samtools phase sortARI4.bam -b phasedARI4

samtools phase sortARI6.bam -b phasedARI6

samtools phase sortARI10.bam -b phasedARI10

samtools phase sortARI11.bam -b phasedARI11

samtools phase sortARI12.bam -b phasedARI12

samtools phase sortARG10.bam -b phasedARG10

samtools phase sortARG18.bam -b phasedARG18

samtools phase sortARG19.bam -b phasedARG19

samtools phase sortARG21.bam -b phasedARG21

samtools phase sortARG25.bam -b phasedARG25

samtools phase sortARG27.bam -b phasedARG27

samtools phase sortARG29.bam -b phasedARG29

samtools phase sortARI102.bam -b phasedARI102

mv phasedA* phased

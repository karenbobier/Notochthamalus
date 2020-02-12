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

samtools phase sortARI4.bam -b /phased/phasedARI4

samtools phase sortARI6.bam -b /phased/phasedARI6

samtools phase sortARI10.bam -b /phased/phasedARI10

samtools phase sortARI11.bam -b /phased/phasedARI11

samtools phase sortARI12.bam -b /phased/phasedARI12

samtools phase sortARG10.bam -b /phased/phasedARG10

samtools phase sortARG18.bam -b /phased/phasedARG18

samtools phase sortARG19.bam -b /phased/phasedARG19

samtools phase sortARG21.bam -b /phased/phasedARG21

samtools phase sortARG25.bam -b /phased/phasedARG25

samtools phase sortARG27.bam -b /phased/phasedARG27

samtools phase sortARG29.bam -b /phased/phasedARG29

samtools phase sortARI102.bam -b /phased/phasedARI102

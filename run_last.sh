#PBS -S /bin/bash
#PBS -q batch
#PBS -N last_noto
#PBS -l nodes=1:ppn=16
#PBS -l walltime=30:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m ae
#PBS -o $HOME/last.out.$PBS_JOBID
#PBS -e $HOME/last.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/"
#mkdir $basedir
cd $basedir

module load LAST/959-foss-2018a
module load SAMtools/1.9-foss-2016b

#Turn transcriptome into database (the reference to map against)
lastdb -uNEAR transdb /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta
samtools faidx /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta

#aligns reads of each partial genome to the transdb database (which are the transcripts in filtered_Trinity.fasta), and converts the maf output into a sam file
#lastal -Q1 -e120 transdb /path/to/reads.fq  | maf-convert sam > last/samplename.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arica4*.fq | maf-convert sam > last/ARI4.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arica6*.fq | maf-convert sam > last/ARI6.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arica10*.fq | maf-convert sam > last/ARI10.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arica11*.fq | maf-convert sam > last/ARI11.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arica12*.fq | maf-convert sam > last/ARI12.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arg10*.fq | maf-convert sam > last/ARG10.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arg18*.fq | maf-convert sam > last/ARG18.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arg19*.fq | maf-convert sam > last/ARG19.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arg21*.fq | maf-convert sam > last/ARG21.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arg25*.fq | maf-convert sam > last/ARG25.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arg27*.fq | maf-convert sam > last/ARG27.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/Arg29*.fq | maf-convert sam > last/ARG29.sam

lastal -Q1 -e120 transdb /work/jpwlab/noto/dna_reads/BaseCalls/NotoV2_S1_L001_*.fastq | maf-convert sam > last/ARI102.sam

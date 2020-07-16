#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N noto_revcom
#PBS -l nodes=1:ppn=1
#PBS -l walltime=20:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_revcom.out.$PBS_JOBID
#PBS -e $HOME/noto_revcom.err.$PBS_JOBID

#Convert files for minus strand seqs
basedir="/scratch/keb27269/noto/snpGenie_test"
cd $basedir
file="seq_ids_minus_strand2.txt"
#file="seq_ids_minus_strand_test.txt"
sequence_ids=$(cat ${file})
vcf2revcom="/home/keb27269/projects/SNPGenie/vcf2revcom.pl"
gtf2revcom="/home/keb27269/projects/SNPGenie/gtf2revcom.pl"
fasta2revcom="/home/keb27269/projects/SNPGenie/fasta2revcom.pl"
module load seqkit/0.10.2_conda

#mkdir $basedir/rev_com_fastas
for ID in $sequence_ids
  do
    seqkit fx2tab -l $basedir/reference_fastas_ORP/noto_1.5.ORP_$ID.fasta |cut -f 4 > $basedir/seq_length.txt
    seq_length=$(cat $basedir/seq_length.txt)

    cd $basedir/rev_com_fastas
    $vcf2revcom $basedir/variants_rna_edit/$ID*.vcf $seq_length
    $gtf2revcom $basedir/gff_files/$ID*.gtf $seq_length
    $fasta2revcom $basedir/reference_fastas_ORP/noto_1.5.ORP_$ID.fasta
done

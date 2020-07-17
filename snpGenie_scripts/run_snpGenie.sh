#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N noto_split_vcf
#PBS -l nodes=1:ppn=1
#PBS -l walltime=20:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_split_vcf.out.$PBS_JOBID
#PBS -e $HOME/noto_split_vcf.err.$PBS_JOBID


basedir="/scratch/keb27269/noto/snpGenie_test"
#mkdir $basedir
cd $basedir

#file="test_seq_ids.txt"
# file="cds_seq_ids.txt"
# sequence_ids=$(cat ${file})
# snp_genie_path="/home/keb27269/projects/SNPGenie/snpgenie.pl"
# #use cds fasta as reference
# # for ID in $sequence_ids
# #   do
# #     $snp_genie_path --vcfformat=1 --snpreport="./variants/$ID.vcf" --fastafile="./reference_fasta/noto_1.5.ORP_$ID.fasta" --gtffile="./gff_files/$ID.gtf"  --outdir="./snp_genie_outputs/$ID/"
# # done
# #use original ORP assembly as reference
# for ID in $sequence_ids
#   do
#     $snp_genie_path --vcfformat=1 --snpreport="./variants_rna_edit/$ID.vcf" --fastafile="./reference_fastas_ORP/noto_1.5.ORP_$ID.fasta" --gtffile="./gff_files/$ID.gtf"  --outdir="./snp_genie_outputs_ORP/$ID/"
# done

#run for reverse complement of minus strand seqs
file="seq_ids_minus_strand2.txt"
sequence_ids=$(cat ${file})
snp_genie_path="/home/keb27269/projects/SNPGenie/snpgenie.pl"
for ID in $sequence_ids
  do
    $snp_genie_path --vcfformat=1 --snpreport="./variants_rna_edit/$ID_revcom.vcf" --fastafile="./rev_com_fastas/noto_1.5.ORP_$ID_revcom.fasta" --gtffile="./gff_files/$ID_revcom.gtf"  --outdir="$basedir/snp_genie_outputs_ORP/rev_com/$ID/"
done

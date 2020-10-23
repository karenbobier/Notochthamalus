#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N noto_snpgenie_pop
#PBS -l nodes=1:ppn=16
#PBS -l walltime=00:03:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_snpgenie_pop.out.$PBS_JOBID
#PBS -e $HOME/noto_snpgenie_pop.err.$PBS_JOBID


basedir="/scratch/keb27269/noto/snpGenie_test"
#mkdir $basedir
cd $basedir

file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})
###############################################################################
#generate_seqs_from_VCF.py reference.fasta variants.vcf <number of seqs>
module load Python/3.5.2-foss-2016b
module load Biopython/1.68-foss-2016b-Python-3.5.2
# for ID in $sequence_ids
#   do
#     /home/keb27269/projects/EBT/generate_seqs_from_VCF.py ${basedir}/reference_fastas_ORP/noto_1.5.ORP_${ID}.fasta $basedir/variants_Arica/${ID}.Arica.vcf 12
#     /home/keb27269/projects/EBT/generate_seqs_from_VCF.py ${basedir}/reference_fastas_ORP/noto_1.5.ORP_${ID}.fasta $basedir/variants_Argentina/${ID}.Argentina.vcf 14
# done
#run for snp files
for ID in $sequence_ids
  do
    /home/keb27269/projects/EBT/generate_seqs_from_VCF.py ${basedir}/reference_fastas_ORP/noto_1.5.ORP_${ID}.fasta $basedir/variants_Arica_snps/${ID}_Arica_snps.vcf 12
    /home/keb27269/projects/EBT/generate_seqs_from_VCF.py ${basedir}/reference_fastas_ORP/noto_1.5.ORP_${ID}.fasta $basedir/variants_Argentina_snps/${ID}_Argentina_snps.vcf 14
done

# #move fasta files
for ID in $sequence_ids
  do
    mkdir $basedir/fastas_by_pop/${ID}_diploid
    mv $basedir/variants_Arica/${ID}.Arica_nSeqs12.fasta $basedir/fastas_by_pop/${ID}_diploid/
    mv $basedir/variants_Argentina/${ID}.Argentina_nSeqs14.fasta $basedir/fastas_by_pop/${ID}_diploid/
done
#
# ############################################################################
# module load  Parallel-ForkManager/1.19-foss-2016b-Perl-5.24.1
#
# file="cds_seq_ids.txt"
# sequence_ids=$(cat ${file})
#
# #run snpgenie by populations
# #--gtf_file=<CDS_annotations>.gtf --num_bootstraps=10000 --procs_per_node=16
#
# for ID in $sequence_ids
#   do
#     cd $basedir/fastas_by_pop/${ID}/
#     /home/keb27269/projects/SNPGenie/snpgenie_between_group.pl --gtf_file="${basedir}/gff_files/${ID}.new.gtf" --num_bootstraps=10000 --procs_per_node=16
# done

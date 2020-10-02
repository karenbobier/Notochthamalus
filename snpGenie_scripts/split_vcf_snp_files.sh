#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_split_snp_vcf
#PBS -l nodes=1:ppn=1
#PBS -l walltime=24:00:00
#PBS -l mem=50gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_split_snp_vcf.out.$PBS_JOBID
#PBS -e $HOME/noto_split_snp_vcf.err.$PBS_JOBID

#set base directory and move there
basedir="/scratch/keb27269/noto/snpGenie_test"
#mkdir $basedir
cd $basedir

file_plus="seq_ids_plus_strand2.txt"
sequence_ids_plus=$(cat ${file_plus})
for ID in $sequence_ids_plus
  do
  grep $ID noto_all_invd.rna_edit_output_snps_only.recode.vcf > ./temp_variants/$ID.temp.snp.vcf
  cat vcf_head.txt ./temp_variants/$ID.temp.snp.vcf > ./variants_snps_forward/$ID.snp.vcf
done

file_minus="seq_ids_minus_strand2.txt"
sequence_ids_minus=$(cat ${file_minus})
for ID in $sequence_ids_minus
  do
  grep $ID noto_all_invd.rna_edit_output_snps_only.recode.vcf > ./temp_variants/$ID.temp.minus.snp.vcf
  cat vcf_head.txt ./temp_variants/$ID.temp.minus.snp.vcf > ./variants_snps_revcom/$ID.snp.vcf
done

#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N noto_split_vcf
#PBS -l nodes=1:ppn=1
#PBS -l walltime=2:00:00:00
#PBS -l mem=50gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_split_vcf.out.$PBS_JOBID
#PBS -e $HOME/noto_split_vcf.err.$PBS_JOBID


basedir="/scratch/keb27269/noto/snpGenie_test"
#mkdir $basedir
cd $basedir

#split vcf files
file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})
#create headers
# head -n 35 noto_all_invd.rna.vcf > vcf_head.txt
# grep '#CHROM' noto_all_invd.rna.vcf >> vcf_head.txt


# for ID in $sequence_ids
#   do
#   grep $ID noto_all_invd.rna.vcf > ./temp_variants/$ID.temp.vcf
#   cat vcf_head.txt ./temp_variants/$ID.temp.vcf > ./variants/$ID.vcf
# done

for ID in $sequence_ids
  do
  grep $ID noto_all_invd.rna_edit.vcf > ./temp_variants/$ID.temp.vcf
  cat vcf_head.txt ./temp_variants/$ID.temp.vcf > ./variants_rna_edit/$ID.vcf
done

#for snp vcfs by population
file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})

for ID in $sequence_ids
  do
  #grep $ID noto_all_invd.rna_edit_Arica_snps-only.vcf.recode.vcf > ./temp_variants/$ID.temp.snp.Arica.vcf
  cat vcf_Arica_head.txt ./temp_variants/${ID}.temp.snp.Arica.vcf > ./variants_Arica_snps/${ID}_Arica_snps.vcf
done

for ID in $sequence_ids
  do
  grep $ID noto_all_invd.rna_edit_Argentina_snps-only.vcf.recode.vcf > ./temp_variants/$ID.temp.snp.Argentina.vcf
  cat vcf_head.txt ./temp_variants/${ID}.temp.snp.Argentina.vcf > ./variants_Argentina_snps/${ID}_Argentina_snps.vcf
done

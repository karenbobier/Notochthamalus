file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})
#echo $sequence_ids

for ID in $sequence_ids
  do
  grep  $ID noto.cds.gff3 > ./gff_files/$ID.gff3
done

#test seq ids
# TRINITY_DN9999_c0_g1_i3
# TRINITY_DN9999_c0_g1_i7

#############################################################################
#split vcf files
file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})
#create headers
# head -n 35 noto_all_invd.rna.vcf > vcf_head.txt
# grep '#CHROM' noto_all_invd.rna.vcf >> vcf_head.txt

for ID in $sequence_ids
  do
  grep $ID noto_all_invd.rna.vcf > ./temp_variants/$ID.temp.vcf
  cat vcf_head.txt ./temp_variants/$ID.temp.vcf > ./variants/$ID.vcf
done

##################################################################
#convert gff3 to gtffile
module load gffread/0.9.12-foss-2016b
##gffread -E annotation.gff -T -o- | more
#file="test_seq_ids.txt"
file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})
for ID in $sequence_ids
  do
    sed -i 's/$/\tgene_id "ORF1"/' ./gff_files/$ID.gff3
    gffread -E ./gff_files/$ID.gff3 -T -o- > ./gff_files/$ID.gtf
done

################################################################
#test SNPGenie
file="test_seq_ids.txt"
#file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})
snp_genie_path="/home/keb27269/projects/SNPGenie/snpgenie.pl"

for ID in $sequence_ids
  do
    $snp_genie_path --vcfformat=1 --snpreport="./variants/$ID.vcf" --fastafile="./reference_fasta/noto_1.5.ORP_$ID.fasta" --gtffile="./gff_files/$ID.gtf"  --outdir="./snp_genie_outputs/$ID/"
done


# error :  CDS annotation(s) does not have a gene_id

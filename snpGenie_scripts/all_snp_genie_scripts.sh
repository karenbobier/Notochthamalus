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
################################################################################
#split fasta into individual sequences
/home/keb27269/projects/EBT/split_fasta.pl noto_1.5.ORP.fasta
################################################################################
#split seqs by strand
#grep '+' gff_files/*.gtf | cut -f 1 | cut -d '/' -f 2|cut -d ':' -f 2 > seq_ids_plus_strand.txt
#grep '-' gff_files/*.gtf | cut -f 1 | cut -d '/' -f 2|cut -d ':' -f 2  > seq_ids_minus_strand.txt
grep '-' gff_files/*.gtf | cut -f 1 | cut -d '/' -f 2|cut -d ':' -f 2 | cut -d '.' -f1 > seq_ids_minus_strand2.txt
grep '+' gff_files/*.gtf | cut -f 1 | cut -d '/' -f 2|cut -d ':' -f 2 | cut -d '.' -f1 > seq_ids_plus_strand2.txt

file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})
for ID in ${sequence_ids}
  do
    grep '+' gff_files/$ID.gtf | cut -f 1 | cut -d '/' -f 2|cut -d ':' -f 2 | cut -d '.' -f1 >> seq_ids_plus_strand2.txt
done
################################################################################

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

file_plus="seq_ids_plus_strand2.txt"
sequence_ids_plus=$(cat ${file})
for ID in $sequence_ids_plus
  do
  grep $ID noto_all_invd.rna_edit_output_snps_only.recode.vcf > ./temp_variants/$ID.temp.snp.vcf
  cat vcf_head.txt ./temp_variants/$ID.temp.snp.vcf > ./variants_snps_forward/$ID.snp.vcf
done

file_plus="seq_ids_minus_strand2.txt"
sequence_ids_minus=$(cat ${file})
for ID in $sequence_ids_minus
  do
  grep $ID noto_all_invd.rna_edit_output_snps_only.recode.vcf > ./temp_variants/$ID.temp.minus.snp.vcf
  cat vcf_head.txt ./temp_variants/$ID.temp.minus.snp.vcf > ./variants_snps_revcom/$ID.snp.vcf
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
    seqkit fx2tab -l $basedir/reference_fastas_ORP/noto_1.5.ORP_${ID}.fasta |cut -f 4 > $basedir/seq_length.txt
    seq_length=$(cat $basedir/seq_length.txt)

    cd $basedir/rev_com_fastas
    $vcf2revcom $basedir/variants_rna_edit/${ID}*.vcf $seq_length
    $gtf2revcom $basedir/gff_files/${ID}*.gtf $seq_length
    $fasta2revcom $basedir/reference_fastas_ORP/noto_1.5.ORP_${ID}.fasta
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

#####################################################################################
#by population
##############################################################################
#convert vcf to fasta
#split vcf by transcript
basedir="/scratch/keb27269/noto/snpGenie_test"
file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})
#create headers
#for Arica
# head -n 35 noto_all_invd.rna_edit_Arica.vcf > vcf_Arica_head.txt
# grep '#CHROM' noto_all_invd.rna_edit_Arica.vcf >> vcf_Arica_head.txt
#for Argentina
# head -n 35 noto_all_invd.rna_edit_Argentina.vcf > vcf_Argentina_head.txt
# grep '#CHROM' noto_all_invd.rna_edit_Argentina.vcf >> vcf_Argentina_head.txt

# #Arica
# for ID in $sequence_ids
#   do
#   grep $ID noto_all_invd.rna_edit_Arica.vcf > ./temp_variants/$ID.temp.Arica.vcf
#   cat vcf_Arica_head.txt ./temp_variants/$ID.temp.Arica.vcf > ./variants_Arica/$ID.Arica.vcf
# done
# #Argentina
# for ID in $sequence_ids
#   do
#   grep $ID noto_all_invd.rna_edit_Argentina.vcf > ./temp_variants/$ID.temp.Argentina.vcf
#   cat vcf_Argentina_head.txt ./temp_variants/$ID.temp.Argentina.vcf > ./variants_Argentina/$ID.Argentina.vcf
# done
#use snp only vcf instead of whole vcf.
#Arica
for ID in $sequence_ids
  do
  grep $ID noto_all_invd.rna_edit_Arica_snps-only.vcf.recode.vcf > ./temp_variants/$ID.temp.Arica.vcf
  cat vcf_Arica_head.txt ./temp_variants/$ID.temp.Arica.vcf > ./variants_Arica_snps/$ID.Arica.vcf
done
#Argentina
for ID in $sequence_ids
  do
  grep $ID noto_all_invd.rna_edit_Argentina_snps-only.vcf.recode.vcf > ./temp_variants/$ID.temp.Argentina.vcf
  cat vcf_Argentina_head.txt ./temp_variants/$ID.temp.Argentina.vcf > ./variants_Argentina_snps/$ID.Argentina.vcf
done






#generate_seqs_from_VCF.py reference.fasta variants.vcf <number of seqs>
module load Python/3.5.2-foss-2016b
module load Biopython/1.68-foss-2016b-Python-3.5.2
for ID in $sequence_ids
  do
    /home/keb27269/projects/EBT/generate_seqs_from_VCF.py ${basedir}/reference_fastas_ORP/noto_1.5.ORP_${ID}.fasta $basedir/variants_Arica/${ID}.Arica.vcf 6
    /home/keb27269/projects/EBT/generate_seqs_from_VCF.py ${basedir}/reference_fastas_ORP/noto_1.5.ORP_${ID}.fasta $basedir/variants_Argentina/${ID}.Argentina.vcf 7
done

#move fasta files
for ID in $sequence_ids
  do
    mkdir $basedir/fastas_by_pop/${ID}
    mv $basedir/variants_Arica/${ID}.Arica_nSeqs6.fasta $basedir/fastas_by_pop/${ID}/
    mv $basedir/variants_Argentina/${ID}.Argentina_nSeqs7.fasta $basedir/fastas_by_pop/${ID}/
done

################################################################################

#edit gtf files to change gene id from "ORF1" to actual gene id
for ID in $sequence_ids
 do
 sed "s/ORF1/${ID}/g" $basedir/gff_files/${ID}.gtf > $basedir/gff_files/${ID}.new.gtf
done


#run snpgenie by populations
#--gtf_file=<CDS_annotations>.gtf --num_bootstraps=10000 --procs_per_node=16

module load  Parallel-ForkManager/1.19-foss-2016b-Perl-5.24.1
for ID in $sequence_ids
  do
    cd $basedir/fastas_by_pop/${ID}/
    /home/keb27269/projects/SNPGenie/snpgenie_between_group.pl --gtf_file="${basedir}/gff_files/${ID}.new.gtf" --num_bootstraps=10000 --procs_per_node=16
done

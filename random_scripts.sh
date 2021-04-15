

#Scripts from http://www.sixthresearcher.com/list-of-helpful-linux-commands-to-process-fastq-files-from-ngs-experiments/
#Sometimes we will be interested in extracting a small part of the big file to
#use it for testing our processing methods,
# ex. the first 1000 sequences (4000 lines):
#> zcat reads.fq.gz | head -4000 > test_reads.fq
#> zcat reads.fq.gz | head -4000 | gzip > test_reads.fq.gz

#grab first twenty million reads from lane 1 rna sequencings
zcat Noto2_USR18000676L_HCCTGDMXX_L1_1.fq.gz | head -80000000 | gzip > Noto_20M_L1_r1.fq.gz
zcat Noto2_USR18000676L_HCCTGDMXX_L1_2.fq.gz | head -80000000 | gzip > Noto_20M_L1_r2.fq.gz





#replace ids from files, rename has two columns, column 1 is old names, column2 is new names.
while read a b
do
sed -i 's/$a/$b/g' Master
done < Rename

while read a b
do
sed  "s/$a/$b/g" product_results_unique_copy.csv > product_results_unique_fullids.csv
done < fasta_headers_sorted.csv


#filter vcf
module load VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0
vcftools --vcf noto_all_invd.rna_edit_output_snps_only.recode.vcf --min-alleles 2 --max-alleles 2 --max-missing 1 --recode --recode-INFO-all --out biallelic_snps.vcf # allow only biallelic snps, 100% genotyped

vcftools --vcf noto_all_invd.rna_edit_output_snps_only.recode.vcf --min-alleles 2 --max-alleles 2  --recode --recode-INFO-all --out biallelic_snps_2.vcf # allow only biallelic snps,
vcftools --vcf noto_all_invd.rna_edit_output_snps_only.recode.vcf --max-alleles 2  --recode --recode-INFO-all --out biallelic_snps_3.vcf # allow only snps with 2 or fewer alleles

vcftools --vcf noto_all_invd.rna_edit_output_snps_only.recode.vcf --max-alleles 2  --recode --recode-INFO-all --max-missing 0.5 --out biallelic_snps_4.vcf # allow only biallelic snps, 50% genotyped

# #by pop to get only fixed sites
# bcftools view -Ou -s sample1,sample2 file.vcf | bcftools query -f %INFO/AC\t%INFO/AN\n
# bcftools view -Ou -s ARG10,ARG18,ARG19,ARG21,ARG25,ARG27,ARG29 noto_all_invd.rna_edit_output_snps_only.recode.vcf| bcftools query -f %INFO/AC\t%INFO/AN\n > snps_arg.vcf
# vcftools --vcf  noto_all_invd.rna_edit_Argentina_snps-only.vcf.recode.vc --max-alleles 1  --recode --recode-INFO-all --out fixed_snps_ARG.vcf # allow only snps with 1 allele

#cat reference_genome.fa | vcf-consensus -s SC9 -H 1 name.vcf.gz > SC9_ref.fa
module load SAMtools/0.1.19-foss-2019b
module load HTSlib/1.9-GCC-8.3.0
cat  noto_fixed_snps_fst1.vcf | bgzip -c >  noto_fixed_snps_fst1.vcf.gz
tabix  noto_fixed_snps_fst1.vcf.gz
module load Perl/5.30.0-GCCcore-8.3.0
module load BioPerl/1.7.2-GCCcore-8.3.0
perl /home/keb27269/projects/dnmt_git/Fasta_fetchseqs.pl -in ../noto_1.5.ORP.fasta.transdecoder.mRNA.fasta -m seqs_fixed_ids.txt -v -file -out fst1_seqs.fasta
module load VCFtools/0.1.16-GCC-8.3.0-Perl-5.30.0
cat fst1_seqs.fasta | vcf-consensus -s ARG_Consensus -H 1 noto_fixed_snps_fst1.vcf.gz > fst1_ARG_consensus.fasta
cat fst1_ARG_consensus.fasta |cut -d " " -f1 > fst1_ARG_consensus_trimmedid.fasta
sed "/^>/ s/$/_ARG/" fst1_ARG_consensus_trimmedid.fasta > ARG_fst1.fasta
cat fst1_ARI_consensus.fasta |cut -d " " -f1 > fst1_ARI_consensus_trimmedid.fasta
sed "/^>/ s/$/_ARI/" fst1_ARI_consensus_trimmedid.fasta > ARI_fst1.fasta

#add id to vcf files
#bcftools annotate --set-id +'%CHROM:%POS:%REF:%FIRST_ALT' input.vcf
module load BCFtools/1.9-foss-2016b
bcftools annotate --set-id +'%CHROM:%POS:%REF:%FIRST_ALT' biallelic_snps_3.vcf.recode.copy.vcf

join -t "," < (sort file1) < (sort file2)

join -t , -e NA -1 1 -2 1  fst_and_tajimasD.csv  pop_sum_and_prod_results.csv > noto_sumstats2.csv

######

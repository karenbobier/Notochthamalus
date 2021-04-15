
basedir="/scratch/keb27269/noto/"
#mkdir $basedir
cd $basedir



module load VCF-kit/0.1.6-foss-2016b-Python-2.7.14

vk tajima 10000 --sliding  noto_all_invd.rna_edit_Argentina_snps-only.vcf.recode.vcf > ajimasD_sliding_Argentina.out
vk tajima 10000 10000  noto_all_invd.rna_edit_Argentina_snps-only.vcf.recode.vcf > tajimasD_Argentina_10000.out

vk tajima 10000 10000  noto_all_invd.rna_edit_Arica_snps-only.vcf.recode.vcf > tajimasD_Arica_10000.out

vk tajima 10000 10000 noto_all_invd.rna_edit_output_snps_only.recode.vcf > tajimasD_all_10000.out



module load pgdspider/2.1.1.5
#this had not worked

java -Xmx1024m -Xms512m -jar /usr/local/apps/gb/pgdspider/2.1.1.5/PGDSpider2.jar -inputfile ../noto_all_invd.rna_edit_output_snps_only.recode.vcf -inputformat VCF -outputfile ./noto_all_snps.genepop -outputformat GENEPOP -spid pgd_spider_vcf_to_genepop.spid


VCF="/scratch/keb27269/noto/noto_all_invd.rna_edit_output_snps_only.recode.vcf"
module load BCFtools/1.9-foss-2016b
bcftools query -l $VCF
# extract sample names for Arica
bcftools query -l $VCF | grep "ARI" > arica
# extract sample names for Argentina
bcftools query -l $VCF | grep "ARG" > argen

module load VCFtools/0.1.15-foss-2016b-Perl-5.24.1

#calculate fst per snp
vcftools --gzvcf ${VCF} --recode --recode-INFO-all \
--weir-fst-pop arica \
--weir-fst-pop argen \
--out ./arica_argen

#calculate fst over 10000 bp window
vcftools --gzvcf ${VCF} \
--weir-fst-pop arica --fst-window-size 10000 \
--weir-fst-pop argen --fst-window-size 10000 \
--out ./arica_argen_10000

vcftools --vcf ${VCF} \
--weir-fst-pop arica --fst-window-size 10000 \
--weir-fst-pop argen --fst-window-size 10000 \
--out ./arica_argen_10000_test

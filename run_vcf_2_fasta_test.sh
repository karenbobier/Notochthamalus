

#run vcf2fasta.pl

module load Perl/5.30.0-GCCcore-8.3.0
#perl vcf2fasta.pl -f <fasta-ref> -v <vcf-file> -g <gff-file> -e <gff-feature> [ --ref ] [ --phased ]
perl /home/keb27269/projects/vcf2fasta/vcf2fasta.pl  \
-f /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.mRNA.fasta \
-v /scratch/keb27269/noto/biallelic_snps_3.vcf.ids.vcf \
-g /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.gff3 \
-e CDS > noto_snps.fasta

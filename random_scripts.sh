

#Scripts from http://www.sixthresearcher.com/list-of-helpful-linux-commands-to-process-fastq-files-from-ngs-experiments/
#Sometimes we will be interested in extracting a small part of the big file to
#use it for testing our processing methods,
# ex. the first 1000 sequences (4000 lines):
#> zcat reads.fq.gz | head -4000 > test_reads.fq
#> zcat reads.fq.gz | head -4000 | gzip > test_reads.fq.gz

#grab first twenty million reads from lane 1 rna sequencings
zcat Noto2_USR18000676L_HCCTGDMXX_L1_1.fq.gz | head -80000000 | gzip > Noto_20M_L1_r1.fq.gz
zcat Noto2_USR18000676L_HCCTGDMXX_L1_2.fq.gz | head -80000000 | gzip > Noto_20M_L1_r2.fq.gz

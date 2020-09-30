

module load BLAST+/2.9.0-foss-2018a-Python-2.7.14
module load BLAST+/2.7.1-foss-2016b-Python-2.7.14
#blastn -num_threads 4 -db <database file> -query <queary file>
databasefile="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.mRNA.fasta"
queryfile="/scratch/keb27269/noto/isomerase_stuff/semibalanus_MK955540.fasta"

sed 's/_length_.*|//g' < noto_1.5.ORP.fasta.transdecoder.mRNA.fasta >new_mRNA.fasta

database1="/scratch/keb27269/noto/isomerase_stuff/new_mRNA.fasta"

#make blast db
makeblastdb -in $database1 -input_type fasta -dbtype nucl \
-title mRNA_for_blastall -parse_seqids -out mRNA_for_blastall
#run nucleotide blast
blastn -db mRNA_for_blastall -query $queryfile -evalue 1E-5 > blast.out

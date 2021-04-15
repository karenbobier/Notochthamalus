

module load BLAST+/2.9.0-foss-2018a-Python-2.7.14

#blastn -num_threads 4 -db <database file> -query <queary file>
databasefile="/scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder.mRNA.fasta"
queryfile="/scratch/keb27269/noto/isomerase_stuff/semibalanus_MK955540.fasta"
queryfile="/scratch/keb27269/noto/isomerase_stuff/Semibalanus_MK953005.1.fasta"

sed 's/_length_.*|//g' < noto_1.5.ORP.fasta.transdecoder.mRNA.fasta >new_mRNA.fasta

database1="/scratch/keb27269/noto/isomerase_stuff/new_mRNA.fasta"

#make blast db
makeblastdb -in $database1 -input_type fasta -dbtype nucl \
-title mRNA_for_blastall -parse_seqids -out mRNA_for_blastall
#run nucleotide blast
blastn -db mRNA_for_blastall -query $queryfile -evalue 1E-5 \
-outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
-max_target_seqs 1 -max_hsps 1 -out blast_mpi.out

queryfile="semibalanus_metabolic_genes.fasta"
blastn -db mRNA_for_blastall -query $queryfile -evalue 1E-5 \
-outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
-max_target_seqs 10 -max_hsps 1 -out blast_metabolic.out

queryfile="allozymes_protein.fasta"
tblastn -db mRNA_for_blastall -query $queryfile -evalue 1E-5 \
-outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
-max_target_seqs 10 -max_hsps 1 -out blast_allozyme_protein.out

#make allozyme proteins the database and blast raw fastq reads
module load BBMap/38.73-foss-2018b-Java-1.8.0_202
gunzip Noto_read_1.fq.gz
reformat.sh in=/scratch/keb27269/noto/rna_reads/Noto_read_1.fq out=Noto_read_1.fasta
queryfile="/scratch/keb27269/noto/isomerase_stuff/allozymes_protein.fasta"
databasefile="/scratch/keb27269/noto/rna_reads/Noto_read_1.fasta"
#make blast db
makeblastdb -in $databasefile -input_type fasta -dbtype nucl \
-title noto_rna_read1_db -parse_seqids -out noto_rna_read1_db
tblastn -db noto_rna_read1_db -query $queryfile -evalue 1E-5 \
-outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
-max_target_seqs 10 -max_hsps 1 -out blastx_allozyme_protein_rna_reads.out

#blast metabolic gene list to Noto mRNA transcriptome files
queryfile="/scratch/keb27269/noto/metabolic_genes/metabolic_all.fasta"
tblastn -db /scratch/keb27269/noto/isomerase_stuff/mRNA_for_blastall -query $queryfile -evalue 1E-5 \
-outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qcovs" \
-max_target_seqs 5 -max_hsps 1 -out blast_metabolic_all.out

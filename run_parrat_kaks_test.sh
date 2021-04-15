#run parat and kaks calculator


module load MAFFT/7.470-GCC-8.3.0-with-extensions
module load Perl/5.30.0-GCCcore-8.3.0
ml foss/2019b
export PATH=$PATH:${HOME}/apps/KaKs_Caclulator/1.2/bin
export PATH=$PATH:${HOME}/apps/ParaAT1.0

/home/keb27269/apps/ParaAT1.0/ParaAT.pl -h seq.names.txt -n cds.fasta \
-a pep.fasta -o parrat_output_for_kaks -p proc.txt -m mafft -kaks -f axt
#some of these dont have values for kaks, try again with all end stop codons removed  to see if they are the problem

/home/keb27269/apps/ParaAT1.0/ParaAT.pl -h seq.names.txt -n cds_nostops.fasta \
-a pep.fasta -o parrat_output_for_kaks_no_stopcodons -p proc.txt -m mafft -kaks -f axt

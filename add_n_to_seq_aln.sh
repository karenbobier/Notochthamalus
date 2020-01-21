#run the following code in folder containing fastas with sequences on a single line not wrapped. Must copy code to terminal one line at a time for loop to work...

for FILE in *.fasta;
do
awk '/^>/ {if (seqlen){print seqlen}; print ;seqlen=0;next; } { seqlen = seqlen +length($0)}END{print seqlen}' $FILE | awk 'NR%2==0'|sort -nr |head -1 > lengths.txt
for test in $(cat lengths.txt)
do
awk '$1~">"{print $0}$1!~">"{tmp="";for(i=1;i<'$test'-length($0)+1;i++){tmp=tmp"n"};print $0""tmp}' $FILE > ../fasta_edit/$FILE
done
done


##########################################################################################################
#code to do these things seperately
#get the length of longest sequence in a fasta file
#for on file
awk '/^>/ {if (seqlen){print seqlen}; print ;seqlen=0;next; } { seqlen = seqlen +length($0)}END{print seqlen}' TRINITY_DN0_c104_g1_i3\|m.169582.fasta | awk 'NR%2==0'|sort -nr |head -1

#for all fasta files in a directory
for FILE in *.fasta; do awk '/^>/ {if (seqlen){print seqlen}; print ;seqlen=0;next; } { seqlen = seqlen +length($0)}END{print seqlen}' $FILE | awk 'NR%2==0'|sort -nr |head -1 ; done


# add "n" to end of seqs to make all seqs in fasta same length

awk '$1~">"{print $0}$1!~">"{tmp="";for(i=1;i<150-length($0)+1;i++){tmp=tmp"N"};print $0""tmp}' TRINITY_DN0_c104_g1_i3_m.169582.fasta.fa > output.fasta
awk '$1~">"{print $0}$1!~">"{tmp="";for(i=1;i<150-length($0)+1;i++){tmp=tmp"n"};print $0""tmp}' TRINITY_DN0_c104_g1_i3_m.169582.fasta.fa

for FILE in *.fasta;
do
awk '$1~">"{print $0}$1!~">"{tmp="";for(i=1;i<150-length($0)+1;i++){tmp=tmp"n"};print $0""tmp}' $FILE
done

#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N noto_snpgenie
#PBS -l nodes=1:ppn=1
#PBS -l walltime=20:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_snpgenie.out.$PBS_JOBID
#PBS -e $HOME/noto_snpgenie.err.$PBS_JOBID


basedir="/scratch/keb27269/noto/snpGenie_test"
#mkdir $basedir
cd $basedir

#get population results

#make file header
cat ${basedir}/snp_genie_outputs_ORP/J9344521/product_results.txt  |awk "NR==1" > ${basedir}/noto_all_product_results.txt
#for plus strand seqs

file="seq_ids_plus_strand.txt"
sequence_ids=$(cat ${file})
for ID in $sequence_ids
  do
    cat ${basedir}/snp_genie_outputs_ORP/${ID}/product_results.txt  |awk "NR==2" >> noto_all_product_results.txt
done

#run for reverse complement of minus strand seqs
file="seq_ids_minus_strand2.txt"
sequence_ids=$(cat ${file})
for ID in $sequence_ids
do
  cat ${basedir}/snp_genie_outputs_ORP/rev_com/${ID}/product_results.txt  |awk "NR==2" >> noto_all_product_results.txt
done

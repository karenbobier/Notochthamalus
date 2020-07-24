#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N noto_snpgenie_pop
#PBS -l nodes=1:ppn=16
#PBS -l walltime=20:00:00:00
#PBS -l mem=100gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_snpgenie_pop.out.$PBS_JOBID
#PBS -e $HOME/noto_snpgenie_pop.err.$PBS_JOBID


basedir="/scratch/keb27269/noto/snpGenie_test"
#mkdir $basedir
cd $basedir

module load  Parallel-ForkManager/1.19-foss-2016b-Perl-5.24.1

file="cds_seq_ids.txt"
sequence_ids=$(cat ${file})

#run snpgenie by populations
#--gtf_file=<CDS_annotations>.gtf --num_bootstraps=10000 --procs_per_node=16

for ID in $sequence_ids
  do
    cd $basedir/fastas_by_pop/${ID}/
    /home/keb27269/projects/SNPGenie/snpgenie_between_group.pl --gtf_file="${basedir}/gff_files/${ID}.new.gtf" --num_bootstraps=10000 --procs_per_node=16
done

#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N 2_transdecoder_noto
#PBS -l nodes=1:ppn=20
#PBS -l walltime=3:00:00:00
#PBS -l mem=200gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/2_transdecoder_noto.out.$PBS_JOBID
#PBS -e $HOME/2_transdecoder_noto.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/"
#mkdir $basedir
cd $basedir

module load TransDecoder/2.1.0-foss-2016b-Perl-5.24.1
module load HMMER/3.1b2-foss-2016b
module load BLAST+/2.7.1-foss-2016b-Python-2.7.14

#blastp -query /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder_dir/longest_orfs.pep  \
#    -db uniprot_sprot.fasta  -max_target_seqs 1 \
#    -outfmt 6 -evalue 1e-5 -num_threads 20 > blastp.outfmt6

#hmmpress /scratch/keb27269/noto/Pfam-A.hmm

hmmscan --cpu 20 --domtblout pfam.domtblout /scratch/keb27269/noto/Pfam-A.hmm /scratch/keb27269/noto/noto_1.5.ORP.fasta.transdecoder_dir/longest_orfs.pep

TransDecoder.Predict -t /scratch/keb27269/noto/gacrctest2/assemblies/noto_1.5.ORP.fasta --retain_pfam_hits pfam.domtblout --retain_blastp_hits blastp.outfmt6

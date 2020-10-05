#PBS -S /bin/bash
#PBS -q batch
#PBS -N interproscan
#PBS -l nodes=1:ppn=6
#PBS -l walltime=3:00:00:00
#PBS -l mem=50gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/iprscan.out.$PBS_JOBID
#PBS -e $HOME/iprscan.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/"
cd $basedir
module load EMBOSS/6.6.0-foss-2016b

transeq -frame 1 -table 0 -clean -sequence ${basedir}noto_1.5.ORP.fasta.transdecoder.mRNA.fasta -outseq ${basedir}noto_1.5.ORP.fasta.transdecoder.pep.fasta

module unload EMBOSS/6.6.0-foss-2016b

module load InterProScan/5.41-78.0-foss-2018a
module load Java/11.0.2

#run InterProScan
time sh interproscan.sh -cpu 6 -appl PfamA -t p -i ${basedir}noto_1.5.ORP.fasta.transdecoder.pep.fasta \
goterms -iprlookup -f tsv -o $basedir/interproscan/noto_pep_interproscan_out.tsv


time sh interproscan.sh -appl PfamA -t n -i ${basedir}noto_1.5.ORP.fasta.transdecoder.mRNA.fasta \
goterms -iprlookup -f tsv -o $basedir/interproscan/noto_interproscan_out.tsv

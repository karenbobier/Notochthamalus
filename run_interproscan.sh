#PBS -S /bin/bash
#PBS -q batch
#PBS -N interproscan
#PBS -l nodes=1:ppn=6
#PBS -l walltime=3:00:00:00
#PBS -l mem=80gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/iprscan.out.$PBS_JOBID
#PBS -e $HOME/iprscan.err.$PBS_JOBID

basedir="/scratch/keb27269/noto/"
cd $basedir

#module load InterProScan/5.41-78.0-foss-2018a
module load InterProScan/5.44-79.0-foss-2019b
module load Java/11.0.2


#run InterProScan
time sh interproscan.sh -cpu 6 -appl PfamA -t p -i ${basedir}noto_1.5.ORP.fasta.transdecoder.pep \
goterms -iprlookup -f tsv -o ${basedir}interproscan/noto_pep_interproscan_out.tsv


# time sh interproscan.sh -appl PfamA -t n -i ${basedir}noto_1.5.ORP.fasta.transdecoder.mRNA.fasta \
# goterms -iprlookup -f tsv -o $basedir/interproscan/noto_interproscan_out.tsv

#write results for specific domains to new files
#PF01238 PMI_typeI - Phosphomannose isomerase type I
grep 'PF01238' noto_pep_interproscan_out.tsv  > noto_pep_ipr_PF01238.tsv
#TetR_C_28 (PF17937)
#AraC_binding (PF02311)
#ScsC_N (PF18312)

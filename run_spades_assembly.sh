#PBS -S /bin/bash
#PBS -q  highmem_q
#PBS -N noto_spades_semibal
#PBS -l nodes=1:ppn=16
#PBS -l walltime=5:00:00:00
#PBS -l mem=250gb
#PBS -M keb27269@uga.edu
#PBS -m abe
#PBS -o $HOME/noto_spades_semibal.out.$PBS_JOBID
#PBS -e $HOME/noto_spades_semibal.err.$PBS_JOBID

#set base directory and move there
basedir="/scratch/keb27269/"
#mkdir $basedir
cd $basedir
#
# #set path to Semibalanus reference genome (noto transcritome cds file)
# ref_genome="/scratch/keb27269/noto/GCA_014673585.1_Sbal3.1_genomic.fna"
# mkdir ${basedir}Semibalanus/spades_assembly
# module load spades/3.12.0-k_245
#
# python /usr/local/apps/gb/spades/3.12.0-k_245/bin/spades.py \
# -1 ${basedir}noto/dna_reads/Arg21_ATGTCA_L008_R1_001_val_1.fq \
# -2 ${basedir}noto/dna_reads/Arg21_ATGTCA_L008_R2_001_val_2.fq \
# -o ${basedir}Notochthamalus/spades_assembly/ \
# -t 16 -m 250



#generate quast report
moudle load Python/3.5.2-foss-2016b
module load QUAST/4.6.3-foss-2016b-Python-3.5.2
ref_genome="/scratch/keb27269/Semibalanus_genome/GCA_014673585.1_Sbal3.1_genomic.fna"
# quast.py -o ${basedir}Notochthamalus/quast_out -R ${ref_genome}  ${basedir}Notochthamalus/spades_assembly/scaffolds.fasta
# #Reference genome is fragmented. You may consider rerunning QUAST using --fragmented option. QUAST will try to detect misassemblies caused by the fragmentation and mark them fake (will be excluded from # misassemblies).
# quast.py -o ${basedir}Notochthamalus/quast_fragmented_out --fragmented -R ${ref_genome}  ${basedir}Notochthamalus/spades_assembly/scaffolds.fasta
# #make mummer plots
module load MUMmer/3.23-foss-2016b
#for spades
nucmer -o $ref_genome ${basedir}Notochthamalus/spades_assembly/scaffolds.fasta -p ${basedir}Notochthamalus/outputfile_spades

delta-filter -1 ${basedir}Notochthamalus/outputfile_spades.delta > ${basedir}Notochthamalus/outputfile_spades.1delta

mummerplot --size large -fat --color -f --png ${basedir}Notochthamalus/outputfile_spades.1delta -p ${basedir}Notochthamalus/outputfile_spades

#generate Prokka genome annotations for assembly using semibalanus as reference
# need to run the following line once for each
#prokka /path/to/assembly --outdir prokka_directory
#for spades
module load prokka/1.13-foss-2016b-BioPerl-1.7.1
prokka ${basedir}Notochthamalus/spades_assembly/scaffolds.fasta --outdir ${basedir}Notochthamalus/prokka_spades_directory

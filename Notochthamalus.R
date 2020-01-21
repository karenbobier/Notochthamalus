library(ape)
setwd("/Volumes/2TBa/ORP_Notochthamalus_transcriptome/seqs_aligned_to_cds/consensus")

#load all hits as fasta file
all <- read.dna("Noto_allindv_cds.fasta", format="fasta")
head(labels(all))
names <- labels(all)

#make a data frame ("info") with seperate indv ("ID") and tracscript ID ("trans")
#transcript names are as transcriptID-indvID
trans <- sub(pattern="-.*", "\\1", names)
head(trans)
ID <- gsub("^.*?AR", "AR", names)
head(ID)
info <- data.frame(trans, ID)
head(info)
table(info$ID)
#Christine's old results
# ARG10  ARG18  ARG19  ARG21  ARG25  ARG27  ARG29  ARI10 ARI102 ARI103  ARI11  ARI12   ARI2   ARI4   ARI6
# 54876  59933  61146  62352  62352  61468  57457  63942  62283  75119  49807  49224  37812  56407  56433
#Karen's new results with ORP transcriptome
# ARG10  ARG18  ARG19  ARG21  ARG25  ARG27  ARG29  ARI10 ARI102  ARI11  ARI12   ARI4   ARI6
# 225710 243890 246757 249838 249838 247397 235248 252530 250357 207427 203603 233660 233607
#Karens new results with annotated cds
#ARG10  ARG18  ARG19  ARG21  ARG25  ARG27  ARG29  ARI10 ARI102  ARI11  ARI12   ARI4   ARI6
#52498  56591  57152  58001  58001  57369  54729  58488  58376  50071  48207  54568  54583

transtimes <- table(info$trans) #how often is each transcript represented
hist(transtimes, breaks=10)
hist(transtimes, breaks=13, xlim=c(0,14), ylim=c(0,50000), xlab="# of individulas", ylab="# of transcripts")
##old notes
# interesting bimodal pattern: ca 7000 genes (or is it transcript isoforms?) are only present in one ind.,
# then fewer numbers that are present in some ind., and ca 30,000 are present in all transcripts
#new notes for unannotated transcriptome
# most transcripts ~175000 present in all samples
#for annotated cds
# most transcripts ~45000 present in all samples

# how many transcripts are represented by all ind.?
length(match(names(transtimes[transtimes > 12]), trans))
# 29871
#for unannotated new transcriptome
#174374
#for annotated cds
# 43021

# make new DNAbin object only containing seq of transcripts present in all ind.
match13 <- all[trans%in%names(transtimes[transtimes > 12])] # these are seq. for transcripts that are present in all ind.
head(match13)

# subset trans and ID to the same
trans13 <- trans[trans%in%names(transtimes[transtimes > 12])]
ID13 <- ID[trans%in%names(transtimes[transtimes > 12])]

# rename sequences: remove transcript ID part (remains present in trans13)
#library(phytools)
#match13.re <- rename.fasta(match13, ref=data.frame(labels(match13), ID13), fil = match13.re, prefix = NULL)
#labels(match13) <- ID13
# nothing worked

# split sequences up by transcript
matches <- split(match13, trans13)
head(matches)

# save sequences by transcript (15 seq per file)
setwd("/Volumes/2TBa/ORP_Notochthamalus_transcriptome/seqs_aligned_to_cds/fasta_by_transcript")

for (i in 1:length(matches)) {
  write.dna(matches[[i]], paste0(names(matches[i]),".fasta"), format="fasta")
}


# DONE
for (i in 1:length(matches)) {
  dnds(matches[[i]], code=1)
}

dnds(matches, code=1, codonstart=1)

# Commands for preparing sequencing data.
#1 Make a new folder named after the MiSeq run 

#MiSeq-Run0071
mkdir /ebio/abt6_projects9/microbiome_analysis/data/raw_seqDATA/MiSeq-Run084

#2 Find all the fastq.gz file paths in the raw data and create a link to it.
#Find the raw data fasta files, and for each one, convert to a symbolic link in the CRISPR raw data directory
cd /ebio/abt6_projects9/microbiome_analysis/data/raw_seqDATA/MiSeq-Run084
for i in $( find /ebio/abt6_sra/years/2017/08_07/ampliconsequencing | grep 'fastq\.gz' )
do 
echo $i
ln -s $i
done

#3 Merge all sequences to make the FLASH merged FASTQ
cd /ebio/abt6_projects9/microbiome_analysis/data/raw_seqDATA/MiSeq-Run084
for i in *_*_L001_R1_001.fastq.gz
do 
echo $i
qsub -N job"$i"T -o $(pwd)/out.txt -e $(pwd)/err.txt -V -cwd /ebio/abt6_projects7/bacterial_strain_analysis/code/MiSeqFLASH.sh $i
done

#Demultiplex and trim primers
cd /ebio/abt6_projects9/microbiome_analysis/data/raw_seqDATA/MiSeq-Run084/FLASHmerged
for i in *extendedFrags.fastq
do
qsub -N "$i" -o $(pwd)/out.txt -e $(pwd)/err.txt -V -cwd /ebio/abt6_projects7/bacterial_strain_analysis/code/MiSeqDemultiplexTrim515only.sh $i 
done

#simplify file names so the sample name is in the fasta file after quality filtering.
#should go from: H9_GGCGTTACA_L001_merged_001.fastq.gz.extendedFrags.fastq_515F1F3F5.fastq
#to: D7p799F1F3F5.fastq

rename 's/_L001_merged_001.fastq.gz.extendedFrags.fastq_//' *
rename 's/515/p515/' *
rename 's/_.........p515/p515/' *

#Quality filter
cd /ebio/abt6_projects9/microbiome_analysis/data/processed_DATA/MiSeq-Run084/FLASHmerged/FullyDemultiplexed
for i in *fastq
do
qsub -N "$i" -o $(pwd)/out.txt -e $(pwd)/err.txt -V -cwd /ebio/abt6_projects7/bacterial_strain_analysis/code/MiSeqQualityFilter.sh $i 
done

#combine all the FASTA files into one big file for each amplicon
#for 515
rm 515_blackblue_all.fasta
cd /ebio/abt6_projects9/microbiome_analysis/data/processed_DATA/MiSeq-Run084/FLASHmerged/FullyDemultiplexed
for i in *filtered.fa
do 
cat $i >> 515_blackblue_all.fasta
done

# Find unique read sequences and abundances
usearch=/ebio/abt6_projects7/bacterial_strain_analysis/code/usearch10
vsearch=/ebio/abt6_projects7/bacterial_strain_analysis/code/vsearch-2.4.3/vsearch-2.4.3-linux-x86_64/bin/vsearch
## $usearch -fastx_uniques 515_blackblue_all.fasta -sizeout -relabel Uniq -fastaout 515_blackblue_all_uniques.fa
nice -12 $vsearch --derep_fulllength 515_blackblue_all.fasta --output 515_blackblue_all_uniques.fa --sizein --sizeout --fasta_width 0 --minuniquesize 2

#cluster OTUS and filter chimeras
nice -12 $usearch -cluster_otus 515_blackblue_all_uniques.fa -otus 515_blackblue_all_otus.fa -relabel Otu
qsub -N "pp515" -o $(pwd)/out.txt -e $(pwd)/err.txt -V -cwd /ebio/abt6_projects7/bacterial_strain_analysis/code/makeOTUtable515.sh 



$vsearch -cluster_otus 799_all_uniques.fa -otus 799_all_otus.fa -relabel Otu

#find zOTUs
#USEARCH EXAMPLE: usearch -unoise3 uniques.fa -zotus zotus.fa -tabbedout unoise3.txt
nice -12 $usearch -unoise3 515_blackblue_all_uniques.fa -zotus 515_blackblue_all_zotus.fa -tabbedout 515_blackblue_all_unoise3.txt
sed -i -e 's/Zotu/Otu/g' 515_blackblue_all_zotus.fa

#cluster OTUs at 99% by Edgar method using zotus as input  
cd /ebio/abt6_projects9/microbiome_analysis/data/processed_DATA/MiSeq-Run084/FLASHmerged/FullyDemultiplexed/OTUs
usearch=/ebio/abt6_projects7/bacterial_strain_analysis/code/usearch10
#USEARCH EXAMPLE: usearch -otutab reads.fq -zotus zotus.fa -otutabout zotutab.txt -mapout zmap.txt
	#$usearch -sortbylength 515_blackblue_all_zotus.fa -fastaout 515_blackblue_all_zotus_sorted.fa -minseqlength 64             
	#nice -12 $usearch -cluster_smallmem 515_blackblue_all_zotus_sorted.fa -id 0.99 -centroids 515_blackblue_all_zotus99.fa
	#nice -12 $usearch -otutab 515_blackblue_all.fasta -otus 515_blackblue_all_zotus99.fa -otutabout 515_blackblue_all_otutab99_raw.txt
	nice -12 $usearch -otutab 515_blackblue_all.fasta -zotus 515_blackblue_all_zotus.fa -otutabout 515_blackblue_all_Zotutab_20181206.txt


#assign taxonomy by USEARCH
cd /ebio/abt6_projects9/microbiome_analysis/data/processed_DATA/MiSeq-Run084/FLASHmerged/FullyDemultiplexed/OTUs
refdb=/ebio/abt6_projects7/bacterial_strain_analysis/data/16S_db/RDP/rdp_16s_v16.udb
usearch=/ebio/abt6_projects7/bacterial_strain_analysis/code/usearch10
#nice -12 $usearch -sintax 515_blackblue_all_otus.fa -db $refdb -strand both -tabbedout 515_blackblue_all_otus.tax -sintax_cutoff 0.8
#nice -12 $usearch -sintax 515_blackblue_all_zotus.fa -db $refdb -strand both -tabbedout 515_blackblue_all_zotus.tax -sintax_cutoff 0.8
#nice -12 $usearch -sintax 515_blackblue_all_zotus99.fa -db $refdb -strand both -tabbedout 515_blackblue_all_zotus99.tax -sintax_cutoff 0.8
nice -12 $usearch -sintax 515_blackblue_all_zotus.fa -db $refdb -strand both -tabbedout 515_blackblue_all_zotus_20181207.tax -sintax_cutoff 0.8




u=/ebio/abt6_projects7/bacterial_strain_analysis/code/usearch8
v=/ebio/abt6_projects9/microbiome_analysis/data/software/vsearch-2.4.0/bin/vsearch

#relabel each FASTQ file and quality filter
for i in {1..96}
do
echo "$i"
$u -fastq_filter S"$i"_merged_REGEX.fastq -fastq_maxee 2.0 -fastqout S"$i"_filtered.fq -relabel S"$i". -log filter.log
done

#concatenate all relabeled FASTQ 
touch Anjar_all_seqs.FASTQ
for i in {1..96}
do
echo "$i"
cat S"$i"_filtered.fq >> Anjar_all_seqs.FASTQ
done

#convert FASTQ to FASTA
sed -n '1~4s/^@/>/p;2~4p' Anjar_all_seqs.FASTQ > Anjar_all_seqs.FASTA

# Dereplication
$v --derep_fulllength Anjar_all_seqs.FASTA --sizein -fasta_width 0 --sizeout --output derep.fa -minuniquesize 2

# Abundance sort and discard singletons
$v --sortbysize derep.fa --output sorted.fa --sizeout --minsize 2

# OTU clustering
#For 97% OTUs
#$v --cluster_fast sorted.fa --id 0.97 --centroids otus1.fa --uc clusters.uc
$u -cluster_otus sorted.fa -minsize 1 -otus otus.fa -relabel Otu -uparseout uniques.up -log cluster_otus.log

#Make UPARSE TAX database
cd /ebio/abt6_projects7/bacterial_strain_analysis/data/16S_db/utaxref/rdp_16s_trainset15/fasta/
$u -makeudb_utax refdb.fa -output 16s_ref.udb -report 16s_report.txt
$u -makeudb_utax contaminants.fa -output contaminants_ref.udb -report contaminants_report.txt

#assign taxonomy by USEARCH
usearch=/ebio/abt6_projects7/bacterial_strain_analysis/code/usearch10
refdb=/ebio/abt6_projects7/bacterial_strain_analysis/data/16S_db/RDP/rdp_16s_v16.udb
$usearch -utax otus.fa -db $refdb -strand both -fastaout otus_tax.fa

refdb=/ebio/abt6_projects7/bacterial_strain_analysis/data/16S_db/utaxref/rdp_16s_trainset15/fasta/contaminants_ref.udb 
$u -utax otus.fa -db $refdb -strand both -fastaout otus_contam.fa





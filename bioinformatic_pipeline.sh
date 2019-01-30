#!/bin/bash
export PATH=$PATH:/

genome=A_echinatior
# viral proteins were downloaded from NCBI (txid10239[Organism:exp])
# ant genomes were individually downloaded from NCBI

cutadapt -m 10000 -o ${genome}_genome_clipped.fasta ${genome}_genome.fasta
#discards reads in the genome shorter than 10,000 bp

makeblastdb -in ${genome}_genome_clipped.fasta -dbtype nucl -out ${genome}_genome_clipped_db
#makes specific ant genome into the database for the tblastn run

tblastn -db ${genome}_genome_clipped_db -query all_viruses.fasta -evalue 0.00000000000000000001 -outfmt 6 -out ${genome}_clipped_6.out &
# tblastn run with ant genome as the database and the viral proteins as query to find preliminary EVE hits

python order_hits.py ${genome}_clipped_6.out ${genome}_ordered_hits.txt
# extract scaffold and location of hit from blast output and order the hits found in the tblastn portion of the pipeline 

cat ${genome}_ordered_hits.txt > ${genome}.bed
#convert .txt into .bed for bedtools

sort -k1,1 -k2,2n ${genome}.bed > ${genome}_bed.sorted.bed
#sort hits in bed format

bedtools merge -i ${genome}_bed.sorted.bed -d 10 > ${genome}_bed_sorted_output.bed
#merge any hits which where separated by 10 or less basepairs 

sed -e 's/^\(>[^[:space:]]*\).*/\1/' ${genome}_genome_clipped.fasta > ${genome}_genome_mod.fasta
#makes the fasta file headers only the ID without description

samtools faidx ${genome}_genome_mod.fasta 
#convert specific ant genome to correct bedtools format

bedtools getfasta -fi ${genome}_genome_mod.fasta -bed ${genome}_bed_sorted_output.bed -fo ${genome}_hits.fasta
#this function extracts genome sequences from the specific ant genome based on the intervals defined by the EVE hits from the tblastn run

blastx -db ./nr -query ${genome}_hits.fasta -max_target_seqs 20 -evalue 0.001 -outfmt 5 -out ${genome}_blastx _mts20.xml &
# blastx hits against NCBI non-redundant protein database to validate viral origin of hit 

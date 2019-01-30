# Ant_Genomes_EVEs
This is the github page for code relating to the manuscript: "Assessing the diversity of endogenous viruses throughout ant genomes"

Please contact pflynn@uchicago.edu for more information


Bioinformatic_Pipeline.sh: 

This is the pipeline which takes the ant genome and provides raw hits 
Must download these programs to your computer: cutadapt (https://cutadapt.readthedocs.io/en/stable/guide.html) , BLAST (ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/), python3.7.2 (https://www.python.org/), and bedtools (https://bedtools.readthedocs.io/en/latest/).
From NCBI (https://www.ncbi.nlm.nih.gov/) must locally download: nr protein database, genomes you want to look at, and all viral proteins from BLAST runs.

order_hits.py: 

this is a script which must be downloaded if you are to use bioinformatic_pipeline.sh and the purpose is to extract scaffold and location of hit from blast output and order the hits found in the tblastn portion of the pipeline 

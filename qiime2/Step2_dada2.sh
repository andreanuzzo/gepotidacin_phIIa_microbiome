#!/bin/sh

#################################################################################
#                                       					#
# Filters paired-end sequences based on quality, merges dereplicates them   	#
# using DADA2 algorithm. Includes chimera removal               		#
#                                       					#
#################################################################################

# ----------------Load Modules--------------------
source activate qiime2-2018.8

# ----------------Housekeeping--------------------
echo -e "\n#Housekeeping"
rm -r features
mkdir features
cp data/demux-paired-end.qza features/dada2input.qza
cd features

# ----------------Commands------------------------
echo -e "\nExecutimng DADA2 dereplication"

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs dada2input.qza \
  --p-n-threads 8 \
  --p-trunc-len-f 150 \
  --p-trunc-len-r 149 \
  --o-table table.qza \
  --o-denoising-stats stats.qza \
  --o-representative-sequences rep-seqs.qza 

source deactivate

date

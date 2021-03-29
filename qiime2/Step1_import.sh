#!/bin/sh

#################################################################################
#                                                                               #
#                    import fastq.gz files into qiime2 artifact                 #
#                                                                               #
#################################################################################

# Note: this script assumes you have all fastqfiles in a folder called data/raw_data

echo -e "\n# ----------------Load Modules--------------------"
source activate qiime2-2018.8

echo -e "\n# ----------------Housekeeping---------------------"

cd data
rm -r demux*.q*

echo -e "# ----------------Commands------------------------\n"

echo -e "\n#Import Data in qiime2 artifact"

qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path raw_data \
  --input-format CasavaOneEightSingleLanePerSampleDirFmt \
  --output-path demux-paired-end.qza

echo -e "\n# Create Data Visuailizations"

qiime demux summarize \
  --i-data demux-paired-end.qza \
  --o-visualization demux-paired-end.qzv

echo -e "\n# Unload modules"
source deactivate

date

#!/bin/sh

#################################################################################
#                                                                               #
#     Assign taxonomy using a pre-trained scikit classifier version 0.19.1      #
#                                                                               #
#################################################################################

## Note: this assumes you have the Silva v.132 pre-trained classifier in the 
## selected folder. It can be downloaded from https://data.qiime2.org/2018.8/common/silva-132-99-515-806-nb-classifier.qza

# ----------------Load Modules--------------------
source activate qiime2-2018.8

# ----------------Housekeeping--------------------
cd features
rm taxonomy.qza
rm taxa-bar-plots.tsv
rm taxonomy.qzv

# ----------------Commands------------------------
echo -e "\nAssign taxonomy against SILVA 132 pretrained V4"
qiime feature-classifier classify-sklearn \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza \
  --i-classifier databases/silva-132-99-515-806-nb-classifier.qza

qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv 

# Unload modules:
source deactivate

date

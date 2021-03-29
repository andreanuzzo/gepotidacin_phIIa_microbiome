#!/bin/sh

# ----------------Load Modules--------------------
source activate qiime2-2019.4

# ----------------Housekeeping--------------------
rm -r biom
mkdir biom
cd features

# ------------------Commands----------------------

echo -e "\n#Remove Singletons"
qiime feature-table filter-features \
  --i-table table.qza \
  --p-min-frequency 2 \
  --o-filtered-table feature-frequency-filtered-table.qza

qiime feature-table filter-seqs \
  --i-data rep-seqs.qza \
  --i-table feature-frequency-filtered-table.qza \
  --p-no-exclude-ids \
  --o-filtered-data feature-frequency-filtered-rep-seqs.qza

echo -e "\n#Remove Mitochondria"
qiime taxa filter-table \
  --i-table feature-frequency-filtered-table.qza \
  --i-taxonomy taxonomy.qza \
  --p-exclude mitochondria,chloroplast \
  --o-filtered-table table_no_mit_chlo.qza

qiime feature-table filter-samples \
  --i-table table_no_mit_chlo.qza \
  --p-min-frequency 9500 \
  --o-filtered-table table-filtered.qza

qiime taxa filter-seqs \
  --i-sequences feature-frequency-filtered-rep-seqs.qza \
  --i-taxonomy taxonomy.qza \
  --p-exclude mitochondria,chloroplast \
  --o-filtered-sequences rep-seqs_filtered.qza

echo -e "\n#Build phylogenetic tree"
qiime alignment mafft \
  --i-sequences rep-seqs_filtered.qza \
  --p-n-threads $SLURM_NTASKS \
  --o-alignment aligned-rep-seqs-filtered.qza

qiime alignment mask \
  --i-alignment aligned-rep-seqs-filtered.qza \
  --o-masked-alignment masked-aligned-rep-seqs-filtered.qza

qiime phylogeny fasttree \
  --i-alignment masked-aligned-rep-seqs-filtered.qza \
  --o-tree unrooted-tree-filtered.qza

qiime phylogeny midpoint-root \
  --i-tree unrooted-tree-filtered.qza \
  --o-rooted-tree rooted-tree-filtered.qza

echo -e "\n#Export to Phyloseq-compatible format"
qiime tools export \
  --input-path table-filtered.qza \
  --output-path ../biom

qiime tools export \
  --input-path taxonomy.qza \
  --output-path ../biom

qiime tools export \
  --input-path rooted-tree-filtered.qza \
  --output-path ../biom

source deactivate
source activate py27

echo -e "\n#Other conversions and normalizations in TSV format"
cd ../biom

biom convert \
  -i feature-table.biom \
  -o feature-json.biom \
  --table-type="OTU table" \
  --to-json

sed -i s/Taxon/taxonomy/ taxonomy.tsv | sed -i s/Feature\ ID/FeatureID/ taxonomy.tsv

biom add-metadata \
  -i feature-json.biom \
  -o feature_w_tax.biom \
  --observation-metadata-fp taxonomy.tsv \
  --observation-header FeatureID,taxonomy,Confidence \
  --sc-separated taxonomy --float-fields Confidence

filter_taxa_from_otu_table.py \
  -i feature_w_tax.biom \
  -o table_wo_chl_mit.biom \
  -n D_2__Chloroplast,D_4__Mitochondria

biom convert \
 -i table_wo_chl_mit.biom \
 -o ASV-table.tsv \
 --to-tsv \
 --table-type "OTU table"

sed -i s/"#OTU ID"/FeatureID/ ASV-table.tsv
sed -i '1d' ASV-table.tsv

source deactivate

date

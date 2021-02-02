# Microbiome analysis of the Gepotidacin Ph2a trial

## Introduction
Gepotidacin is a first-in-chemical-class triazaacenaphthylene antibiotic with a distinct mechanism of action, in adult females with uncomplicated urinary tract infections for gepotidacin ([GSK2140944](https://www.medchemexpress.com/Gepotidacin.html)). This analyses follow the patients of the Phase 2a clinical trial for Gepotidacin ([NCT03568942](https://clinicaltrials.gov/ct2/show/NCT03568942)). 

## Cohort description

Female patients with recurrent uUTI were administered Gepotidacin for 5 days. Samples were collected with pharyngeal swabs, vaginal swabs and stool sampling at first day of dosing (Day 1), at the end of regimen (Day 5) and at a follow-up visit happening 28±3 days after Day 1. 

Distribution of samples
|     Body   site    |     Day   1    |  |     Day   5    |  |     Follow-up    |  |     Total   Collected    |     Total   Pass QC    |
|-|-|-|-|-|-|-|-|-|
|  |     Collected    |     Passed   QC    |     Collected    |     Passed   QC    |     Collected    |     Passed   QC    |  |  |
|     GI Tract     (stool)    |     13    |     11    |     13    |     12    |     10    |     6    |     36    |     29    |
|     Pharyngeal     (saliva)    |     21    |     18    |     20    |     16    |     19    |     19    |     60    |     53    |
|     Vaginal     (swabs)    |     21    |     21    |     20    |     19    |     19    |     19    |     60    |     59    |
|     Total    |     55    |     50    |     53    |     47    |     48    |     44    |     156    |     141    |

## Methods
16S V4 rRNA reads of microbiome samples are publically available at Sequence Read Archive (SRA) under BioProject ID: [PRJNA630295](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA630295) and SRA submission: SUB7386163.

16S V4 rRNA were analysed using [Qiime2 v 2018.8](https://docs.qiime2.org/2018.8) and [Phyloseq v1.28.0](https://joey711.github.io/phyloseq/).

## Results
Analyses can be reproduced by running the scripts in the `qiime2` folder to your local installation of qiime. These will produce the following files:
- qiime2/table_wo_chl_mit.biom
- qiime2/tree.nwk

These can be then imported into Phyloseq to reproduce the full `16S.Rmd` file.

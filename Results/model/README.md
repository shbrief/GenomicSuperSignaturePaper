## Rmarkdowns
### What_RAVindex_Is.Rmd
General characterization of RAVmodel. This vignette contains the code to 
make [_**Supplementary Figure 9**_](https://github.com/shbrief/GenomicSuperSignaturePaper/blob/master/Results/model/manuscript_SupFig9.png).

### PCs_In_Clusters.Rmd
This vignette contains the code to plot [_**Supplementary Figure 10. Distribution of PCs in different sized RAVs**_](https://github.com/shbrief/GenomicSuperSignaturePaper/blob/master/Results/model/PCs_In_Clusters.pdf).

### Characterize_GSEA.Rmd
Characterize GSEA annotation part of RAVmodel. This vignette contains the code 
to make [_**Supplementary Figure 11. RAVs without enriched pathways**_](https://github.com/shbrief/GenomicSuperSignaturePaper/blob/master/Results/model/manuscript_SupFig11.png).

### LINC.Rmd
Investigate how long intergenic non-coding (LINC) genes affect GSEA annotation
of RAVmodel.

### Simulate_PCSSs.Rmd
Simulate 4,764 RAVs following the distribution pattern of the actual RAVindex
and evaluate how likely to obtain PCSS-like RAVs from the random RAVs.

### Top10PCs_RAVmodel.Rmd
Together with [`lowerPCsInClsuters.csv`](https://github.com/shbrief/GenomicSuperSignaturePaper/blob/master/Results/model/lowerPCsInClusters.csv), this vignette explains how we decide 
the number of PCs to collect for RAVmodel building through the sensitivity test.



## Data files
### pcNumAll.tsv
The significant number of PCs calculated through the elbow method. Actual 
calculation was done using `PLIER::num.pc` with modification. The script is 
available in `PC_selection.Rmd`

### RAVs_with_topPCs.tsv
A table containing RAVs that have more than two top PCs (PC1/2/3) from the same
study. This table doesn't contain all the PCs in the cluster, but only subset
the PCs from the same study. The script is available `What_RAVIndex_Is.Rmd`

### lowerPCsInClsuters.csv
A table summarize the frequency of lower PCs (PC11-20) in the different sized
clusters. There are three columns: `clusterSize`, `totalPCs` (the total number
of PCs contributing to the given size of cluster), and `lowerPCs` (the total
number of PC11-20 in the given size of cluster). From `PCs_In_Clusters.Rmd`.

### Top10PCs_RAVmodel.csv.gz
A matrix containing Pearson correlation coefficient between 2,382 RAVs 
from `RAVmodel_10` (RAVmodel constructed from top 10 PCs) and 4,764 RAVs 
from `RAVmodel_20` (RAVmodel constructed from top 20 PCs).




## R Scripts
### LINC.R
Script to build a RAVmodel without LINC genes.

### listOfRAVmodels.R
Combine tsv files downloaded from Google Sheet and make `availableRAVmodel.csv`
for GenomicSuperSignature package.

### pathwayCoverage.R
Function to calculate pathway coverage

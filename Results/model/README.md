# Contents

## Rmarkdowns
#### What_RAVindex_Is.Rmd
General characterization of RAVmodel. Makes _**Supplementary Figure 9**_.

#### Characterize_GSEA.Rmd
Characterize GSEA annotation part of RAVmodels

#### LINC.Rmd
Investigate how long intergenic non-coding (LINC) genes affect GSEA

#### Simulate_PCSSs.Rmd
Simulate 4,764 RAVs following the distribution pattern of the actual RAVindex
and test how likely to obtain PCSS-like RAVs

#### Top10PCs_RAVmodel.Rmd
Together with `lowerPCsInClsuters.csv`, this vignette explains how we decide 
the number of PCs to collect for RAVmodel building through the sensitivity test.

#### PCs_In_Clusters.Rmd
Plot _**Supplementary Figure 10**_, which is saved as `PCs_In_Clusters.pdf`.



## Data files
#### pcNumAll.tsv
The significant number of PCs calculated through the elbow method. Actual 
calculation was done using `PLIER::num.pc` with modification. The script is 
available in `PC_selection.Rmd`

#### RAVs_with_topPCs.tsv
A table containing RAVs that have more than two top PCs (PC1/2/3) from the same
study. This table doesn't contain all the PCs in the cluster, but only subset
the PCs from the same study. The script is available `What_RAVIndex_Is.Rmd`

#### lowerPCsInClsuters.csv
A table summarize the frequency of lower PCs (PC11-20) in the different sized
clusters. There are three columns: `clusterSize`, `totalPCs` (the total number
of PCs contributing to the given size of cluster), and `lowerPCs` (the total
number of PC11-20 in the given size of cluster). From `PCs_In_Clusters.Rmd`.

#### Top10PCs_RAVmodel.csv.gz
A matrix containing Pearson correlation coefficient between 2,382 RAVs 
from `RAVmodel_10` (RAVmodel constructed from top 10 PCs) and 4,764 RAVs 
from `RAVmodel_20` (RAVmodel constructed from top 20 PCs).




## R
#### LINC.R
Script to build a RAVmodel without LINC genes.

#### listOfRAVmodels.R
Combine tsv files downloaded from Google Sheet and make `availableRAVmodel.csv`
for GenomicSuperSignature package.

#### pathwayCoverage.R
Function to calculate pathway coverage

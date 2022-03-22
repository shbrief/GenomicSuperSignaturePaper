# RAVmodels

### PCs_In_Clusters.Rmd
Plot _**Supplementary Figure 9**_, which is saved as `PCs_In_Clusters.pdf`.

### lowerPCsInClsuters.csv
A table summarize the frequency of lower PCs (PC11-20) in the different sized
clusters. There are three columns: `clusterSize`, `totalPCs` (the total number
of PCs contributing to the given size of cluster), and `lowerPCs` (the total
number of PC11-20 in the given size of cluster). From `PCs_In_Clusters.Rmd`.

### listOfRAVmodels.R
Combine tsv files downloaded from Google Sheet and make `availableRAVmodel.csv`
for GenomicSuperSignature package.

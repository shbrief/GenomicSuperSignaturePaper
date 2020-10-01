## PCAGenomicSignatures
### PURPOSE
Thousands of RNA sequencing profiles have been deposited in public archives, yet 
remain unused for the interpretation of most newly performed experiments. Methods 
for leveraging these public resources have focused on the interpretation of existing 
data, or analysis of new datasets independently, but do not facilitate direct comparison 
of new to existing experiments. The interpretability of common unsupervised analysis 
methods such as Principal Component Analysis would be enhanced by efficient comparison 
of the results to previously published datasets.

### METHODS
To help identify replicable and interpretable axes of variation in any given gene 
expression dataset, we performed principal component analysis (PCA) on 536 studies 
comprising 44,890 RNA sequencing profiles. Sufficiently similar loading vectors, 
when compared across studies, were combined through simple averaging. We annotated 
the collection of resulting average loading vectors, which we call Replicable Axes 
of Variation (RAV), with details from the originating studies and gene set enrichment 
analysis. Functions to match PCA of new datasets to RAVs from existing studies, 
extract interpretable annotations, and provide intuitive visualization, are implemented 
as the [PCAGenomicSignatures](https://shbrief.github.io/PCAGenomicSignatures/) R package, 
to be submitted to Bioconductor. 



## Benchmark Examples
In this site, we are presenting the application notes of PCAGenomicSignatures.

### CRC paper
#### Continuous Subtype Score
Detail on this reproducing process is described in [CRC/CRC subtype score](https://shbrief.github.io/PCAGenomicSignaturesPaper/Results/CRC/repeat_Fig4A.html).

<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/inst/images/CRC_Fig4A.png" width="300" height="300">
<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/Results/CRC/outputs/png/scatter_834_833.png" width="300" height="300">

#### Clinical Variables
Detail on this reproducing process is described in [CRC/CRC clinical variables](https://shbrief.github.io/PCAGenomicSignaturesPaper/Results/CRC/repeat_Fig4C.html).

<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/inst/images/CRC_Fig4C.png" width="500" height="300">
<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/Results/CRC/outputs/png/boxplot_PCSS_vs_834_833.png" width="500" height="300">

We directly compared the performanace between PCSS and RAV. Except the tumor location 
(the last column), RAV834/833-based model out-performed PCSS1/2-based model relative
to the combined model.

<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/Results/CRC/outputs/png/boxplot_PCSS_vs_834_833.png" width="500" height="300">

### multiPLIER paper


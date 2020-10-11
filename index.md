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
One of the benchmarking papers is [Continuity of transcriptomes among colorectal cancer subtypes based on meta-analysis](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-018-1511-4). 

#### Continuous Subtype Score
Left panel is Figure 4A from CRC paper and right panel is the CRC subtype separation
by PCAGenomicSignatures. CRC paper built the continuous score model based on the 8 
colorectal cancer specific microarray datasets with graph-based clustering method. 
However, PCAGenomicSignatures was generated from 536 heterogeneous, RNA sequencing 
datasets and used hierarchical clustering. Despite of this major differences in 
model building process, PCAGenomicSignatures could reproduce the CRC paper's result.

Detail on this reproducing process is described in [CRC/CRC subtype score](https://shbrief.github.io/PCAGenomicSignaturesPaper/Results/CRC/repeat_Fig4A.html) 
tab. 

<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/inst/images/CRC_Fig4A.png" width="300" height="300">
<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/Results/CRC/outputs/png/scatter_834_833.png" width="300" height="300">

#### Clinical Variables
Detail on this reproducing process is described in [CRC/CRC clinical variables](https://shbrief.github.io/PCAGenomicSignaturesPaper/Results/CRC/repeat_Fig4C.html).

<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/inst/images/CRC_Fig4C.png" width="500" height="300">
<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/Results/CRC/outputs/png/boxplot_CMS_vs_834_833.png" width="500" height="300">

We directly compared the performanace between PCSS and RAV. Except the tumor location 
(the last column), RAV834/833-based model out-performed PCSS1/2-based model relative
to the combined model.

<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/Results/CRC/outputs/png/boxplot_PCSS_vs_834_833.png" width="500" height="300">

### multiPLIER paper
The other benchmarking paper is [MultiPLIER: A Transfer Learning Framework for Transcriptomics Reveals Systemic Features of Rare Disease](https://www.cell.com/cell-systems/fulltext/S2405-4712(19)30119-X?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS240547121930119X%3Fshowall%3Dtrue). 

#### Neutrophil Counts/Estimates
The top panel is Figure 3 from multiPLIER paper and the bottom panel is the benchmark
example by PCAGenomicSignatures. In multiPLIER paper, latent variables (LVs) were
built from recount2 datasets using [Pathway-level information extractor (PLIER)](https://www.nature.com/articles/s41592-019-0456-1) method. Despite of the 
major differences in model building process, PCAGenomicSignatures could reproduce 
the multiPLIER paper's result.

Detail on this reproducing process is described in [multiPLIER/Neutrophil (SLE-WB)](https://shbrief.github.io/PCAGenomicSignaturesPaper/Results/SLE-WB/repeat_Fig3_SLE-WB.html) 
and [multiPLIER/Neutrophil (NARES)](https://shbrief.github.io/PCAGenomicSignaturesPaper/Results/NARES/repeat_Fig3_NARES.html) tabs.

Fig 3 from multiPLIER paper: neutrophil-associated LV, LV603 shows the positive 
correlation with neutrophil counts/estimates of two different datasets, SLE WB 
and NARES.

<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/inst/images/multiPLIER_Fig3.png" width="600" height="200">

We used 
<img src="https://raw.githubusercontent.com/shbrief/PCAGenomicSignaturesPaper/master/Results/multiPLIER_Fig3.png" width="600" height="200">


#### Cell Type Discovery

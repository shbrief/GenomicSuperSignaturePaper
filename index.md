# GenomicSuperSignaturePaper
Here, we presents the usecases and benchmarking examples of [GenomicSuperSignature](http://www.bioconductor.org/packages/release/bioc/html/GenomicSuperSignature.html) 
R/Bioconductor package. All the codes to reproduce Figures and Tables in our 
paper is included as well. ( _**Note**_: To check the source code of vignettes,
click the "Source Code" link under the *Abstract* section, not the *Source* 
section.) You can check our paper for more details.

> Oh S, Geistlinger L, Ramos M, Blankenberg D, van den Beek M, Taroni JN, Carey VJ, Waldron L, Davis S. 
> GenomicSuperSignature facilitates interpretation of RNA-seq experiments through robust, efficient comparison to public databases. 
> *Nature Communications* **2022**;13: 3695.
> [doi: 10.1038/s41467-022-31411-3](https://www.nature.com/articles/s41467-022-31411-3)



## Disease Subtyping
To compare the utility of GenomicSuperSignature relative to the focused use of 
data from a single disease, we compared RAVs to [the previous study](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-018-1511-4) 
(referred as *CRC paper* below) that employed colorectal cancer (CRC) gene 
expression databases to identify CRC molecular subtypes.


#### Continuous Subtype Score
The left panel is Figure 4A from CRC paper and the right panel is the CRC 
subtype separation by GenomicSuperSignature. CRC paper built the continuous 
score model based on the 8 colorectal cancer specific, microarray datasets 
with graph-based clustering method. GenomicSuperSignature was generated from 
536 heterogeneous, RNA sequencing datasets and used hierarchical clustering. 
Despite of these major differences in model building process, 
GenomicSuperSignature and CRC paper's model show comparable performance.

<img src="https://raw.githubusercontent.com/shbrief/GenomicSuperSignaturePaper/master/inst/images/CRC_Fig4A.png" width="300" height="300">
<img src="https://raw.githubusercontent.com/shbrief/GenomicSuperSignaturePaper/master/Results/CRC/outputs/png/scatter_834_833.png" width="300" height="300">

Details on these plots are described in [Subtyping/CRC subtype scores](https://shbrief.github.io/GenomicSuperSignaturePaper/articles/CRC/CRC_Subtyping.html). 


#### Clinical Variables
Below is Figure 4 from CRC paper. LRT (likelihood-ratio test) between the 
reference full model versus either the continuous scores only model or the 
discrete subtypes only model are plotted here. A p-value near 1 (−log10p-value 
near 0) suggests that no additional information is provided by the full model. 

This results shows that PCSS1/2 (the second column, *score*) provide additional 
information in characterizing molecular/histological/clinical correlates than 
CMS (the first column, *subtype*).

<img src="https://raw.githubusercontent.com/shbrief/GenomicSuperSignaturePaper/master/inst/images/CRC_Fig4C.png" width="500" height="300">

</br>

RAV834/833, two RAVs that explain CMS subtypes best among 4,764 RAVs, also 
performs better than CMS subtypes.

<img src="https://raw.githubusercontent.com/shbrief/GenomicSuperSignaturePaper/master/Results/CRC/outputs/png/boxplot_CMS_vs_834_833.png" width="500" height="300">

</br>

We directly compared the performance between PCSSs and RAVs. Except the tumor 
location (the last panel), RAV834/833-based model out-performed PCSS1/2-based 
model relative to the combined model.

<img src="https://raw.githubusercontent.com/shbrief/GenomicSuperSignaturePaper/master/Results/CRC/outputs/png/boxplot_PCSS_vs_834_833.png" width="500" height="300">

</br>

Details on the above plots are described in [Subtyping/CRC clinical variables](https://shbrief.github.io/GenomicSuperSignaturePaper/articles/CRC/CRC_ClinicalVar.html).


## Transfer Learning
For practical and technical reasons, biological datasets often contain missing 
information or signals buried in noise. GenomicSuperSignature can fill out 
those gaps by uncovering weak or indirectly measured biological attributes of 
a new dataset by leveraging the existing databases. To evaluate this ‘transfer 
learning’ aspect of the GenomicSuperSignature, we compared the neutrophil 
count estimation by RAVs across two different datasets, systemic lupus 
erythematosus whole blood ([SLE-WB](https://www.cell.com/cell/pdfExtended/S0092-8674(16)30264-1)) 
and nasal brushing ([NARES](https://onlinelibrary.wiley.com/doi/full/10.1002/art.39185)) 
datasets as described in [the previous study](https://www.cell.com/cell-systems/fulltext/S2405-4712(19)30119-X?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS240547121930119X%3Fshowall%3Dtrue)(referred as 
*MultiPLIER paper* below).


#### Neutrophil Counts/Estimates
The top panel is Figure 3 from MultiPLIER paper and the bottom panel is the 
result from GenomicSuperSignature. In MultiPLIER paper, latent variables (LVs) 
were built from recount2 datasets using [Pathway-level information extractor (PLIER)](https://www.nature.com/articles/s41592-019-0456-1) method. Despite of 
the major differences in model building process, GenomicSuperSignature and 
MultiPLIER paper's results show comparable performance.

Neutrophil-associated LV, LV603, from MultiPLIER model shows the positive 
correlation with neutrophil counts/estimates of two different datasets, 
SLE-WB and NARES.

<img src="https://raw.githubusercontent.com/shbrief/GenomicSuperSignaturePaper/master/inst/images/multiPLIER_Fig3.png" width="600" height="200">

</br>
We used SLE-WB dataset to identify the neutrophil-associated RAV, RAV1551, and 
applied it to NARES dataset.

<img src="https://raw.githubusercontent.com/shbrief/GenomicSuperSignaturePaper/master/Results/multiPLIER_Fig3.png" width="600" height="200">


Details on the analysis process are described in [Transfer Learning/Neutrophil (SLE-WB)](https://shbrief.github.io/GenomicSuperSignaturePaper/articles/SLE-WB/neutrophil_counts_SLE-WB.html) 
and [Transfer Learning/Neutrophil (NARES)](https://shbrief.github.io/GenomicSuperSignaturePaper/articles/NARES/neutrophil_counts_NARES.html).

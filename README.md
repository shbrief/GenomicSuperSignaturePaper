## GenomicSuperSignaturePaper

This repository contains the model building processes and the validation steps
for [GenomicSuperSignature](https://github.com/shbrief/GenomicSuperSignature) 
package and the accompanying [manuscript](https://www.biorxiv.org/content/10.1101/2021.05.26.445900v1).

To run analyses under `Results` and `Methods`, you need to download the 
GenomicSuperSignature model from Google bucket (it's free, FYI). Currently, 
two versions of models are available, annotated with different prior gene 
sets. Here is how to download those RAVmodels. Run the below snippet from 
your terminal.

```
git clone https://github.com/shbrief/GenomicSuperSignaturePaper.git
cd GenomicSuperSignaturePaper/inst/extdata

wget https://storage.googleapis.com/genomic_super_signature/RAVmodel_C2.rds
wget https://storage.googleapis.com/genomic_super_signature/RAVmodel_PLIERpriors.rds

cd GenomicSuperSignaturePaper
R -e 'devtools::build();devtools::install()'
```

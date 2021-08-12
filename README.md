## GenomicSuperSignaturePaper

This repository contains the model building processes and the validation steps
for [GenomicSuperSignature](https://github.com/shbrief/GenomicSuperSignature) 
package and the accompanying [manuscript](https://www.biorxiv.org/content/10.1101/2021.05.26.445900v1).

To run analyses under `Results` and `Methods`, you need to download the 
RAVmodel from Google bucket (it's free, FYI). Currently, two versions of 
RAVmodels are available, annotated with different prior gene sets. 

```
## Download RAVmodel with wget
wget https://storage.googleapis.com/genomic_super_signature/RAVmodel_C2.rds
wget https://storage.googleapis.com/genomic_super_signature/RAVmodel_PLIERpriors.rds

## Download RAVmodel with GenomicSuperSignature::getModel function
BiocManager::install("GenomicSuperSignature")
getModel("C2")
getModel("PLIERpriors")
```

A few accessory functions to run examples in this repository can be accessed
through GenomicSuperSignaturePaper package.

```
## Install GenomicSuperSignaturePaper
devtools::document("shbrief/GenomicSuperSignaturePaper")
```

## GenomicSuperSignaturePaper

This repository describes the model building processes and the validation steps
for [GenomicSuperSignature](https://github.com/shbrief/GenomicSuperSignature) 
package. All the Figures and Tables in GenomicSuperSignature [paper](https://www.nature.com/articles/s41467-022-31411-3) 
can be reproduced using the codes and instruction in this repository. 

To run analyses under `Results` and `Methods`, we recommend to clone this 
repository. 

```
git clone git@github.com:shbrief/GenomicSuperSignaturePaper.git
```

You can download RAVmodels from Google bucket (it's free, FYI) using `wget` or
`GenomicSuperSignature::getModel()` function. Currently, two different 
RAVmodels are available, annotated with different prior gene sets. 

```
## Download the latest RAVmodel with wget
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
devtools::install_github("shbrief/GenomicSuperSignaturePaper")
```

You can check the available RAVmodels through `availableRAVmodel` function:
```
> GenomicSuperSignature::availableRAVmodel()
        prior version   update pkg_version
1          C2    beta 20201101       1.1.0
3          C2  latest 20220115       1.3.0
4 PLIERpriors    beta 20201101       1.1.0
6 PLIERpriors  latest 20220115       1.3.0
```

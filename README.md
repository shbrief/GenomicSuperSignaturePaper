## PCAGenomicSignaturesPaper

This repository contains the model building processes and the validation steps
for [PCAGenomicSignatures](https://github.com/shbrief/PCAGenomicSignatures) package 
and the accompaning manuscript.

To run analyses under `Results`, you need to download the PCAGenomicSignatures model 
from Google bucket (it's free, FYI). Currently, two versions of models are available, 
annotated with different prior gene sets. Here is how to download the model annotated 
with MSigDB C2: curated gene sets. Run the below snippet from your terminal.

```
git clone https://github.com/shbrief/PCAGenomicSignaturesPaper.git
cd PCAGenomicSignaturesPaper/inst/extdata

wget https://storage.googleapis.com/pca_genomic_signatures/PCAmodel_C2.rds
wget https://storage.googleapis.com/pca_genomic_signatures/PCAmodel_PLIERpriors.rds

cd PCAGenomicSignaturesPaper
R -e 'devtools::build();devtools::install()'
```

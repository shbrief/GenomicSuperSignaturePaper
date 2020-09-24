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

R -e 'devtools::install_github("shbrief/PCAGenomicSignatures");
PCAGenomicSignatures::getModel("C2", dir = "PCAGenomicSignaturesPaper/inst/extdata")'

cd PCAGenomicSignaturesPaper

R -e 'devtools::build();devtools::install()'
```

PCAGenomicSignatures models are ~500MB, so it will take a little time.

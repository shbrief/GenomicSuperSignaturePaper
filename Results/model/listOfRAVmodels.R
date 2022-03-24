## List of RAVmodels
## It is created in https://docs.google.com/spreadsheets/d/1KwaptOkLxnCL-eP715EMgl0VVNnh_o3tcHhFbwFHgH8/edit?usp=sharing
wd <- "~/GSS/GenomicSuperSignaturePaper/Results/model"

c2 <- read.table(file.path(wd, "availableRAVmodel - C2.tsv"), sep = "\t", header = TRUE)
pp <- read.table(file.path(wd, "availableRAVmodel - PLIERpriors.tsv"), sep = "\t", header = TRUE)

ravmodels <- rbind(c2, pp)
write.csv(ravmodels,
          file = "~/GSS/GenomicSuperSignature/inst/extdata/availableRAVmodel.csv",
          row.names = FALSE)

#!/bin/bash
# Use pkgdown to build a basic package website

## To create an initially empty gh-pages branch, where GitHub Pages will be deployed:
# git checkout --orphan gh-pages
# git rm -rf .
# git commit --allow-empty -m 'Initial gh-pages commit'
# git push origin gh-pages
# git checkout master

# ## For subsequent manual updates, if you are not using the procedure in .travis.yml
# ## This part didn't work for me.
# Rscript --vanilla -e "pkgdown::build_site(lazy=TRUE)"
# git checkout --orphan gh-pages
# git pull origin gh-pages
# mv docs/* .
# rm -rf docs/
# git stage *
# git commit -m "update GitHub pages"
# git push origin gh-pages


##### For GenomicSuperSignaturePaper package ###################################
## Set the soft symbolic link to make build docs
ln -s Results vignettes   # Results
Rscript --vanilla -e "pkgdown::build_site(lazy=TRUE)"
rm vignettes
ln -s Methods vignettes   # Methods
Rscript --vanilla -e "pkgdown::build_site(lazy=TRUE)"
rm vignettes

git checkout gh-pages
git pull origin gh-pages

## Need to overwrite previous 'articles' and 'references' directories
rm -rf articles
rm -rf references

mv -f docs/* .
rm -rf docs/

## [Note] Any html files not built through vignettes should be manually updated
## in the gh-pages branch

git stage *

## Reset large data files
git reset HEAD inst/extdata/*
git reset HEAD Results/CRC/data/*
git reset HEAD Results/SLE-WB/data/*
git reset HEAD Results/TCGA/data/*
git reset HEAD Results/E-MTAB-2452/data/*
git reset HEAD SRAmetadb.sqlite.gz
git reset HEAD Results/model/Top10PCs_RAVmodel.csv.gz
git reset HEAD Revisions/Top10PCs_RAVmodel.csv
git reset HEAD Revisions/topGenesInTrainingData_536_2020-08-07.rds

## Reset temporary works
git reset HEAD Methods/prepare_Inputs
git reset HEAD Ongoing/*
git reset HEAD GSE119352/*

git commit -m "update GitHub pages"
git push origin gh-pages

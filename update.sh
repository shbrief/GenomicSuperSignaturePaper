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


## For PCAGenomicSignatures package
Rscript --vanilla -e "pkgdown::build_site(lazy=TRUE)"
git checkout gh-pages
git pull origin gh-pages
mv docs/* .
rm -rf docs/
git stage *
git reset HEAD inst/extdata/*   # large data file
git reset HEAD Results/CRC/data/*   # large data file
git reset HEAD Results/SLE-WB/data/*   # large data file
git commit -m "update GitHub pages"
git push origin gh-pages

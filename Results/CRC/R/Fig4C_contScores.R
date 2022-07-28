##### Required environmental variables #########################################
# This script requires six environmental variables set before running:
# `m1_name`, `m1_1`, `m1_2` for one model
# `m2_name`, `m2_1`, `m2_2` for the other
# `num_dat` (the number of CRC datasets for validation, 18 or 10)
################################################################################


library(Biobase)
library(tidyverse)
library(survival)
library(metafor)
library(logistf)

## Decide whether to use all 18 datasets (what CRC paper did) or only 10 validation datasets
if (num_dat == 18) {
    load(file.path("data/eSets/setNames.RData"))
} else if (num_dat == 10) {
    load(file.path("data/eSets/setNames.RData"))
    load(file.path("data/eSets/trainingSetNames.RData"))
    validationSetNames <- setdiff(setNames, trainingSetNames)
    setNames <- validationSetNames
}

## Load validation samples
for (set in setNames) {
    load(paste0("data/eSets_new/", set, '.RData'))
}

## Collect all validation data in a list, eSets
eSets <- list()
for (set in setNames){
    eset.tmp <- get(set)
    eSets[[set]] <- eset.tmp
}

vars <- c("msi", "summarylocation", "summarygrade", "summarystage")
vars.contrasts <- c("MSI", "r", "high", "late")
names(vars.contrasts) <- vars

## CMS subtypes ----------------------------------------------------------------
output.dir.name <- paste(m2_1, m2_2, num_dat, "valData", sep = "_")
output.dir <- file.path("data/results/model_comparison/CMS", output.dir.name)
dir.create(output.dir, showWarnings = FALSE, recursive = TRUE)

## Binary outcomes
for (var in vars) {
    results.table <- matrix(NA, length(setNames), 5)
    dimnames(results.table) <- list(setNames,
                                    c("AIC.full", "AIC.disc", "LR.disc",
                                      "AIC.cont", "LR.cont"))
    for(set in setNames) {
        pData.tmp <- pData(eSets[[set]]) %>% subset(sample_type == "tumor")
        outcome <- (pData.tmp[, var] == vars.contrasts[var])
        count.table <- table(outcome)

        if(length(count.table) <= 1) {
            next # all outcome values are the same, not able to evaluate
        } else {
            model.all <- tryCatch(glm((outcome == "TRUE") ~ pData.tmp[,m1_1] + pData.tmp[,m1_2] + pData.tmp[,m2_1] + pData.tmp[,m2_2],
                                      data = pData.tmp, family = "binomial",
                                      control = list(maxit = 1000)),
                                  warning = function(w) NULL)
            model.disc <- tryCatch(glm((outcome == "TRUE") ~ pData.tmp[,m1_1] + pData.tmp[,m1_2],
                                       data = pData.tmp, family = "binomial",
                                       control = list(maxit = 1000)),
                                   warning = function(w) NULL)
            model.cont <- tryCatch(glm((outcome == "TRUE") ~ pData.tmp[,m2_1] + pData.tmp[,m2_2],
                                       data = pData.tmp, family = "binomial",
                                       control = list(maxit = 1000)),
                                   warning = function(w) NULL)
            if(any(c(is.null(model.all), is.null(model.disc), is.null(model.cont)))) {
                next
            } else {
                results.table[set, c("AIC.full", "AIC.disc", "AIC.cont")] <- AIC(model.all, model.disc, model.cont)[, 2]
                results.table[set, c("LR.disc", "LR.cont")] <- c(anova(model.all, model.disc, test="LRT")[2, 5],
                                                                 anova(model.all, model.cont, test="LRT")[2, 5])
            }
        }
    }
    write.csv(results.table, file = file.path(output.dir, paste0(var, ".csv")))
}



## Panel for discrete subtypes AIC likelihood ----------------------------------
# Akaike information criterion (AIC) (Akaike, 1974) is a fined technique based on
# in-sample fit to estimate the likelihood of a model to predict/estimate the future
# values. A good model is the one that has minimum AIC among all the other models.

df.toplot <- lapply(vars, function(var) {
    df.results <- read.csv(file.path("data/results/model_comparison/CMS",
                                     output.dir.name,
                                     paste0(var, ".csv")))
    # df.results <- df.results[df.results$PCSS1.sd < 100, ]
    return(data.frame(df.results, Variable = var))
}) %>% Reduce('rbind', .) %>%
    mutate(
        Variable = Variable %>%
            recode("msi" = 'MSI status',
                   "summarygrade" = 'grade',
                   "summarystage" = 'stage',
                   "summarylocation" = 'tumor location',
                   "dfs" = 'DFS')
    )

df.toplot <- df.toplot %>%
    gather(key = Model,
           value = log10_pvalue,
           LR.cont, LR.disc)

# discrete-subtype vs. continuous-score
df.toplot$Model[df.toplot$Model == 'LR.cont'] <- m2_name
df.toplot$Model[df.toplot$Model == 'LR.disc'] <- m1_name
df.toplot$Model <- factor(df.toplot$Model, levels = c(m1_name, m2_name))
df.toplot$Variable <- factor(df.toplot$Variable, levels = c("MSI status", "grade", "stage", "tumor location"))

main <- paste0(m1_name, readr::parse_number(m1_1), "/", readr::parse_number(m1_2), " vs. ",
               m2_name, readr::parse_number(m2_1), "/", readr::parse_number(m2_2))

# Save the raw data table for the manuscript
fname <- paste(m1_1, m1_2, m2_1, m2_2, num_dat, "valData", sep = "_")
write.csv(df.toplot, file = file.path("data/results/model_comparison/CMS",
                                      paste0(fname, ".csv")))

df.toplot %>%
    ggplot(aes(x = Model, y = -log10(log10_pvalue))) +
    geom_boxplot(outlier.shape = NA) +
    geom_point(position = position_jitter(width = 0.2)) +
    facet_wrap(~Variable, nrow = 1, scales = 'free') +
    theme_bw() +
    geom_hline(yintercept = -log10(0.05), color = 'red', linetype = 'dashed') +
    ylab('-log10 p-value') +
    ggtitle(main)

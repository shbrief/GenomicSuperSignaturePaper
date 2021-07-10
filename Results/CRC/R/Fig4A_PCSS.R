## dist’n of PCSS scores -------------------------------------------------------
df.results <- setNames %>% lapply(function(set) {
    eSet <- get(set)
    pdata <- pData(eSet)
    eSet_tmp <- eSet[, pdata$sample_type %in% "tumor"]
    exprs_tmp <- exprs(eSet_tmp)
    pdata_tmp <- pData(eSet_tmp)

    pdata_tmp$study <- set
    ind_rm <- grep("CRIS_", colnames(pdata_tmp))  # remove CIRS_* pData assigned to training datasets
    if (length(ind_rm) != 0) {pdata_tmp <- pdata_tmp[,-ind_rm]}
    return(pdata_tmp)

}) %>% Reduce('rbind', .)

## Subset with 'cms_label_SSP'
df.results <- df.results %>%
    mutate(cms_label_SSP = cms_label_SSP %>%
               recode("unlabeled" = "not labeled"))

df.results <- df.results %>%
    group_by(study, cms_label_SSP) %>%
    dplyr::summarise(mean_PCSS1 = mean(PCSS1),
                     mean_PCSS2 = mean(PCSS2),
                     sd_PCSS1 = sd(PCSS1),
                     sd_PCSS2 = sd(PCSS2))

## Plot Figure 4A
colors <- gg_color_hue(4)
colors.toplot <- c(colors, 'grey')
names(colors.toplot) <- c(paste0('CMS', 1:4), 'not labeled')

pA <- ggplot(df.results,
             aes(x = mean_PCSS1, y = mean_PCSS2, color = cms_label_SSP)) +
    geom_point() +
    geom_errorbar(aes(x = mean_PCSS1,
                      ymin = mean_PCSS2 - sd_PCSS2,
                      ymax = mean_PCSS2 + sd_PCSS2)) +
    geom_errorbarh(aes(y = mean_PCSS2,
                       xmin = mean_PCSS1 - sd_PCSS1,
                       xmax = mean_PCSS1 + sd_PCSS1)) +
    scale_color_manual(values = colors.toplot, name = "CMS Subtype") +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) +
    geom_hline(yintercept = 0, linetype = 'dashed') +
    geom_vline(xintercept = 0, linetype = 'dashed') +
    xlab('PCSS1') + ylab('PCSS2') +
    coord_cartesian(xlim = c(-2, 2.5)) +
    theme(legend.direction = "horizontal",
          legend.justification=c(0,1),
          legend.position=c(0,1),
          legend.background = element_rect(colour='black'))

print(pA)

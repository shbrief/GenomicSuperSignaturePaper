##### Required environmental variables #########################################
# Required inputs:
# 1. `sampleScore1` and `sampleScore2`
# 2. `df.results` : A data frame containing study metadata and sample scores assigned
#   by RAVs. It should include `study` column.
# 3. `val_only` : A logical. If it's `TRUE`, only 10 CRC datasets will be used instead of 18 datasets.
################################################################################

if (isTRUE(val_only)) {
  load("data/eSets/setNames.RData")
  load("data/eSets/trainingSetNames.RData")
  validationSetNames <- setdiff(setNames, trainingSetNames)
  setNames <- validationSetNames

  validation_data_row <- which(df.results$study %in% setNames)
  df.results.new <- df.results[validation_data_row,]
} else {df.results.new <- df.results}

ind1 <- which(colnames(df.results.new) == paste0("RAV", sampleScore1))
ind2 <- which(colnames(df.results.new) == paste0("RAV", sampleScore2))
colnames(df.results.new)[ind1] <- "sampleScore1"
colnames(df.results.new)[ind2] <- "sampleScore2"

# Subset with 'cms_label_SSP'
df.results.new <- df.results.new %>%
  mutate(cms_label_SSP = cms_label_SSP %>%
           dplyr::recode("unlabeled" = "not labeled"))

df.results.new <- df.results.new %>%
  group_by(study, cms_label_SSP) %>%
  dplyr::summarise(mean_sampleScore1 = mean(sampleScore1),
                   mean_sampleScore2 = mean(sampleScore2),
                   sd_sampleScore1 = sd(sampleScore1),
                   sd_sampleScore2 = sd(sampleScore2))

# Plot Figure 4A
colors <- gg_color_hue(4)
colors.toplot <- c(colors, 'grey')
names(colors.toplot) <- c(paste0('CMS', 1:4), 'not labeled')

pA <- ggplot(df.results.new,
             aes(x = mean_sampleScore1, y = mean_sampleScore2, color = cms_label_SSP)) +
  geom_point() +
  geom_errorbar(aes(x = mean_sampleScore1,
                    ymin = mean_sampleScore2 - sd_sampleScore2,
                    ymax = mean_sampleScore2 + sd_sampleScore2)) +
  geom_errorbarh(aes( y = mean_sampleScore2,
                      xmin = mean_sampleScore1 - sd_sampleScore1,
                      xmax = mean_sampleScore1 + sd_sampleScore1)) +
  scale_color_manual(values = colors.toplot, name = "CMS Subtype") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  geom_vline(xintercept = 0, linetype = 'dashed') +
  xlab(paste0("RAV", sampleScore1)) + ylab(paste0("RAV", sampleScore2)) +
  coord_cartesian(xlim = c(-2, 2.5)) +
  theme(legend.direction = "horizontal", legend.justification=c(0,1), legend.position=c(0,1),
        legend.background = element_rect(colour='black'))

print(pA)

# # Separated
# ordered.df.results.new <- df.results.new[order(df.results.new$mean_sampleScore1),]
# plot(ordered.df.results.new$mean_sampleScore1,
#      col = ordered.df.results.new$cms_label_SSP,
#      xlab = "", ylab = paste0("Score from RAV", sampleScore1))

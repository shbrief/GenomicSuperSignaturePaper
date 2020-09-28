##### Required environmental variables #########################################
# This script requires two environmental variables set before running:
# `sampleScore1` and `sampleScore2`
################################################################################

df.results <- readRDS("data/SummaryForFig4.rds")
ind1 <- which(colnames(df.results) == paste0("PCcluster", sampleScore1))
ind2 <- which(colnames(df.results) == paste0("PCcluster", sampleScore2))
colnames(df.results)[ind1] <- "sampleScore1"
colnames(df.results)[ind2] <- "sampleScore2"

# Subset with 'cms_label_SSP'
df.results <- df.results %>%
  mutate(cms_label_SSP = cms_label_SSP %>%
           recode("unlabeled" = "not labeled"))

df.results <- df.results %>%
  group_by(study, cms_label_SSP) %>%
  dplyr::summarise(mean_sampleScore1 = mean(sampleScore1),
                   mean_sampleScore2 = mean(sampleScore2),
                   sd_sampleScore1 = sd(sampleScore1),
                   sd_sampleScore2 = sd(sampleScore2))

# Plot Figure 4A
colors <- gg_color_hue(4)
colors.toplot <- c(colors, 'grey')
names(colors.toplot) <- c(paste0('CMS', 1:4), 'not labeled')

pA <- ggplot(df.results,
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
  xlab(paste0("PCcluster", sampleScore1)) + ylab(paste0("PCcuster", sampleScore2)) +
  coord_cartesian(xlim = c(-2, 2.5)) +
  theme(legend.direction = "horizontal", legend.justification=c(0,1), legend.position=c(0,1),
        legend.background = element_rect(colour='black'))

print(pA)

# # Separated
# ordered.df.results <- df.results[order(df.results$mean_sampleScore1),]
# plot(ordered.df.results$mean_sampleScore1,
#      col = ordered.df.results$cms_label_SSP,
#      xlab = "", ylab = paste0("Score from PCcluster", sampleScore1))

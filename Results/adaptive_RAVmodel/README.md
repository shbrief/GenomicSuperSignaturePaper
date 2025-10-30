## For adaptive RAVmodel

### Similarity
##### PCSS1/2
```
loading_cor[1, max1, drop = FALSE]
##          RAV244
## PCSS1 0.6316178
loading_cor[2, max2, drop = FALSE]
##          RAV186
## PCSS2 0.5289467
```

##### RAV834/1575
```
loading_cor[1, max1, drop = FALSE]
##           RAV80
## RAV834 0.299926
loading_cor[2, max2, drop = FALSE]
##            RAV250
## RAV1575 0.6734977
```

### With CMS labels
##### ANOVA
```
RAV129   RAV244   RAV313    RAV17   RAV214   RAV305
779.9085 715.3247 712.0050 698.0079 650.6213 643.5068
```

##### Kruskal-Walis
```
RAV17   RAV305   RAV244   RAV129   RAV313   RAV214
1798.527 1785.137 1776.623 1760.087 1661.385 1627.434
```


### Clinical feature
t-statistics in their absolute values

##### MSI t-test
```
RAV80   RAV193   RAV249   RAV247    RAV62   RAV183
21.88486 18.48609 14.88862 14.23037 12.82733 12.36668
```

##### Location t-test
```
RAV80   RAV193   RAV249    RAV26   RAV116    RAV29 
6.902548 5.978434 5.421384 5.130038 4.486941 4.418515
```

##### Grade t-test
```
RAV137   RAV305    RAV60    RAV36    RAV89    RAV54 
4.613250 4.205275 3.977588 3.924360 3.614669 3.589670
```

##### Stage t-test
```
RAV367   RAV114   RAV218   RAV148   RAV315   RAV301 
6.654774 6.465109 6.403526 5.722653 5.696533 5.568789
```


### Overall Summary
##### CRC Subtype (CMS Labels) - Statistical Rankings

| Rank | ANOVA | Score | Kruskal-Wallis | Score |
|------|--------|---------|----------------|---------|
| 1 | RAV129 | 779.91 | RAV17 | 1798.53 |
| 2 | RAV244 | 715.32 | RAV305 | 1785.14 |
| 3 | RAV313 | 712.01 | RAV244 | 1776.62 |
| 4 | RAV17 | 698.01 | RAV129 | 1760.09 |
| 5 | RAV214 | 650.62 | RAV313 | 1661.39 |
| 6 | RAV305 | 643.51 | RAV214 | 1627.43 |

##### Clinical Features - T-test Statistics (Absolute Values)

| Rank | MSI | t-stat | Location | t-stat | Grade | t-stat | Stage | t-stat |
|------|-----|--------|----------|--------|-------|--------|-------|--------|
| 1 | RAV80 | 21.88 | RAV80 | 6.90 | RAV137 | 4.61 | RAV367 | 6.65 |
| 2 | RAV193 | 18.49 | RAV193 | 5.98 | RAV305 | 4.21 | RAV114 | 6.47 |
| 3 | RAV249 | 14.89 | RAV249 | 5.42 | RAV60 | 3.98 | RAV218 | 6.40 |
| 4 | RAV247 | 14.23 | RAV26 | 5.13 | RAV36 | 3.92 | RAV148 | 5.72 |
| 5 | RAV62 | 12.83 | RAV116 | 4.49 | RAV89 | 3.61 | RAV315 | 5.70 |
| 6 | RAV183 | 12.37 | RAV29 | 4.42 | RAV54 | 3.59 | RAV301 | 5.57 |

##### Summary Recommendation Table

| Purpose | Recommended RAV(s) | Rationale |
|---------|-------------------|-----------|
| **CMS Subtype Classification** | RAV17 | Highest Kruskal-Wallis score (1798.53) |
| **CMS + Clinical Integration** | RAV305 | Top 6 in CMS tests + 2nd for Grade |
| **MSI & Location** | RAV80 | Dominant for MSI (21.88) and Location (6.90) |
| **Comprehensive Analysis** | RAV17, RAV305, RAV80 | Covers CMS subtypes and key clinical features |







## For adaptive_smaller RAVmodel

### Similarity
##### PCSS1/2
```
loading_cor[1, max1, drop = FALSE]
##          RAV514
## PCSS1 0.5546199
loading_cor[2, max2, drop = FALSE]
##          RAV373
## PCSS2 0.4517271
```

##### RAV834/1575
```
loading_cor[1, max1, drop = FALSE]
##         RAV178
## RAV834 0.34769
loading_cor[2, max2, drop = FALSE]
##            RAV533
## RAV1575 0.7256072
```

### With CMS labels
##### ANOVA
```
RAV249   RAV514   RAV687   RAV663   RAV105   RAV135 
807.7769 732.1876 689.6969 689.6041 687.5233 668.3928
```

##### Kruskal-Walis
```
RAV514   RAV249   RAV631   RAV105   RAV135   RAV637 
1889.547 1792.328 1789.886 1781.540 1709.263 1657.643
```


### Clinical feature
t-statistics in their absolute values

##### MSI t-test
```
RAV178   RAV382   RAV390    RAV89    RAV47   RAV540 
24.93914 17.36291 15.31702 14.75127 14.32652 14.04806 
```

##### Location t-test
```
RAV178   RAV257   RAV382    RAV89   RAV122   RAV539 
8.160666 7.581951 5.927185 5.815645 5.063996 5.063753 
```

##### Grade t-test
```
RAV280   RAV188    RAV98   RAV637   RAV631    RAV77 
4.351203 4.337670 4.272450 4.210095 4.138722 4.135729 
```

##### Stage t-test
```
RAV318   RAV468   RAV802   RAV212   RAV388    RAV97 
7.648076 6.997788 6.654774 6.465109 5.866894 5.843319 
```


### Overall Summary

##### Top RAVs by Analysis Category

| Category | Rank 1 | Score/t-stat | Rank 2 | Score/t-stat | Rank 3 | Score/t-stat |
|----------|--------|--------------|--------|--------------|--------|--------------|
| **CMS - ANOVA** | RAV249 | 807.78 | RAV514 | 732.19 | RAV687 | 689.70 |
| **CMS - Kruskal-Wallis** | RAV514 | 1889.55 | RAV249 | 1792.33 | RAV631 | 1789.89 |
| **MSI** | RAV178 | 24.94 | RAV382 | 17.36 | RAV390 | 15.32 |
| **Location** | RAV178 | 8.16 | RAV257 | 7.58 | RAV382 | 5.93 |
| **Grade** | RAV280 | 4.35 | RAV188 | 4.34 | RAV98 | 4.27 |
| **Stage** | RAV318 | 7.65 | RAV468 | 7.00 | RAV802 | 6.65 |

##### Recommended RAVs by Research Purpose

| Purpose | Primary RAV | Secondary RAV | Tertiary RAV | Rationale |
|---------|------------|---------------|--------------|-----------|
| **CMS Subtype Classification** | RAV514 | RAV249 | - | RAV514: 1st in KW; RAV249: 1st in ANOVA |
| **MSI & Location** | RAV178 | - | - | Dominant for both (t=24.94, 8.16) |
| **CMS + Grade Integration** | RAV631 | RAV637 | - | Top 6 in CMS (KW) + top 6 in Grade |
| **Stage/Progression** | RAV318 | - | - | Strongest stage discriminator (t=7.65) |
| **Comprehensive Panel** | RAV514 | RAV178 | RAV318 | Covers CMS, MSI/Location, and Stage |

##### Multi-Feature RAVs (Appear in Multiple Top-6 Rankings)

| RAV | Feature 1 | Rank | Feature 2 | Rank | Value |
|-----|-----------|------|-----------|------|-------|
| **RAV249** | CMS-ANOVA | 1st | CMS-KW | 2nd | Strong CMS discriminator |
| **RAV514** | CMS-KW | 1st | CMS-ANOVA | 2nd | Strong CMS discriminator |
| **RAV178** | MSI | 1st | Location | 1st | Immune/hypermutation signature |
| **RAV382** | MSI | 2nd | Location | 3rd | Immune-related features |
| **RAV89** | MSI | 4th | Location | 4th | Immune-related features |
| **RAV631** | CMS-KW | 3rd | Grade | 5th | Links subtype to histology |
| **RAV637** | CMS-KW | 6th | Grade | 4th | Links subtype to histology |
| **RAV105** | CMS-ANOVA | 5th | CMS-KW | 4th | Consistent CMS signal |
| **RAV135** | CMS-ANOVA | 6th | CMS-KW | 5th | Consistent CMS signal |









## For RAVmodel_ver1.1.1 (original)

### Similarity
##### PCSS1/2
```
        RAV1575
PCSS1 0.5894306
         RAV834
PCSS2 0.5624299
```

### With CMS labels
##### ANOVA
```
RAV834    RAV833    RAV861    RAV188   RAV2432    RAV579 
1216.5445  834.3780  742.6224  709.8732  656.5008  642.1502
```

##### Kruskal-Walis
```
RAV834   RAV833   RAV188   RAV579   RAV657  RAV1957 
2146.136 1831.683 1829.326 1775.702 1750.150 1693.344
```


### Clinical feature
t-statistics in their absolute values

##### MSI t-test
```
RAV834  RAV2013  RAV3599   RAV420  RAV2012   RAV517 
26.84675 23.26443 21.48882 19.01302 18.04512 17.99638 
```

##### Location t-test
```
RAV834  RAV4350  RAV2096  RAV2746  RAV2012  RAV2116 
8.758678 7.622236 7.581951 7.457431 7.418980 7.335052
```

##### Grade t-test
```
RAV596  RAV2760  RAV1059  RAV1761  RAV3704  RAV3940 
6.853383 5.364438 5.307193 5.046149 4.899141 4.696303 
```

##### Stage t-test
```
RAV3290  RAV2528   RAV234  RAV3264   RAV911   RAV766 
7.846489 7.750957 7.041752 6.947344 6.912682 6.896456 
```


### Overall Summary
##### Top RAVs by Analysis Category

| Category | Rank 1 | Score/t-stat | Rank 2 | Score/t-stat | Rank 3 | Score/t-stat |
|----------|--------|--------------|--------|--------------|--------|--------------|
| **CMS - ANOVA** | RAV834 | 1216.54 | RAV833 | 834.38 | RAV861 | 742.62 |
| **CMS - Kruskal-Wallis** | RAV834 | 2146.14 | RAV833 | 1831.68 | RAV188 | 1829.33 |
| **MSI** | RAV834 | 26.85 | RAV2013 | 23.26 | RAV3599 | 21.49 |
| **Location** | RAV834 | 8.76 | RAV4350 | 7.62 | RAV2096 | 7.58 |
| **Grade** | RAV596 | 6.85 | RAV2760 | 5.36 | RAV1059 | 5.31 |
| **Stage** | RAV3290 | 7.85 | RAV2528 | 7.75 | RAV234 | 7.04 |

##### Recommended RAVs by Research Purpose

| Purpose | Primary RAV | Secondary RAV | Tertiary RAV | Rationale |
|---------|------------|---------------|--------------|-----------|
| **CMS Subtype Classification** | RAV834 | RAV833 | - | RAV834: 1st in both ANOVA & KW (exceptionally strong) |
| **MSI & Location** | RAV834 | RAV2012 | - | RAV834 dominates both; RAV2012: 5th MSI, 5th Location |
| **CMS + All Clinical Features** | RAV834 | - | - | **Super-RAV**: 1st in CMS, MSI, and Location |
| **Grade** | RAV596 | - | - | Strongest grade discriminator (t=6.85) |
| **Stage/Progression** | RAV3290 | RAV2528 | - | Strongest stage discriminators (t=7.85, 7.75) |
| **Comprehensive Panel** | RAV834 | RAV596 | RAV3290 | Covers CMS, MSI/Location, Grade, and Stage |

##### Multi-Feature RAVs (Appear in Multiple Top-6 Rankings)

| RAV | Feature 1 | Rank | Feature 2 | Rank | Feature 3 | Rank | Value |
|-----|-----------|------|-----------|------|-----------|------|-------|
| **RAV834** | CMS-ANOVA | 1st | CMS-KW | 1st | MSI | 1st | **DOMINANT across 4 features** |
| **RAV834** | Location | 1st | - | - | - | - | (continued) |
| **RAV833** | CMS-ANOVA | 2nd | CMS-KW | 2nd | - | - | Strong CMS discriminator |
| **RAV188** | CMS-ANOVA | 4th | CMS-KW | 3rd | - | - | Consistent CMS signal |
| **RAV579** | CMS-ANOVA | 6th | CMS-KW | 4th | - | - | Consistent CMS signal |
| **RAV2012** | MSI | 5th | Location | 5th | - | - | Immune-related features |

---





## Cross-Model Comparison

##### Best Performing RAVs by Model

| Category | Model 1 | Score | Model 2 | Score | Model 3 | Score | Best Model |
|----------|---------|-------|---------|-------|---------|-------|------------|
| **CMS - ANOVA** | RAV129 | 779.91 | RAV249 | 807.78 | **RAV834** | **1216.54** | **Model 3** (+51%) |
| **CMS - Kruskal-Wallis** | RAV17 | 1798.53 | RAV514 | 1889.55 | **RAV834** | **2146.14** | **Model 3** (+19%) |
| **MSI** | RAV80 | 21.88 | RAV178 | 24.94 | **RAV834** | **26.85** | **Model 3** (+23%) |
| **Location** | RAV80 | 6.90 | RAV178 | 8.16 | **RAV834** | **8.76** | **Model 3** (+27%) |
| **Grade** | RAV305 | 4.21 | RAV280 | 4.35 | **RAV596** | **6.85** | **Model 3** (+63%) |
| **Stage** | RAV367 | 6.65 | RAV318 | 7.65 | **RAV3290** | **7.85** | **Model 3** (+18%) |

##### Top RAV Characteristics by Model

| Model | Best CMS RAV | Best Clinical RAV | Super-RAV? | Model Strength |
|-------|--------------|-------------------|------------|----------------|
| **Model 1** | RAV17 (KW) | RAV80 (MSI+Loc) | No | Specialized RAVs for different features |
| **Model 2** | RAV514 (KW) | RAV178 (MSI+Loc) | No | Stronger signals than Model 1 |
| **Model 3** | RAV834 (Both) | RAV834 (MSI+Loc) | **YES** | RAV834 dominates 4 of 6 categories |

##### Model Evolution: Discriminative Power Improvement

| Feature | Model 1 → 2 | Model 2 → 3 | Model 1 → 3 | Overall Trend |
|---------|-------------|-------------|-------------|---------------|
| **CMS (ANOVA)** | +3.6% | +50.6% | +56.0% | Major improvement in Model 3 |
| **CMS (KW)** | +5.1% | +13.6% | +19.3% | Steady improvement |
| **MSI** | +14.0% | +7.7% | +22.7% | Strong across all models |
| **Location** | +18.3% | +7.4% | +27.0% | Consistent improvement |
| **Grade** | +3.3% | +57.5% | +62.7% | Dramatic leap in Model 3 |
| **Stage** | +15.0% | +2.6% | +18.0% | Steady improvement |

##### Recommended RAV Panel by Use Case

| Use Case | Model 1 | Model 2 | Model 3 | Recommendation |
|----------|---------|---------|---------|----------------|
| **CMS Classification** | RAV17 | RAV514, RAV249 | RAV834 | **Model 3**: Single super-RAV |
| **MSI Detection** | RAV80 | RAV178 | RAV834 | **Model 3**: Highest discriminative power |
| **Clinical Integration** | RAV17, RAV80, RAV305 | RAV514, RAV178, RAV318 | RAV834, RAV596, RAV3290 | **Model 3**: Best overall |
| **Minimal Panel** | 3 RAVs | 3 RAVs | **2 RAVs** | **Model 3**: RAV834 + RAV596 covers 5 of 6 features |
| **Grade Focus** | RAV305 | RAV280 | **RAV596** | **Model 3**: 63% stronger |

---

## Key Insights

##### Model 3 Advantages:
1. **RAV834 is a "Super-RAV"** - Ranks 1st in 4 out of 6 categories (CMS-ANOVA, CMS-KW, MSI, Location)
2. **Highest discriminative power** across nearly all clinical features
3. **Most efficient** - Only 2 RAVs (RAV834 + RAV596) needed to cover 5 of 6 categories
4. **Grade discrimination improved dramatically** (+63% over Model 2)
5. **CMS discrimination substantially stronger** (+51% ANOVA, +19% KW over Model 2)

##### Model Selection Guide:
- **For comprehensive CRC analysis**: **Model 3** - RAV834 provides exceptional multi-feature coverage
- **For specialized analysis**: Model 2 still offers strong, feature-specific RAVs
- **For minimal biomarker panel**: **Model 3** - Just RAV834 + RAV596 + RAV3290 covers all bases

##### Statistical Strength Comparison:
**Model 3 > Model 2 > Model 1** across all categories, with Model 3 showing the most dramatic improvements in CMS subtype and Grade discrimination.




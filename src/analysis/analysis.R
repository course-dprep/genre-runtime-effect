# analysis.R
# Visual checks + linear models for runtime, genre, and runtime×genre moderation
# Outputs a PDF report to ../../gen/output/

library(readr)
library(tidyverse)
library(ggplot2)
library(broom)

# -----------------------------------------
# 1) Read cleaned data from gen/temp
# -----------------------------------------
IMDB_movies <- read_csv("../../gen/temp/imdb_movies.csv")
IMDB_long   <- read_csv("../../gen/temp/imdb_long.csv")

# -----------------------------------------
# 2) Create output directory & open PDF
# -----------------------------------------
dir.create("../../gen/output", showWarnings = FALSE, recursive = TRUE)
pdf("../../gen/output/analysis_report.pdf", width = 10, height = 7)

# -----------------------------------------
# 3) Create mean-centered runtime variable
# -----------------------------------------
IMDB_movies <- IMDB_movies %>%
  mutate(m_runtime = runtimeMinutes - mean(runtimeMinutes, na.rm = TRUE))

# -------------------------
# 4) GGPlot diagnostics
# -------------------------

# (A) Overall linearity: scatter + linear fit
ggplot(IMDB_movies, aes(x = runtimeMinutes, y = averageRating)) +
  geom_point(alpha = 0.05) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    x = "Runtime (minutes)",
    y = "Average rating",
    title = "Runtime vs Average Rating (Linear Fit)"
  )

# (B) By-genre linearity
ggplot(IMDB_long, aes(x = runtimeMinutes, y = averageRating)) +
  geom_point(alpha = 0.03) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ genre) +
  labs(
    x = "Runtime (minutes)",
    y = "Average rating",
    title = "Runtime vs Average Rating by Genre"
  )

# -------------------------
# 5) Linear models
# -------------------------

# Model 1: Runtime only
lm1 <- lm(averageRating ~ m_runtime, data = IMDB_movies)
summary(lm1)

# Model 2: Runtime + genres
lm2 <- lm(averageRating ~ m_runtime +
    genre_Drama + genre_Comedy + genre_Romance + genre_Action +
    genre_Thriller + genre_Crime + genre_Horror + genre_Documentary +
    genre_Adventure + genre_Mystery + genre_Family + genre_Fantasy +
    genre_Biography + `genre_Sci-Fi` + genre_History + genre_Music +
    genre_Animation + genre_War + genre_Musical +
    genre_Sport + genre_Western,
  data = IMDB_movies
)
summary(lm2)

# Model 3: Runtime × genres (includes main effects + interactions)
lm3 <- lm(
  averageRating ~ m_runtime * (
    genre_Drama + genre_Comedy + genre_Romance + genre_Action +
      genre_Thriller + genre_Crime + genre_Horror + genre_Documentary +
      genre_Adventure + genre_Mystery + genre_Family + genre_Fantasy +
      genre_Biography + `genre_Sci-Fi` + genre_History + genre_Music +
      genre_Animation + genre_War + genre_Musical +
      genre_Sport + genre_Western
  ),
  data = IMDB_movies
)
summary(lm3)

# Model comparison - ANOVA as text on PDF page
anova_result <- anova(lm1, lm2, lm3)
plot.new()
title(main = "ANOVA: Model Comparison", cex.main = 1.5)
text(0.05, 0.85, paste(capture.output(anova_result), collapse = "\n"),
     family = "mono", adj = c(0, 1), cex = 0.7)

# Compact table of runtime + runtime×genre terms from lm3
interaction_terms <- tidy(lm3, conf.int = TRUE) %>%
  filter(term == "m_runtime" | str_detect(term, "^m_runtime:genre_")) %>%
  arrange(desc(abs(estimate)))

plot.new()
title(main = "Runtime x Genre Interaction Terms (Model 3)", cex.main = 1.3)
text(0.05, 0.85, paste(capture.output(print(interaction_terms, n = Inf)), collapse = "\n"),
     family = "mono", adj = c(0, 1), cex = 0.5)

# -----------------------------------------
# Close PDF device
# -----------------------------------------
dev.off()

cat("Report saved to: ../../gen/output/analysis_report.pdf\n")

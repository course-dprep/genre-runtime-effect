# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

# Load libraries
library(readr)
library(tidyverse)


# Read data

title.basics  <- read_tsv("data/raw/title.basics.tsv.gz", na = "\\N")
title.ratings <- read_tsv("data/raw/title.ratings.tsv.gz", na = "\\N")

# Overview of titleTypes
# 
# title.basics %>%
#   group_by(titleType) %>%
#   summarise(count = n()) %>%
#   arrange(desc(count))

# Select movies only
title.basics_movies <- filter(title.basics, titleType == "movie")

# Merging the title.basics and title.ratings datasets

  IMDB_movies <- left_join(title.basics_movies, title.ratings, by = "tconst")

# Remove NA's from genres, runtimeMinutes, averageRating and numVotes
# and drop titleType, isAdult, startYear and endYear

IMDB_movies <- IMDB_movies %>%
  filter(!is.na(genres),
         runtimeMinutes <= 360,
         !is.na(averageRating),
         numVotes > 100) %>%
  select(-titleType, -isAdult, -startYear, -endYear)

# Splitting genres
IMDB_movies <- IMDB_movies %>% 
  separate_rows(genres, sep = ",") %>% 
  mutate(value = 1) %>% 
  pivot_wider(names_from = genres,
              values_from = value,
              values_fill = 0,
              names_prefix = "genre_")

#Identifying genres and counting frequency of each genre
genre_cols <- grep("^genre_", names(IMDB_movies), value = TRUE)

genre_frequency <- sort(colSums(IMDB_movies[genre_cols]), decreasing = TRUE)

genre_frequency

# % of frequency of each genre
genre_percentage <- genre_frequency / nrow(IMDB_movies) * 100

genre_percentage <- round(genre_percentage, 1)

genre_percentage


# Removing genres with frequency < 1%

genres_to_remove <- names(genre_percentage[genre_percentage < 1])
genres_to_remove

IMDB_movies <- IMDB_movies %>%
  select(-all_of(genres_to_remove))


# # Identify remaining genre columns
genre_cols_kept <- grep("^genre_", names(IMDB_movies), value = TRUE)

# Convert to long format for plotting
IMDB_long <- IMDB_movies %>%
  pivot_longer(
    cols = all_of(genre_cols_kept),
    names_to = "genre",
    values_to = "has_genre"
  ) %>%
  filter(has_genre == 1) %>%
  mutate(genre = str_remove(genre, "^genre_"))


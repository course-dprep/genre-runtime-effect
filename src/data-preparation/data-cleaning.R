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

#  List of genres
# names(IMDB_movies)[grepl("genre", names(IMDB_movies))]

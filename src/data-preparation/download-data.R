# This script will be used to populate the \data directory
# with all necessary raw data files.

# Create raw data folder
# dir.create("data/raw", showWarnings = FALSE, recursive = TRUE)

# Download data files
download.file("https://datasets.imdbws.com/title.basics.tsv.gz","../../data/raw/title.basics.tsv.gz")

download.file("https://datasets.imdbws.com/title.ratings.tsv.gz","../../data/raw/title.ratings.tsv.gz")

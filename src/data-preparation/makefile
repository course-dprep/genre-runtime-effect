#Variables
DATA = ../../data/raw
TEMP = ../../gen/temp

#Phony target to make everything in this makefile
all: $(TEMP)/imdb_long.csv $(TEMP)/imdb_movies.csv


#Step 1: download
$(DATA)/title.basics.tsv.gz $(DATA)/title.ratings.tsv.gz: download-data.R
		R -e "dir.create('$(DATA)', recursive = TRUE)"
		Rscript download-data.R

#Step 2: clean data
$(TEMP)/imdb_long.csv $(TEMP)/imdb_movies.csv: data-cleaning.R $(DATA)/title.basics.tsv.gz $(DATA)/title.ratings.tsv.gz
		R -e "dir.create('$(TEMP)', recursive=TRUE)"
		Rscript data-cleaning.R
		
		
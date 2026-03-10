#Variables
TEMP = ../../gen/temp
OUTPUT = ../../gen/output

#Target
all: $(OUTPUT)/analysis_report.pdf

#Step 1: analysis
$(OUTPUT)/analysis_report.pdf: analysis.R $(TEMP)/imdb_movies.csv $(TEMP)/imdb_long.csv
		R -e "dir.create('$(OUTPUT)', recursive=TRUE)"
		Rscript analysis.R
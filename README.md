[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/-5U7Jn2O)
> **Important:** This is a template repository to help you set up your team project.  
>  
> You are free to modify it based on your needs. For example, if your data is downloaded using *multiple* scripts instead of a single one (as shown in `\data\`), structure the code accordingly. The same applies to all other starter files—adapt or remove them as needed.  
>  
> Feel free to delete this text.


# The longer the better: the relationship between film length and audience scores between genres

*(Describe the purpose of this project)*

The goal of this project is to examine the relationship between movie running time and audience ratings, 
and how this relationship may differ between a selection of movie genres. 


## Motivation
*Provide background/motivation for your project*

*Mention your research question*

The movie industry continuously tries to understand what factors influence audience ratings, as they play a
very important role in determining commercial success and popularity. One characteristic that might impact
viewer’s perceptions is running time. Longer films can allow for more extensive storytelling and character
development, however they may also demand higher mental effort and time commitment from the audience.
As a consequence, the relationship between running time and audience ratings remains unclear and worth
looking into.

Furthermore, audience expectations on time might differ between movie genres. For instance, viewers might
expect longer runtimes in genres like drama, considering the complexity of the storyline, whereas fast paced
runtimes might be expected for low cognitive effort genres, such as comedies. Considering this, the effect of
runtime on ratings in most likely not uniform, and it might depend on viewing preferences.

<br>

**Based on these notions, the main research question that will be examined is described as:**

*- What is the relationship between running time (IV) and audience ratings (DV) in movies, and how does this differ between movie genres?*


## Data

- What dataset(s) did you use? How was it obtained?
<br>

To examine the research question, two publicly available datasets from the IMBD website
were utilized.

The data sets used:  
- https://datasets.imdbws.com/title.basics.tsv.gz  
- https://datasets.imdbws.com/title.ratings.tsv.gz  

<br>

- How many observations are there in the final dataset?


The merged dataset contains approximately 140.000 observations after filtering for movies, their running time (<=360) and number of votes (>100),
where missing values for genre's and audience ratings were filtered out.

<br>

- Include a table of variable description/operstionalisation.


The main variables that will be examined:

• Movie running time (IV) - primary runtime of the title, in minutes  
• Audience rating (DV) - weighted average of all the individual user ratings  
• Genre (Categorical Moderator) - includes up to three genres associated with the title  
  


## Method

- What methods do you use to answer your research question?

For data preparation, datawrangling principles were administered. Firstly the dataset title.basics.tsv.gz 
was filtered to only include movie titles, thereby excluding other included film-types in the dataset such 
as tv-shows and short-films. Next, the dataset title.ratings.tsv.gz was merged.
This merged dataset was structured in ascending order of release year.  

Moreover, next to flitering for missing values for genre and audience scores, the observations were filtered to
have a running time of up to 360 minutes and a minimum number of 100 recorded audience votes.


As for the method of analysis, Multiple Linear Regression (MLR) with interaction terms will be used.

<br>

- Provide justification for why it is the most suitable. 

MLR is an appropriate analysis method for a continuous IV and DV, allowing examination of interaction
terms for movie genre as a moderator.



## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)
...

- How are the findings/end product of the project deployed?
...

- Explain the relevance of these findings/product. 
...

## Repository Overview 

*Include a tree diagram that illustrates the repository structure*


```text
team-projects-team-4/
│
├── data/                    # Data-related scripts and raw data handling
│   └── download-data.R      # Script to download and store raw datasets
│
├── reporting/               # Final report and application files
│   ├── report.Rmd           # Main analysis report
│   └── start_app.R          # Possible ption to run the report using a Shiny app
│
├── src/                     # Source code
│   ├── analysis/            # Statistical modeling and analysis scripts
│   │   └── analysis.R       # Main analysis script
│   │
│   └── data-preparation/    # Data cleaning and preparation scripts
│       └── data-cleaning.R  # Data cleaning script
│
├── README.md                # Project documentation
├── README.html              # Rendered version of README
├── makefile                 # Workflow automation
├── .gitignore               # Files excluded from version control
└── team-projects-team-4.Rproj  # RStudio project file
```


## Dependencies 

*Explain any tools or packages that need to be installed to run this workflow.*

The main packages needed to run this workflow:

- library(readr) - used to read selected datasets  
- library(tidyverse) - used for data wrangling and analysis  

## Running Instructions 

*Provide step-by-step instructions that have to be followed to run this workflow.*

...



## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 4, members: < insert member details>

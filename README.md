# SQL Mini Project Using Covid Data
## Motivation
This project was inspired by Alex the Analyst. The goal is to use SQL to do exploratory analyst as well as create visualizations from SQL queries. 

## Data Tools
The queries were done in Google Big Query(GBQ) and the data was downloaded from https://ourworldindata.org/covid-deaths. The data is also included into this repository as the downloaded data acquired from link will pull the full dataset from the beginning of the pandemic until the day that the information is pulled. The file in this repository spans from 2/3/2020 to 10/17/2022.

To note about GBQ: Due to using GBQ, there were some tweaks that had to be made since in the video, Microsoft SQL Server was used. The way that data gets imported to GBQ is different and the covid file was fairly sizeable. Due to the size of the file, it was unable to open in google sheets or free online excel. I would highly recommend using whatever SQL server tool is at your disposal. 

## Data Understanding
The queries that are given show interesting information. These two pictures are a snippet of the some of information that can come from the SQL queries.
![](images/us_infection_percentage.png)
![](images/global_dp.png)

In the first image, it shows the total infection percentage of the US. It was done by taking the total cases and dividing it by the population. The result shows that the US has as of this 10/17, an ~28.77 total infection rate. 

The second image shows the total death percentage for all global cases. It took an accumulation of all of the new cases (daily) and dividing it by an accumulation of all of the new deaths (daily). That percentage stands at ~1%


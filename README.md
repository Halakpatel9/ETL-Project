# ETL-Project
# ETL-Project By Harneet, Mohamed and Halak

####Gun Violence in Tri State Area

####Project Summary and Objective:
Gun Violence in recent times has increased substantially. The urgency to educated people and report possible reason is a need of the hour. Head Anchor of ANN (American National News) Channel has tasked our team to provide a report with analysis and possible areas which could explain reasons or factors that could attribute towards Gun Violence.

We are providing a pipeline that will allow the Head Anchor to understand the story by looking into the Sources where we pulled the data from and findings. We used multiple sources to obtain data including Unemployment Rate Data and Gun Violence Data. The data available from our sources was in .csv format and we choose to use SQL for performing Extraction, Transformation and Load (ETL) process. To complete the story, we used Excel to demonstrate a graphical representation of the final data.


####Scope of the project:
- Use the unemployment data for Tri State (New York, New Jersey and Pennsylvania)
- Use the unemployment data for year 2018 and 2019
- Use the Gun Violence data for Tri State
- Use the Gun Violence Data for year 2018 and 2019


####Steps to Run Pipeline
1)	Clone the repository to your local drive
2)	Start MySQL Workbench and connect to your local database
3)	Run gun_violence_analysis.sql
a.	This will create gun_violence_src schema with all source and target tables.


####Data Sources
Source 1: Gun Violence Data (https://www.gunviolencearchive.org/) – The source had all state Gun violence data. The data was in the .csv format. We saved the file to local drive and imported to SQL using the import wizard. We downloaded a total of 2 files with Mass shooting data. First file contained 2018 data and second file contained 2019 data for all states in the USA.

Source 2: Unemployment Data (https://www.bls.gov) - The source had all state Unemployment Data. The data was in the .csv format. We saved the file to local drive and imported to SQL using the import wizard. We downloaded an aggregate data of tri state for the year 2018 and 2019.


####Data Model
Contains Source Schema tables and Target Schema tables. This can be viewed in the image folder in the Repo.


####Transformation Tool Selection
We choose the SQL as a main tool to perform the ETL process for following key reasons:
1)	Source data was only available in .csv format
2)	The quickest way to provide the finished data
3)	Ease of use and execution of the code

####Transformations applied:
•	We Imported 3 files into SQL using Import Wizard. Once the file was loaded and tables were generated, we began the transformation by writing SQL script.
•	We had to write date transformation logic to bring dates to one consistent format of MMYYYY across all data files from both data sources
•	Mass shooting data is:
o	Filtered for NY, NJ, PA
o	Aggregated (Sum of shootings, and count of mass shootings) all 3 states Metrics to Tri-State for Tri State Analysis
•	BLS Unemployment Data is:
o	Filtered for NY, NJ, PA
o	Aggregated (average unemployment rate for Tri-State) all 3 states Metrics to Tri-State for Tri State Analysis
o	Additional data clean up performed prior to aggregation:
	Removed letter ‘M’ from the Period column.
	Concatenated the year and period column.
•	Lastly in the Target we had 2 final tables
o	Table 1 – was unemployment table consisting of Date, Area and Unemployment rate
o	Table 2 – Date, Area, Total Mass Shootings, Mass Shooting Injury, Mass Shooting Death


Create Database gun_violence_SRC;

use gun_violence_SRC;

-- CREATE SOURCE SCHEMA TABLES

CREATE TABLE `mass_shoots_2018` (
  `Incident_Date` text,
  `State` text,
  `City Or County` text,
  `Address` text,
  `Num_Killed` int(11) DEFAULT NULL,
  `Num_Injured` int(11) DEFAULT NULL,
  `Operations` text
) ;

CREATE TABLE `mass_shoots_2019` (
  `Incident_Date` text,
  `State` text,
  `City Or County` text,
  `Address` text,
  `Num_Killed` int(11) DEFAULT NULL,
  `Num_Injured` int(11) DEFAULT NULL,
  `Operations` text
) ;

CREATE TABLE `tri_state_unemployment` (
  `Series ID` text,
  `Year` int(11) DEFAULT NULL,
  `Period` text,
  `Label` text,
  `Value` double DEFAULT NULL,
  `12-Month % Change` double DEFAULT NULL
);

-- USE SQL WORKBENCH IMPORT TO IMPORT DATA FROM CSV FILES

-- NOW CREATING TARGET SCHEMA TABLES

CREATE TABLE `unemployment_rate` (
  `Month_Year` char(6) NOT NULL,
  `Geo_Area` varchar(50) NOT NULL DEFAULT 'Tri-State',
  `Unemployment_Rate` float DEFAULT NULL,
  PRIMARY KEY (`Month_Year`,`Geo_Area`)
) ;

CREATE TABLE `gun_violence_summary` (
  `Shoot_MMYYYY` char(6) NOT NULL,
  `Geo_Area` varchar(50) NOT NULL DEFAULT 'Tri-State',
  `Tot_Mass_Shoots` int(11) DEFAULT NULL,
  `Mass_Shoots_Injuries` int(11) DEFAULT NULL,
  `Mass_Shoots_Deaths` int(11) DEFAULT NULL,
  PRIMARY KEY (`Shoot_MMYYYY`,`Geo_Area`)
) ;

-- Transform data from Mas_Shoots_2018 and Mass_Shoots_2019
-- Tranforming Date from Text to Date Format and aggregating at MMYYYY
-- Calculating total number of Mass_Shootings aggregating number of incidents 

INSERT into gun_violence_summary
(Shoot_MMYYYY,  Mass_Shoots_Deaths, Mass_Shoots_Injuries, Tot_Mass_Shoots)
select distinct Date_format(STR_TO_DATE(Incident_Date,'%M %d,%Y'), '%m%Y') as 'Shoot_MMYYYY',
sum(Num_killed) as 'Mass_Shoot_Deaths' ,
sum(Num_Injured) as 'Mass_Shoots_Injuries', 
count(*) as 'Tot_Mass_Shoots'
From mass_shoots_2018
where state in ('New Jersey', 'New York', 'Pennsylvania') 
group by Date_format(STR_TO_DATE(Incident_Date,'%M %d,%Y'), '%M%Y')
UNION ALL
select distinct Date_format(STR_TO_DATE(Incident_Date,'%m/%d/%Y'), '%m%Y') as 'Shoot_MMYYYY',
sum(Num_killed) as 'Mass_Shoot_Deaths' ,
sum(Num_Injured) as 'Mass_Shoots_Injuries', 
count(*) as 'Tot_Mass_Shoots'
From mass_shoots_2019
where state in ('New Jersey', 'New York', 'Pennsylvania')
group by Date_format(STR_TO_DATE(Incident_Date,'%m/%d/%Y'), '%M%Y');


-- Transform Unemployment Data frpm Columns to Rows

Insert into unemployment_rate (Month_Year,Unemployment_Rate)
SELECT distinct concat(substr(`tri_state_unemployment`.`Period`,2,2),`tri_state_unemployment`.`Year`) as 'Month_Year',
    avg(`tri_state_unemployment`.`Value`) as 'Unemployment_Rate'
    FROM `gun_violence_src`.`tri_state_unemployment`
    where `tri_state_unemployment`.`Year` in ('2018','2019')
group by concat(substr(`tri_state_unemployment`.`Period`,2,2),`tri_state_unemployment`.`Year`)
;




-- select distinct Date_format(STR_TO_DATE(Incident_Date,'%m/%d/%y'), '%m%Y') as 'Shoot_MMYYYY',
select Date_format(STR_TO_DATE(Incident_Date,'%m/%d/%Y'), '%m%Y') as 'Shoot_MMYYYY'
From mass_shoots_2019
where state in ('New Jersey', 'New York', 'Pennsylvania')

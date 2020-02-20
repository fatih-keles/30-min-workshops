# 30 Minutes Workshop: Develop a Movie Application with Apex

## Purpose
You will develop a web application with a dashboard, calendar and faceted search page in 30 minutes. 

The original demonstration belongs to my colleague Shakeeb Rahman and you can watch it [here](https://youtu.be/VlYa5xkF_kE "Low Code App Dev with Oracle APEX: Building a Simple Movie App") on 
Oracle Application Express youtube [channel](https://www.youtube.com/channel/UCEpIXFjcQIztReQNLymvYrQ).

## Prerequsites
1. Create Free Oracle Cloud account, start [here](https://www.oracle.com/cloud/free/ "Oracle Free Tier"). 

It is totaly free, takes less than two minutes. Credit card information is required to verify your identity, no charges will be incurred. You will get
  * 2 Oracle Autonomous Databases
  * 2 Virtual Machines 
for free for life as long as you use them.

2. Download [this csv file](./resources/tmdb-movies_smaller.csv "CSV file") which I downloaded from [The Movie Database](www.themoviedb.org).

### Steps
1. [Create Autonoumous Database](#1-create-autonoumous-database-2-min)
2. [Create Apex Workspace](#2-create-Apex-Workspace-40-sec)
3. [Load CSV File](#3-load-csv-file-1-min) 
4. [Create Application](#4-create-application-1-min) 
5. [Run Application for the First Time](#5-run-application-for-the-first-time-1-min) 
6. [Calendar Page](#6-calendar-page-1-min)
7. [Dashboard](#7-dashboard-6-min)
	- [Chart Genres](#71-chart-genres-1-min)
	- [Chart Runtime](#72-chart-runtime-1-min)
	- [Chart ROI](#73-chart-roi-2-min)
	- [Chart Major Producers](#74-chart-major-producers)

### 1. Create Autonoumous Database (2 min)
Create your autonomous database in your cloud account. The interface is very intuitive. Follow screen instructions. If you need help press help button on the very same screen.

*Control click the below screenshot to see the video*
[![Create Autonoumous Database](./resources/create-autonomous-database.jpg)](https://youtu.be/_cdAjzawbU0)

[^ back](#steps)

### 2. Create Apex Workspace (40 sec)
Login with **ADMIN** user and create an Apex workspace. By doing this you will also be creating a database schema. 

*Control click the below screenshot to see the video*
[![Create Apex Workspace](./resources/create-apex-workspace.jpg)](https://youtu.be/wgCU4hkMtvw)

[^ back](#steps)

### 3. Load CSV File (1 min)
Logout from *Administration Services* and login using *Workspace Sign-In*

Login with **DEMO** user and load [CSV file](./resources/tmdb-movies_smaller.csv "CSV file")

*Control click the below screenshot to see the video*
[![Create Apex Workspace](./resources/load-csv-file.jpg)](https://youtu.be/EwXDxuooNug)

[^ back](#steps)

### 4. Create Application (1 min)
After loading csv file data into **movies** table, create application. Apex analyzes data and suggests you the best possible page options you may want to create. In this example we will have
 - Home Page (Blank)
 - Dashboard Page (With charts offered by Apex)
 - Movies Search (A faceted search page new in Apex 19.2)
 - Movies Report (A tabular report page which we will turn into fancy cards)
 
Most of the work will be done by automatically by Apex. We will interfere very little. 
 - First inspect **Dashboard** page by clicking **Edit** and see what charts are suggested by Apex by just looking at your data and learning about it. We are going to change suggested charts with the ones that display our information of interest. 
 - Then edit the **Faceted Search Page**, change page type from reports to cards. Set the following 
 ```
 Card Title: Title
 Description Column: Tagline
 Additional Text Column: Overview
 ```
 - Check **Movies Report** page
 - There is another page called **Calendar**
 - Click **Check All** Features
 - Create application 
 
*Control click the below screenshot to see the video*
[![Create Application](./resources/create-application.jpg)](https://youtu.be/q2Fm9OvrQEs)

[^ back](#steps)
 
### 5. Run Application for the First Time (1 min)
Now lets run the application for the first time and see what Apex has done for us. 
 - Login to application with **DEMO** user
 - Navigate to **Dashboard** and inspect the charts suggested by Apex.
 - Navigate to **Movies Search** page and see the faceted search and card tiles.
 - See **Movies Report** page, which looks like a regualar tabular report page.
 - Inspect **Calendar** page see how the movies are placed on calendar according to release date.
 
*Control click the below screenshot to see the video*
[![Run Application First Time](./resources/run-application-first-time.jpg)](https://youtu.be/Smrt0Qtnadc)

[^ back](#steps)
 
### 6. Calendar Page (1 min)
Lets start with an easy fix, current calendar page doesn't display movie titles. 
 - Navigate to Calendar page
 - Click **Quick Edit** on the developer toolbar at the bottom of the page and then click anywhere on the calendar. This will take you to calendar page in the editor.
 - Hide empty positions on the layout menu, this will simplify the page layout.
 - Select Calendar > Attributes under Content Body on the left panel, then change settings on the right panel
``` 
Display Column: TITLE 
```
 - Save and run the page to see what changed

*Control click the below screenshot to see the video*
[![Edit Calendar Page](./resources/calendar-page.jpg)](https://youtu.be/WpJa9wHkcF4)

[^ back](#steps)

### 7. Dashboard (6 min)
Apex suggested a good start for our dashboard, we will improve the page for finding answers to the following questions.
 1. What are the most popular genres?
 2. What is the average movie length?
 3. Which type of movies has a better return on investment?
 4. Who are the major producers, how are they compared?

Use the application builder and edit dashboard with page designer.

#### 7.1. Chart Genres (1 min)
  - Use this sql for series data source
```sql
select GENRE, count(*) value
from MOVIES
where 1=1
and genre is not null
and genre != '"'
group by GENRE
order by 2 desc
```
 - Make these changes on the first chart
```
Region.Title: Genres
Region.Attributes.Chart Type: Pie
Region.Series.[0].Column Mapping.Label: GENRE
Region.Series.[0].Column Mapping.Value: VALUE
Region.Series.[0].Label.Show: Yes
Region.Series.[0].Label.Display As: Label
```

*Control click the below screenshot to see the video*
[![Chart Genres](./resources/edit-dashboard-genres.jpg)](https://youtu.be/WpJa9wHkcF4)

[^ back](#steps)

#### 7.2. Chart Runtime (1 min)
 - Use this sql for series data source
```sql
select runtime, count(*) value
from MOVIES
where 1=1
and runtime != 0
group by runtime
order by 1 asc
```
 - Make these changes on the second chart
```
Region.Title: Runtime
Region.Attributes.Chart.Type: Bar
Region.Series.[0].Column Mapping.Label: RUNTIME
Region.Series.[0].Column Mapping.Value: VALUE
Region.Series.[0].Performance.Maximum Rows to Process: Null
Region.Axes.x.Title: Minutes
```

*Control click the below screenshot to see the video*
[![Chart Runtime](./resources/edit-dashboard-runtime.jpg)](https://youtu.be/rRWLwI6fLl8)

[^ back](#steps)

#### 7.3. Chart ROI (2 min)
 - This chart is going to be a little complicated. We want to see how much is spend on each genre and how it is paying off. 
 - We will use 3 series, **Budget** and **Revenue** share the same y-axis whereas **ROI** uses the y2-axis as it is more like a percent
```
Region.Title: Return
Region.Attributes.Chart.Type: Combination
Region.Attributes.Tooltip.Show Group Name: False
```
 - Use the following sql for each series.
```sql 
select genre, avg(budget) avg_budget, avg(revenue) avg_revenue, trunc(sum(revenue)/sum(budget)*100, 2) avg_return
from MOVIES
where 1=1
and genre is not null
and genre != '"'
and nvl(budget,0) > 0 
group by genre
order by 4 asc
```
 - Add Budget and Revenue Series 
```
Region.Series.[Budget|Revenue].Identification.Name: Budget|Revenue
Region.Series.[Budget|Revenue].Identification.Type: Bar 
Region.Series.[Budget|Revenue].Column Mapping.Label: GENRE
Region.Series.[Budget|Revenue].Column Mapping.Label: AVG_BUDGET|AVG_REVENUE
```
 - Add ROI Series and set **Assigned To Y2 Axis** to true
```
Region.Series.[ROI].Identification.Name: ROI
Region.Series.[ROI]].Identification.Type: Line 
Region.Series.[ROI]].Column Mapping.Label: GENRE
Region.Series.[ROI].Column Mapping.Label: AVG_RETURN
Region.Series.[ROI].Appearance.Assigned To Y2 Axis: True
```
 
*Control click the below screenshot to see the video*
[![Chart ROI](./resources/edit-dashboard-roi.jpg)](https://youtu.be/qdY-XIH6y04)

[^ back](#steps)

#### 7.4. Chart Major Producers (2 min)
 - In this chart we are going to display 4 different information and relationhips, so we are using a bubble chart.
 - Use this query for series data source
```sql
select production_company, sum(budget) budget, sum(revenue) revenue, count(*) ctr
from MOVIES
where 1=1
and production_company is not null
and production_company != '"'
group by production_company
order by 2 desc
```
 - Use the following settings
```
Region.Title: Producers
Region.Attributes.Chart.Type: Bubble
Region.Attributes.Tooltip.Show Group Name: No
Region.Series.[0].Column Mapping.Series Name: Production_Company
Region.Series.[0].Column Mapping.Label: Production_Company
Region.Series.[0].Column Mapping.X: CTR
Region.Series.[0].Column Mapping.Y: SUM(Budget)
Region.Series.[0].Column Mapping.z: SUM(Revenue)
Region.Series.[0].Performance.Maximum Rows to Process: 30
Region.Axes.x.Title: #Movies
Region.Axes.y.Title: Budget
```

*Control click the below screenshot to see the video*
[![Chart Producers](./resources/edit-dashboard-producers.jpg.jpg)](https://youtu.be/_lEY1nDCRq8)

[^ back](#steps)
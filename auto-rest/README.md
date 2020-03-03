# 30 Minutes Workshop: Use Rest Services Instantly
*Control click the below screenshot to see the video*

## Purpose
You will see how you can publish *Rest Services* instantly as you create your tables using Auto Rest feature. 

This demonstration aims to show it is easy to integrate and connect your applications in modern day microservices environment. 

## Prerequsites
1. Create Free Oracle Cloud account, start [here](https://www.oracle.com/cloud/free/ "Oracle Free Tier"). 

It is totaly free, takes less than two minutes. Credit card information is required to verify your identity, no charges will be incurred. You will get
  - 2 Oracle Autonomous Databases
  - 2 Virtual Machines 
for free for life as long as you use them.

2. Download [Postman](https://www.postman.com/downloads/ "Download Postman") or have [curl](https://curl.haxx.se/) on your environment. 
 - I generally have [GitHub Desktop](https://desktop.github.com/) and/or [Anaconda Python Distrubution](https://www.anaconda.com/distribution/)  on my environment, both of them bring curl support.
 - I also use Python json tools and/or [jq](https://stedolan.github.io/jq/) to format raw json output 
```console
curl url  | python -mjson.tool
curl url  | jq
```

## Steps
1. [Create Autonoumous Database](#1-create-autonoumous-database-2-min)
2. [Create APEX Workspace](#2-create-apex-workspace-40-sec)
3. [Load CSV File](#3-load-csv-file-1-min) 
4. [Create Application](#4-create-application-1-min) 
5. [Run Application for the First Time](#5-run-application-for-the-first-time-1-min) 
6. [Calendar Page](#6-calendar-page-1-min)
7. [Dashboard](#7-dashboard-6-min)
	- [Chart Genres](#71-chart-genres-1-min)
	- [Chart Runtime](#72-chart-runtime-1-min)
	- [Chart ROI](#73-chart-roi-2-min)
	- [Chart Major Producers](#74-chart-major-producers-2-min)
8. [Report Page](#8-report-page-5-min)
9. [Faceted Search Page](#9-faceted-search-page-8-min)

##  1. Create Autonoumous Database (2 min)
Create your autonomous database in your cloud account. The interface is very intuitive. Follow screen instructions. If you need help press help button on the very same screen.

*Control click the below screenshot to see the video*
[![Create Autonoumous Database](./resources/create-autonomous-database.jpg)](https://youtu.be/_cdAjzawbU0)

[^ back](#steps)

##  2. Create APEX Workspace (40 sec)
Login with **ADMIN** user and create an APEX workspace. By doing this you will also be creating a database schema. 

*Control click the below screenshot to see the video*
[![Create APEX Workspace](./resources/create-apex-workspace.jpg)](https://youtu.be/wgCU4hkMtvw)

[^ back](#steps)

##  3. Create Your Tables (1 min)
Logout from *Administration Services* and login using *Workspace Sign-In*

Login with **DEMO** user and create your data structure. For ease of use I will use *Sql Workshop > Utilities > Quick SQL* tool. The below snippet generates SQL for us, tables, triggers, even generates sample data. *Save SQL Script* then *Review and Run*. 
```
departments /insert 4
   name /nn
   location
   country
   employees /insert 25
      name /nn vc50
      email /lower
      salary num
      date hired
      job vc255

view emp_v departments employees
```


*Control click the below screenshot to see the video*
[![Create APEX Workspace](./resources/load-csv-file.jpg)](https://youtu.be/EwXDxuooNug)

[^ back](#steps)

##  4. Register Schema with ORDS (1 min)
Navigate to *Sql Workshop > RESTful Services* and *Register Schema with ORDS*. I didn't want to *Install Sample Service* and set *Authorization Required for Metadata Access* to false for the sake of simplicity.

[^ back](#steps)

##  5. Enable REST on Objects (1 min)
*Sql Workshop > Object Browser* and  under *REST* tab *Rest Enable Object*s that you just created. I disabled *Authorization Required* option for development purposes. Copy your *RESTful URI* for your objects. 

The URL for services should be in the following form:
```
https://%SERVER_URL%/ords/%SCHEMA_NAME%/%OBJECT_NAME%/
```

[^ back](#steps)

## 6. Discover Services 
There is a metadata service for discovering service and objects. The URL should be ```https://%SERVER_URL%/ords/%SCHEMA_NAME%/metadata-catalog/``` for services and ```https://%SERVER_URL%/ords/%SCHEMA_NAME%/metadata-catalog/%OBJECT_NAME%/``` for the objects.

Use following command to see what services are provided.
```console
curl --request GET https://%SERVER_URL%/ords/demo/metadata-catalog/ | jq
```

Use metadata services you obtained from the previus call for getting object details.
```
curl --request GET https://%SERVER_URL%/ords/demo/metadata-catalog/departments/ | jq
```

Now lets see what methods are available for *DEPARTMENTS* service.
```sql
SELECT *
  FROM user_ords_services
 WHERE name = 'DEPARTMENTS'
```
You will see 2 GET, 2 POST, 1 PUT and 2 DELETE methods are available.

[^ back](#steps)

## 7. Test Services 
It is time to test our services. I am using *Postman* or *curl*. You can download [Postman Collection](./resources/Set-4.postman_collection.json "Postman Collection") and edit/create your environment to set *service_endpoint* variable. The collection is parametrized with this variable. If you need more help see [Postman Help](https://learning.postman.com/docs/postman/variables-and-environments/variables/)

Set **SERVER_URL** environment variable for running *curl* commands.

## 7.1. GET departments

We can get a **list** of departments. Service has a builtin paging capability and guides you with *hasMore*, *limit*, *offset*, *count* attributes. It contains links to first, next/previous page as well as metadata service. You can explore the results.
```console
curl --location --request GET "https://%SERVER_URL%/ords/demo/departments/" | jq
```

Also you can run **queries** for searching your data with query string in the url and json formatted where clauses.

For accessing one record you can pass **primary key** for the object as a **path variable**.

## 7.1. POST departments
There are two types of post operations that can be used for inserting records. First one is JSON object as raw body 
```
curl --location --request POST "https://%SERVER_URL%/ords/demo/departments/" --header "Content-Type: application/json" --data-raw "{'name': 'EMEA Human Resources', 'location': 'Bucharest', 'country': 'Romania'}"
```

[^ back](#steps)
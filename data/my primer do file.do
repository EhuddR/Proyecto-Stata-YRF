 
/*Introduction to Stata
NYU Data Services
Last Updated: January 2020

Tutorial Outline:

	* Basic set up of STATA including the use of commands, menus, and do files
	* Opening a dataset
	* Browsing and editing a dataset
	* Creating and recoding variables
	* Performing basic statistical analyses
	* Basic graphing commands
*/

version 14.0

********************************************************************************
* Part I - Basic Setup
********************************************************************************

* 5 "Windows"

	* Command
	* Results
	* Review
	* Variables
	* Properties

* Working Directory

	* Menu: "File" --> "Change working directory" --> select directory
	* Command Line:

		* pwd 	// Print working directory
		* cd	// Change directory
		
cd "C:\Users\HP\Documents\YRF Intro to Stata\Class 1 Intro to Stata"
pwd
dir
		* dir 	// List the files in your current directory

* Running Commands

	* 1. Menus
	* 2. Command line
	* 3. Do files (.do; doedit "Syntax.do")

		* A text file (commands, comments, syntax) for managing and analyzing data (syntax highlighting).
			
			* Organize data analysis (steps/sections)
			* Provide a record of the analysis 
			* Automate analysis
			
********************************************************************************
*Part II - Open a Dataset in Stata
********************************************************************************

* How to Open a dataset

	* 1. Double click the dataset 
	* 2. Navigate to the directory/file using menus
	* 3. Set working directory, and import dataset using command line

* Commands related to opening files

* clear			// Clear dataset form Stata's memory
* use 			// Read Stata files (.dta)
* help 			// Opens help file, invaluable! 

use "Dataset.dta", clear  

* Log Files
log using "myDatasetLog", replace // Opens a log file which captures your output

********************************************************************************
* Part III Exploring the data set
********************************************************************************

// 1. Opens data in Data Browser, user cannot modify or change

br
browse income age pizza
browse income age if age > 40

// 2. Open data in Data Editor, user can make changes to data 

edit	

// 3. Displays observations in the results screen

list
list income age if age > 40
list age if ID == "Jane"

// 4. Describe variables

describe 
describe pizza

// 5. Describe data contents, displays label mapping

codebook 			
codebook female

// 6. Obtain summary statistics

summarize 			
sum
summarize income
summarize income, detail

// 7. Obtain frequencies, create crosstabs (categorical variables)
			
tabulate female 	//obtain frequencies
tab female
tabulate female hs 	//crosstabs of frequences




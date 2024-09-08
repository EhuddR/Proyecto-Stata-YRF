/* 
Introduction to Stata
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

browse	
browse income age pizza
browse income age if age > 40 // subset

// 2. Open data in Data Editor, user can make changes to data 

edit	

// 3. Displays observations in the results screen

list	
list income age if age > 40

*list age if ID == Jane // type mismatch, ID is a string variable
list age if ID == "Jane" 

// 4. Describe variables

describe 
describe pizza

// 5. Describe data contents, displays label mapping

codebook 			
codebook female

// 6. Obtain summary statistics

summarize 			
summarize income
summarize income, detail

// 7. Obtain frequencies, create crosstabs (categorical variables)
			
tabulate female 	//obtain frequencies
tabulate female hs 	//crosstabs of frequences

// 8. Create custom table of summary statistics (continuous variables)

tabstat income, by(female) //descriptive stats
tabstat income, stats(mean sd) by(female)

*
* Exercise 1: Summarize pizza
*

* Summary
* browse, edit, list, describe, codebook, summarize, tabulate, tabstat

********************************************************************************
* Part IV Recoding and Creating New Variables
********************************************************************************

*generate			// Create a new variable
*egen 				// Create a new variable      
*replace			// Update existing values of a variable

*label variable		// Apply a label to a variable
*label define		// Create a value label
*label values		// Apply the value labels previuosly define

*** 1. Recode Values of a Variable
replace age = . if age == -1

	*** =  "set age equal to ."
	*** == "if age is equal to" - evaluates expression

*** 2. Create New Variables
generate MonthlyPizza = pizza / 12
browse

*
* Exercise 2: Create a WeeklyPizza variable
*

*** 3. Create a single variable from "dummy" variables (which indicates membership)

generate Education = .
replace Education = 1 if hs == 1
replace Education = 2 if college == 1
replace Education = 3 if grad == 1
replace Education = 0 if (hs == 0 & college == 0 & grad == 0)

codebook Education

*** 4. Label variable and variable values

label variable Education "Highest Education Achieved"
label define eduLabel 0 "Less than High School" 1 "High School" 2 "Undergraduate Degree" 3 "Graduate Degree"
label values Education eduLabel

codebook Education

tab Education
tab Education, nolabel

*** 5. Create a categorical variable from a continuous variable

generate AgeCat = .
replace AgeCat = 1 if age <27 // 18-26
replace AgeCat = 2 if (age >= 27 & age < 35)	// 27-34
replace AgeCat = 3 if (age >= 35 & age < 45) 	// 35-44
replace AgeCat = 4 if (age >= 45) & age ~=.  	// >44

browse AgeCat
codebook AgeCat

*
* Exercise 3: Define and apply a set of value labels for AgeCat
*

*** 6. Create a new variable with egen
egen avgSalary = mean(income), by(Education)
graph bar avgSalary, over(Education)

********************************************************************************
* Part V Introduction to Analytical Statistics 
********************************************************************************

*** Correlation (relationship)
correlate income age

* or

pwcorr income age, sig

*** T-test (difference between two groups)
ttest pizza, by(female)

*** Simple Linear Regression (predictive model)
regress income age

* Send regression output to document
ssc install asdoc // user written command
asdoc regress income age


********************************************************************************
* Part VI Graphs in STATA
********************************************************************************

*** Histogram (distribution of data)

histogram pizza
hist pizza, freq
graph save "pizza.gph", replace
graph export "pizza.png", replace

*** Scatterplot

twoway scatter pizza income
twoway scatter pizza income || lfit pizza income

*** Bar graph

graph bar income, over(AgeCat)


*
* Exercise 4: Create a histogram of age
*

********************************************************************************
* Part VII "Cleaning up shop"
********************************************************************************
br
save “DatasetNew”, replace
log close

***Please Fill Out Tutorial Evaluation***

********************************************************************************
* Exercise Solutions
********************************************************************************

/*
*** Exercise 1: Summarize pizza

summarize pizza

*** Exercise 2: Create a WeeklyPizza variable

gen WeeklyPizza = pizza / 52

*** Exercise 3: Define and apply a set of value labels for AgeCat

label variable AgeCat "AgeCategory"
label define AgeLabel 1 "Less than 27" 2 "27-34" 3 "35-44" 4 "45 & over"
label values AgeCat AgeLabel

*** Exercise 4: Create a histogram of age

hist age, freq normal title("Histogram of Age")
*/

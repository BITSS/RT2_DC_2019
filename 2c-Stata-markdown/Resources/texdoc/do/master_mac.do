/*******************************************************************************
*							  DIME Analytics								   *
*   					  DYNAMIC DOCUMENTS IN STATA						   *
*   							   2019										   *
********************************************************************************

	** OUTLINE:		PART 1:  INSTALL NECESSARY PACKAGES  	
					PART 2:  SET DIRECTORIES	
					PART 3:  COPY stata.sty		
					PART 4:  CREATE DOCUMENT			
				  
	** WRITEN BY:   Luiza Andrade (lcardoso@worldbank.org)


********************************************************************************
					   INSTALL NECESSARY PACKAGES  							   
********************************************************************************/
	
	* Install necessary packages
	ssc install texdoc				// Write a .tex document from Stata
	ssc install texify				// Compile the document into PDF

/*******************************************************************************
							SET DIRECTORIES					   
********************************************************************************/

	* Set folder paths
	global 	project_folder 	"ADD/FOLDER/PATH"
	global	do				"${project_folder}/do"
	global	output			"${project_folder}/output"

/*******************************************************************************
							COPY stata.sty				   
********************************************************************************
	This is a tex style to format stata code. It can be donwloaded as below 
	and needs to be saved in the same folder as your .tex file. You can also
	copy it to wherever your tex styles are saved and then you only need to 
	do it once. If you can figure out where that is.
	
	This file is already on the GitHub folder (as the code below may break),
	but this is how we got it originally.	
------------------------------------------------------------------------------*

	* Change current directory to the directory where the .tex file will be saved
	cd 	"${output}"
	
	* Copy the style to the folder path
	copy 	"https://www.stata-journal.com/production/sjlatex/stata.sty"	"stata.sty"

*******************************************************************************
							CREATE DOCUMENT			   
*******************************************************************************/

	* Write a .tex file
	texdoc do		"${do}/main_doc.do", replace
	
	* Compile the .tex file into PDF on Mac:
	* 1. Open `terminal`
	* 2. type `which pdflatex`
	* 3. Copy the path to the binary file
	! PATH/TO/BINARY "${output}/main_doc.tex/"
	
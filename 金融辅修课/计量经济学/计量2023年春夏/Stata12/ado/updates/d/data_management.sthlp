{smcl}
{* *! version 1.0.2  05aug2011}{...}
{vieweralsosee "[D] data management" "mansection D datamanagement"}{...}
{viewerjumpto "Description" "data##description"}{...}
{viewerjumpto "Reference" "data##reference"}{...}
{title:Title}

{pstd}
{manlink D data management} {hline 2} Introduction to data-management commands{p_end}


{marker description}{...}
{title:Description}

{pstd}
This manual, called [D], documents Stata's data-management features.  See
{help data##M2010:Mitchell (2010)} for additional information and examples on
data management in Stata.

{pstd}
Data management for statistical applications refers not only to classical data
management -- sorting, merging, appending, and the like -- but also to data
reorganization because the statistical routines you will use assume that the
data are organized in a certain way.  For example, statistical commands that
analyze longitudinal data, such as {helpb xtreg}, generally require that the
data be in long rather than wide form, meaning that repeated values are
recorded not as extra variables, but as extra observations.

{pstd}
Here are the basics everyone should know:

{p2colset 9 35 37 2}{...}
{p2col :{helpb use}}Load Stata dataset{p_end}
{p2col :{helpb save}}Save Stata dataset{p_end}
{p2col :{helpb describe}}Describe data in memory or in file{p_end}
{p2col :{helpb codebook}}Describe data contents{p_end}
{p2col :{helpb inspect}}Display simple summary of data's attributes{p_end}
{p2col :{helpb count}}Count observations satisfying specified conditions{p_end}
{p2col :{helpb data}}types Quick reference for data types{p_end}
{p2col :{helpb missing values}}Quick reference for missing values{p_end}
{p2col :{helpb datetime}}Date and time values and variables{p_end}
{p2col :{helpb list}}List values of variables{p_end}
{p2col :{helpb edit}}Browse or edit data with Data Editor{p_end}
{p2col :{helpb varmanage}}Manage variable labels, formats, and other properties{p_end}
{p2col :{helpb rename}}Rename variable{p_end}
{p2col :{helpb format}}Set variables' output format{p_end}
{p2col :{helpb label}}Manipulate labels{p_end}


{pstd}
You will need to create and drop variables, and here is how:

{p2col :{helpb generate}}Create or change contents of variable{p_end}
{p2col :{helpb functions}}Functions{p_end}
{p2col :{helpb egen}}Extensions to generate{p_end}
{p2col :{helpb drop}}Eliminate variables or observations{p_end}
{p2col :{helpb clear}}Clear memory{p_end}


{pstd}
For inputting or importing data, see

{p2col :{helpb use}}Load Stata dataset{p_end}
{p2col :{helpb sysuse}}Use shipped dataset{p_end}
{p2col :{helpb webuse}}Use dataset from Stata website{p_end}
{p2col :{helpb input}}Enter data from keyboard{p_end}
{p2col :{helpb insheet}}Read text data created by a spreadsheet{p_end}
{p2col :{helpb import}}Overview of importing data into Stata{p_end}
{p2col :{helpb import excel}}Import and export Excel files{p_end}
{p2col :{helpb import sasxport}}Import and export datasets in SAS XPORT format{p_end}
{p2col :{helpb infile2:infile (fixed format)}}Read text data in fixed format with a dictionary{p_end}
{p2col :{helpb infile1:infile (free format)}}Read unformatted text data{p_end}
{p2col :{helpb infix:infix (fixed format)}}Read text data in fixed format{p_end}
{p2col :{helpb odbc}}Load, write, or view data from ODBC sources{p_end}
{p2col :{helpb xmlsave}}Export or import dataset in XML format{p_end}
{p2col :{helpb hexdump}}Display hexadecimal report on file{p_end}
{p2col :{helpb icd9}}ICD-9-CM diagnostic and procedure codes{p_end}


{pstd}
and for exporting data, see

{p2col :{helpb save}}Save Stata dataset{p_end}
{p2col :{helpb export}}Overview of exporting data from Stata{p_end}
{p2col :{helpb outfile}}Export dataset in text format{p_end}
{p2col :{helpb outsheet}}Write spreadsheet-style dataset{p_end}
{p2col :{helpb import excel}}Import and export Excel files{p_end}
{p2col :{helpb import sasxport}}Import and export datasets in SAS XPORT format{p_end}
{p2col :{helpb odbc}}Load, write, or view data from ODBC sources{p_end}


{pstd}
The ordering of variables and observations (sort order) can be important; see

{p2col :{helpb order}}Reorder variables in dataset{p_end}
{p2col :{helpb sort}}Sort data{p_end}
{p2col :{helpb gsort}}Ascending and descending sort{p_end}


{pstd}
To reorganize or combine data, see

{p2col :{helpb merge}}Merge datasets{p_end}
{p2col :{helpb append}}Append datasets{p_end}
{p2col :{helpb reshape}}Convert data from wide to long form and vice versa{p_end}
{p2col :{helpb collapse}}Make dataset of summary statistics{p_end}
{p2col :{helpb contract}}Make dataset of frequencies and percentages{p_end}
{p2col :{helpb fillin}}Rectangularize dataset{p_end}
{p2col :{helpb expand}}Duplicate observations{p_end}
{p2col :{helpb expandcl}}Duplicate clustered observations{p_end}
{p2col :{helpb stack}}Stack data{p_end}
{p2col :{helpb joinby}}Form all pairwise combinations within groups{p_end}
{p2col :{helpb xpose}}Interchange observations and variables{p_end}
{p2col :{helpb cross}}Form every pairwise combination of two datasets{p_end}


{pstd}
In the above list, we particularly want to direct your attention to 
{manlink D reshape}, a useful command that beginners often overlook.


{pstd}
For random sampling, see

{p2col :{helpb sample}}Draw random sample{p_end}
{p2col :{helpb drawnorm}}Draw sample from multivariate normal distribution
For file manipulation, see{p_end}
{p2col :{helpb type}}Display contents of a file{p_end}
{p2col :{helpb erase}}Erase a disk file{p_end}
{p2col :{helpb copy}}Copy file from disk or URL{p_end}
{p2col :{helpb cd}}Change directory{p_end}
{p2col :{helpb dir}}Display filenames{p_end}
{p2col :{helpb mkdir}}Create directory{p_end}
{p2col :{helpb rmdir}}Remove directory{p_end}
{p2col :{helpb cf}}Compare two datasets{p_end}
{p2col :{helpb changeeol}}Convert end-of-line characters of text file{p_end}
{p2col :{helpb filefilter}}Convert text or binary patterns in a file{p_end}
{p2col :{helpb checksum}}Calculate checksum of file{p_end}
{p2col :{helpb zipfile}}Compress and uncompress files and directories in zip archive format{p_end}


{pstd}
The entries above are important.  The rest are useful when you need them:

{p2col :{helpb datasignature}}Determine whether data have changed{p_end}
{p2col :{helpb type}}Display contents of a file{p_end}
{p2col :{helpb notes}}Place notes in data{p_end}
{p2col :{helpb label language}}Labels for variables and values in multiple languages{p_end}
{p2col :{helpb labelbook}}Label utilities{p_end}
{p2col :{helpb encode}}Encode string into numeric and vice versa{p_end}
{p2col :{helpb recode}}Recode categorical variables{p_end}
{p2col :{helpb ipolate}}Linearly interpolate (extrapolate) values{p_end}
{p2col :{helpb destring}}Convert string variables to numeric variables and vice versa{p_end}
{p2col :{helpb mvencode}}Change missing values to numeric values and vice versa{p_end}
{p2col :{helpb pctile}}Create variable containing percentiles{p_end}
{p2col :{helpb range}}Generate numerical range{p_end}
{p2col :{helpb by}}Repeat Stata command on subsets of the data{p_end}
{p2col :{helpb statsby}}Collect statistics for a command across a by list{p_end}
{p2col :{helpb compress}}Compress data in memory{p_end}
{p2col :{helpb recast}}Change storage type of variable{p_end}
{p2col :{helpb datetime display formats}}Display formats for dates and times{p_end}
{p2col :{helpb datetime translation}}String to numeric date translation functions{p_end}
{p2col :{helpb bcal}}Business calendar file manipulation{p_end}
{p2col :{helpb datetime business calendars:datetime business}}Business calendars{p_end}
{p2col 12 14 14 2:{helpb datetime business calendars:calendars}}{p_end}
{p2col :{helpb datetime business calendars creation:datetime business}}Business calendars creation{p_end}
{p2col 12 14 14 2:{helpb datetime business calendars creation:calendars creation}}{p_end}
{p2col :{helpb assert}}Verify truth of claim{p_end}
{p2col :{helpb clonevar}}Clone existing variable{p_end}
{p2col :{helpb compare}}Compare two variables{p_end}
{p2col :{helpb corr2data}}Create dataset with specified correlation structure{p_end}
{p2col :{helpb ds}}List variables matching name patterns or other characteristics{p_end}
{p2col :{helpb duplicates}}Report, tag, or drop duplicate observations{p_end}
{p2col :{helpb isid}}Check for unique identifiers{p_end}
{p2col :{helpb lookfor}}Search for string in variable names and labels{p_end}
{p2col :{helpb memory}}Memory management{p_end}
{p2col :{helpb putmata}}Put Stata variables into Mata and vice versa{p_end}
{p2col :{helpb obs}}Increase the number of observations in a dataset{p_end}
{p2col :{helpb rename group}}Rename groups of variables{p_end}
{p2col :{helpb separate}}Create separate variables{p_end}
{p2col :{helpb shell}}Temporarily invoke operating system{p_end}
{p2col :{helpb snapshot}}Save and restore data snapshots{p_end}
{p2col :{helpb split}}Split string variables into parts{p_end}


{pstd}
There are some real jewels in the above, such as {manlink D notes},
{manlink D compress}, {manlink D assert}, which you will find particularly
useful.


{marker reference}{...}
{title:Reference}

{marker M2010}{...}
{phang}Mitchell, M. N. 2010. 
{browse "http://www.stata-press.com/books/dmus.html":{it:Data Management Using Stata: A Practical Handbook}.} College Station, TX: Stata Press.
{p_end}

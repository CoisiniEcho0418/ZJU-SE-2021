{smcl}
{* *! version 1.0.8  07jul2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] mi replace0" "mansection MI mireplace0"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] intro" "help mi"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] mi extract" "help mi_extract"}{...}
{viewerjumpto "Syntax" "mi_replace0##syntax"}{...}
{viewerjumpto "Description" "mi_replace0##description"}{...}
{viewerjumpto "Option" "mi_replace0##option"}{...}
{viewerjumpto "Remarks" "mi_replace0##remarks"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col :{manlink MI mi replace0} {hline 2}}Replace original data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{cmd:mi replace0}
{cmd:using} {it:{help filename}}{cmd:,}
{cmd:id(}{varlist}{cmd:)}


{p 4 4 2}
Typical use is 

		. {cmd:mi extract 0}

		. ({it:perform data-management commands})

		. {cmd:mi replace0 using} {it:origfile}{cmd:, id(}{it:idvar}{cmd:)} 


{title:Menu}

{phang}
{bf:Statistics > Multiple imputation}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mi} {cmd:replace0} replaces {it:m}=0 of an {cmd:mi} dataset with the
non-{cmd:mi} data of another and then carries out whatever changes 
are necessary 
in {it:m}>0 of the former
to make the resulting {cmd:mi} data
consistent.  {cmd:mi} {cmd:replace0} starts with one of the datasets in
memory and the other on disk (it does not matter which is which)
and leaves in memory
the {cmd:mi} data with {it:m}=0 replaced.


{marker option}{...}
{title:Option}

{p 4 8 2}
{cmd:id(}{varlist}{cmd:)} is required; 
    it specifies the variable or variables to use to match the
    observations in {it:m}=0 of the {cmd:mi} data to the observations of the
    non-{cmd:mi} dataset.  The ID variables must uniquely identify the 
    observations in each dataset, and equal values across datasets must 
    indicate corresponding observations, but one or both 
    datasets can have observations found (or not found) in the other.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
It is often easier to perform data management on {it:m}=0 and then
let {cmd:mi} {cmd:replace0} 
duplicate the results for {it:m}=1, {it:m}=2, ..., {it:m}={it:M} rather than
perform the data management on all {it:m}'s simultaneously.  It is easier
because {it:m}=0 by itself is a non-{cmd:mi} dataset, so you can use any
of the general Stata commands (that is, non-{cmd:mi} commands) with it.

{p 4 4 2}
You use {bf:{help mi_extract:mi extract}} to extract 
{it:m}=0.  The extracted dataset is just a regular Stata dataset; it is not 
{cmd:mi} {cmd:set}, nor does it have any secret complexities.

{p 4 4 2}
You use {cmd:mi} {cmd:replace0} to recombine the datasets after 
you have modified the {it:m}=0 data.
{cmd:mi} {cmd:replace0} can deal with the following changes to {it:m}=0:

{p 8 12 2}
o  changes to the values of existing variables,

{p 8 12 2}
o  removal of variables,

{p 8 12 2}
o  addition of new variables,

{p 8 12 2}
o  dropped observations, and 

{p 8 12 2}
o  added observations.

{p 4 4 2}
For instance, you could use {cmd:mi} {cmd:extract} and {cmd:mi} 
{cmd:replace0} to do the following:

	. {cmd:use my_midata, clear}

	. {cmd:mi extract 0}

	. {cmd:replace age = 26 if age==6}
	. {cmd:replace age = 32 if pid==2088}

	. {cmd:merge 1:1 pid using newvars, keep(match) nogen}

	. {cmd:by location: egen avgrate = mean(rate)}

	. {cmd:drop proxyrate}

	. {cmd:mi replace0 using my_midata, id(pid)}

{p 4 4 2}
In the above,

{p 8 12 2}
    1.  we extract {it:m}=0;

{p 8 12 2}
    2.  we update existing variable {cmd:age} (we fix a typo and add 
        the age of {cmd:pid} 2088);

{p 8 12 2}
    3.  we merge {it:m}=0 with {cmd:newvars.dta} to obtain some new
        variables and, in the process, keep only the observations that were
        found in both {it:m}=0 and {cmd:newvars.dta};

{p 8 12 2}
    4.  we create new variable {cmd:avgrate} equal to the mean rate by
        location; and

{p 8 12 2}
    5.  we drop previously existing variable {cmd:proxyrate}.

{p 4 4 2}
We then take that result and use it to replace {it:m}=0 in our original
{cmd:mi} dataset.  We leave it to {cmd:mi} {cmd:replace0} to carry out the
changes to {it:m}=1, {it:m}=2, ..., {it:m}={it:M} to account for what we 
did to {it:m}=0.

{p 4 4 2}
By the way, it turns out that {cmd:age} in {cmd:my_midata.dta} is registered
as imputed.  We changed one nonmissing value to another nonmissing
value and changed one missing value to a nonmissing value.  {cmd:mi}
{cmd:replace0} will deal with the implications of that.  It would even deal with
us having changed a nonmissing value to a missing value.

{p 4 4 2}
There is no easier way to do data management than by using 
{cmd:mi} {cmd:extract} and {cmd:mi} {cmd:replace0}.
{p_end}

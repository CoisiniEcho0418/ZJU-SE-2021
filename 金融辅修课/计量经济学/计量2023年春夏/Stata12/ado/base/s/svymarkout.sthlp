{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[SVY] svymarkout" "mansection SVY svymarkout"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] mark" "help mark"}{...}
{vieweralsosee "[P] program properties" "help program_properties"}{...}
{viewerjumpto "Syntax" "svymarkout##syntax"}{...}
{viewerjumpto "Description" "svymarkout##description"}{...}
{viewerjumpto "Example" "svymarkout##example"}{...}
{viewerjumpto "Saved results" "svymarkout##saved_results"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col :{manlink SVY svymarkout} {hline 2}}Mark
observations for exclusion on the basis of survey characteristics{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:svymarkout} [{it:markvar}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:svymarkout} is a programmer's command that resets the values of
{it:markvar} to contain 0 wherever any of the survey-characteristic variables
(previously set by {helpb svyset}) contain missing values.

{pstd}
{cmd:svymarkout} assumes that {it:markvar} was created by {cmd:marksample} or
{cmd:mark}; see {manhelp mark P}.  This command is most helpful for developing
estimation commands that use {opt ml} to fit models using maximum
pseudolikelihood directly, instead of relying on the {cmd:svy} prefix;
see {manhelp program_properties P:program properties} for a
discussion of how to write programs to be used with the {cmd:svy} prefix.


{marker example}{...}
{title:Example}

    {cmd:program} {it:mysvyprogram}{cmd:,} ...
	    ...
	    {cmd:syntax} ...
	    {cmd:marksample touse}
	    {cmd:svymarkout `touse'}
	    ...
    {cmd:end}
    

{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:svymarkout} saves the following in {cmd:s()}:

    Macros
        {cmd:s(weight)}     weight variable set by {cmd:svyset}

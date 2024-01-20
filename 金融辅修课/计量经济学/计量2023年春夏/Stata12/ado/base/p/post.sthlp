{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[P] postfile" "mansection P postfile"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bootstrap" "help bootstrap"}{...}
{vieweralsosee "[R] simulate" "help simulate"}{...}
{viewerjumpto "Syntax" "post##syntax"}{...}
{viewerjumpto "Description" "post##description"}{...}
{viewerjumpto "Options" "post##options"}{...}
{viewerjumpto "Remarks" "post##remarks"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink P postfile} {hline 2}}Save results in Stata dataset{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}Declare variable names and filename of dataset where results will be stored

{p 8 17 2}{cmd:postfile} {it:postname} {it:{help newvarlist}} {cmd:using}
{it:{help filename}} [{cmd:,} {cmdab:e:very:(}{it:#}{cmd:)} {cmd:replace}]


    Add new observation to declared dataset

{p 8 17 2}{cmd:post} {it:postname} {cmd:(}{it:{help exp}}{cmd:)}
{cmd:(}{it:{help exp}}{cmd:)} {it:...} {cmd:(}{it:{help exp}}{cmd:)}


    Declare end to posting of observations

	{cmd:postclose} {it:postname}


    List all open postfiles

	{cmd:postutil dir}


    Close all open postfiles

	{cmd:postutil clear}


{marker description}{...}
{title:Description}

{pstd}
These commands are utilities to assist Stata programmers in performing
Monte Carlo-type experiments.

{pstd}
{cmd:postfile} declares the variable names and the filename of a (new) Stata
dataset where results will be stored.  

{pstd}
{cmd:post} adds a new observation to the declared dataset.

{pstd}
{cmd:postclose} declares an end to the posting of observations.  After
{cmd:postclose}, the new dataset contains the posted results and may be loaded
using {cmd:use}; see {manhelp use D}.

{pstd}
{cmd:postutil dir} lists all open postfiles.  {cmd:postutil clear} closes
all open postfiles.

{pstd}
All five commands manipulate the new dataset without disturbing the data in
memory.

{pstd}
If {it:{help filename}} is specified without an extension,  {cmd:.dta} is
assumed.


{marker options}{...}
{title:Options}

{phang}{cmd:every(}{it:#}{cmd:)} specifies results are to be written to disk
every {it:#}th call to {cmd:post}.  {cmd:post} temporarily holds results in
memory and periodically opens the dataset being built to append to the stored
results.  {cmd:every()} should typically not be specified, because you are
unlikely to choose a value for {it:#} that is as efficient as the number
{cmd:post} chooses on its own, which is a function of the number of results
being written and their storage type.

{phang}{cmd:replace} indicates that the file specified may already exist,
and if it does, that {cmd:postfile} may erase the file and create a new one.


{marker remarks}{...}
{title:Remarks}

{pstd}
The typical use of the post commands is

	{cmd:tempname memhold}
	{cmd:tempfile results}
	{it:...}
	{cmd:postfile `memhold'} {it:...} {cmd:using `results'}
	{it:...}
	{cmd:while} {it:...} {cmd:{c -(}}
		{it:...}
		{cmd:post `memhold'} {it:...}
		{it:...}
	{cmd:{c )-}}
	{cmd:postclose `memhold'}
	{it:...}

{pstd}
Two names are specified with {cmd:postfile}: {it:postname} is a name assigned
to internal memory buffers, and {it:filename} is the name of the file to be
created.  Subsequent {cmd:post}s and the {cmd:postclose} are followed by
{it:postname} so that Stata will know to what file they refer.

{pstd}
In our sample, we obtain both names from Stata's temporary name
facility (see {helpb macro:[P] macro}), although, in some programming
situations, you may wish to substitute a hard-coded {it:filename}.
We recommend that {it:postname} always be obtained from {cmd:tempname}.
This ensures that your program can be nested within any other
program and ensures that the memory used by {cmd:post} is freed
if anything goes wrong.
Using a temporary filename, too, ensures that the file will be
erased if the user presses {hi:Break}.  Sometimes, however,
you may wish to leave the file of incomplete results behind.  That
is allowed, but remember that the file is not fully up to date if
{cmd:postclose} has not been executed.  {cmd:post} buffers results in
memory and only periodically updates the file.

{pstd}
Because {cmd:postfile} accepts a {it:newvarlist}, storage types
may be interspersed, so you could have

{phang2}
        {cmd:postfile `memhold' a b str20 c double(d e f) using "`results'"}
{p_end}

{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog sysuse "dialog sysuse"}{...}
{vieweralsosee "[D] sysuse" "mansection D sysuse"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] webuse" "help webuse"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] findfile" "help findfile"}{...}
{vieweralsosee "[R] net" "help net"}{...}
{vieweralsosee "[R] ssc" "help ssc"}{...}
{vieweralsosee "[D] sysdescribe" "help sysdescribe"}{...}
{vieweralsosee "[P] sysdir" "help sysdir"}{...}
{vieweralsosee "[D] use" "help use"}{...}
{viewerjumpto "Syntax" "sysuse##syntax"}{...}
{viewerjumpto "Description" "sysuse##description"}{...}
{viewerjumpto "Options" "sysuse##options"}{...}
{viewerjumpto "Example" "sysuse##example"}{...}
{viewerjumpto "Saved results" "sysuse##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink D sysuse} {hline 2}}Use shipped dataset{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

    Use example dataset installed with Stata

{p 8 16 2}
{cmd:sysuse}
[{cmd:"}]{it:{help filename}}[{cmd:"}]
[{cmd:,}
{opt clear}]


    List example Stata datasets installed with Stata

{p 8 16 2}
{opt sysuse dir}
[{cmd:,}
{opt all}]


{title:Menu}

{phang}
{bf:File > Example Datasets...}


{marker description}{...}
{title:Description}

{pstd}
{opt sysuse} {it:{help filename}} loads the specified Stata-format dataset that
was shipped with Stata or that is stored along the {help adopath:ado-path}.  If
{it:filename} is specified without a suffix, {opt .dta} is assumed.

{pstd}
{opt sysuse dir} lists the names of the datasets shipped with Stata plus
any other datasets stored along the ado-path.


{marker options}{...}
{title:Options}

{phang}
{opt clear} specifies that it is okay to replace the data in memory, even
    though the current data have not been saved to disk.

{phang}
{opt all} specifies that all datasets be listed, even those that include
    an underscore ({opt _}) in their name.  By default, such datasets
    are not listed.


{marker example}{...}
{title:Example}

{pstd}
If you simply type {cmd:use lifeexp}, you would see

	{cmd:. use lifeexp}
	{err:file lifeexp.dta not found}
	{search r(601):r(601);}

{pstd}
Type {opt sysuse}, however, and the dataset is loaded:

	{cmd:. sysuse lifeexp}
	(Life expectancy, 1998)


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:sysuse dir} saves in the macro {cmd:r(files)} the list of dataset names.

{pstd}
{cmd:sysuse} {it:filename} saves in the macro {cmd:r(fn)} the {it:filename},
including the full path specification.
{p_end}

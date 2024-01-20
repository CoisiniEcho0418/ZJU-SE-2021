{smcl}
{* *! version 1.1.3  11feb2011}{...}
{viewerdialog tsreport "dialog tsreport"}{...}
{vieweralsosee "[TS] tsreport" "mansection TS tsreport"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{viewerjumpto "Syntax" "tsreport##syntax"}{...}
{viewerjumpto "Description" "tsreport##description"}{...}
{viewerjumpto "Options" "tsreport##options"}{...}
{viewerjumpto "Examples" "tsreport##examples"}{...}
{viewerjumpto "Saved results" "tsreport##saved_results"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink TS tsreport} {hline 2}}Report time-series aspects of dataset 
or estimation sample{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 20 2}
{cmd:tsreport} {ifin} [{cmd:,} {it:options}]

{synoptset 15 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Main}
{synopt :{opt r:eport}}display number of gaps in the time series{p_end}
{synopt :{opt report0}}display count of gaps even if no gaps{p_end}
{synopt :{opt l:ist}}display gaps data in tabular list{p_end}
{synopt :{opt p:anel}}do not count panel changes as gaps{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:tsreport} typed without options produces no output but provides
its standard saved results.


{title:Menu}

{phang}
{bf:Statistics > Time series > Setup and utilities >}
    {bf:Report time-series aspects of dataset}


{marker description}{...}
{title:Description}

{pstd}
{cmd:tsreport} reports time gaps in a sample of observations.  The 
{opt report} option displays a one-line statement showing the count of the
gaps, and {opt list} displays a list of records that follow gaps.  A
return value {cmd:r(N_gaps)} indicates the number of gaps in the sample.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt report} specifies that the number of gaps in the time series
be reported, if any gaps exist.

{phang}
{opt report0} specifies that the count of gaps be reported, even if there are
no gaps.

{phang}
{opt list} specifies that a tabular list of gaps be displayed.

{phang}
{opt panel} specifies that panel changes not be counted as gaps.  Whether
panel changes are counted as gaps usually depends on how the calling command
handles panels.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse tsrptxmpl}{p_end}
{phang2}{cmd:. list edlevel month income}{p_end}
{phang2}{cmd:. tsset}

{pstd}Report number of gaps in the time series and ignore panel changes{p_end}
{phang2}{cmd:. tsreport, report panel}{p_end}

{pstd}Same as above, but display gaps data in a table{p_end}
{phang2}{cmd:. tsreport, report panel list}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:tsreport} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N_gaps)}}number of gaps in sample{p_end}
{p2colreset}{...}

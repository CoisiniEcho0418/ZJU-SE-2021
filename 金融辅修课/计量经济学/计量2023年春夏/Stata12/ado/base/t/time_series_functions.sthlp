{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[D] functions" "mansection D functions"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] datetime" "help datetime"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] egen" "help egen"}{...}
{viewerjumpto "Description" "time series functions##description"}{...}
{viewerjumpto "Selecting time spans" "time series functions##time_spans"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink D functions} {hline 2}}Functions{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}This is a quick reference for the time-series functions.  
See {manhelp time TS:time series} for an introduction to the time-series
analysis commands.  See {manhelp datetime D} concerning
date and time functions.  For help on all functions, see
{manhelp functions D}.

{pstd}
Stata also provides lag, lead, and difference operators; 
see {bf:{help varlist:[U] 11.4 varlists}}.


{marker time_spans}{...}
{title:Selecting time spans}

INCLUDE help f_tin

INCLUDE help f_twithin

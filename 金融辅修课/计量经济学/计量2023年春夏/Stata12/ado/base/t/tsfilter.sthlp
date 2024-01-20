{smcl}
{* *! version 1.0.7  31mar2011}{...}
{vieweralsosee "[TS] tsfilter" "mansection TS tsfilter"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{vieweralsosee "[XT] xtset" "help xtset"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] tssmooth" "help tssmooth"}{...}
{viewerjumpto "Syntax" "tsfilter##syntax"}{...}
{viewerjumpto "Description" "tsfilter##description"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink TS tsfilter} {hline 2}}Filter a time series, keeping only selected periodicities{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
Filter one variable

{p 8 18 2}
{cmd:tsfilter}
{it:filter} {dtype}
{newvar} {cmd:=} {help varname:{it:varname}}
{ifin} [{cmd:,} {it:options}]


{pstd}
Filter multiple variables, unique names

{p 8 18 2}
{cmd:tsfilter}
{it:filter} {dtype}
{help newvarlist:{it:newvarlist}} {cmd:=} {help varlist:{it:varlist}}
{ifin} [{cmd:,} {it:options}]


{pstd}
Filter multiple variables, common name stub

{p 8 18 2}
{cmd:tsfilter}
{it:filter} {dtype}
{it:stub*} {cmd:=} {help varlist:{it:varlist}}
{ifin} [{cmd:,} {it:options}]
{p_end}


{synoptset 9}{...}
{synopt:{it:filter}}Name{space 20}See help for{p_end}
{synoptline}
{synopt:{cmd:bk}}Baxter-King{space 13}{helpb tsfilter bk:tsfilter bk}{p_end}
{synopt:{cmd:bw}}Butterworth{space 13}{helpb tsfilter bw:tsfilter bw}{p_end}
{synopt:{cmd:cf}}Christiano-Fitzgerald{space 3}{helpb tsfilter cf:tsfilter cf}{p_end}
{synopt:{cmd:hp}}Hodrick-Prescott{space 8}{helpb tsfilter hp:tsfilter hp}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
You must {opt tsset}  or {opt xtset} your data before using {opt tsfilter};
see {manhelp tsset TS} and {manhelp xtset XT}.{p_end}
{p 4 6 2}
{it:varname} and {it:varlist} may contain time-series operators; see
{help tsvarlist}.
{p_end}
{p 4 6 2}
{it:options} differ across the filters and are documented in each {it:filter}'s
manual entry.
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:tsfilter} separates a time series into trend and cyclical components.
The trend component may contain a deterministic or a stochastic trend.  The
stationary cyclical component is driven by stochastic cycles at the specified
periods.  {p_end}

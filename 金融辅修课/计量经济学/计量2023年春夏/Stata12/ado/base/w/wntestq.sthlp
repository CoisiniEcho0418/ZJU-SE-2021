{smcl}
{* *! version 1.1.5  11feb2011}{...}
{viewerdialog wntestq "dialog wntestq"}{...}
{vieweralsosee "[TS] wntestq" "mansection TS wntestq"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] corrgram" "help corrgram"}{...}
{vieweralsosee "[TS] cumsp" "help cumsp"}{...}
{vieweralsosee "[TS] pergram" "help pergram"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{vieweralsosee "[TS] wntestb" "help wntestb"}{...}
{viewerjumpto "Syntax" "wntestq##syntax"}{...}
{viewerjumpto "Description" "wntestq##description"}{...}
{viewerjumpto "Option" "wntestq##option"}{...}
{viewerjumpto "Examples" "wntestq##examples"}{...}
{viewerjumpto "Saved results" "wntestq##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink TS wntestq} {hline 2}}Portmanteau (Q) test for white noise{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}{cmd:wntestq} {varname} {ifin} [{cmd:,} {opt l:ags(#)}]

{p 4 6 2}You must {cmd:tsset} your data before using {cmd:wntestq}; see
{helpb tsset:[TS] tsset}.
Also the time series must be dense (nonmissing with no gaps in the time
variable) in the specified sample.{p_end}
{p 4 6 2}{it:varname} may contain time-series operators; see {help tsvarlist}.
{p_end}


{title:Menu}

{phang}
{bf:Statistics > Time series > Tests > Portmanteau white-noise test}


{marker description}{...}
{title:Description}

{pstd}
{cmd:wntestq} performs the portmanteau (or Q) test for white noise.


{marker option}{...}
{title:Option}

{phang}
{opt lags(#)} specifies the number of autocorrelations to calculate.  The
default is to use min{floor(n/2) - 2, 40}, where floor(n/2) is the greatest
integer less than or equal to n/2.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. drop _all}{p_end}
{phang2}{cmd:. set obs 100}{p_end}
{phang2}{cmd:. generate x1 = rnormal()}{p_end}
{phang2}{cmd:. generate time = _n}{p_end}
{phang2}{cmd:. tsset time}{p_end}

{pstd}Perform portmanteau (or Q) test for white noise on series
{cmd:x1}{p_end}
{phang2}{cmd:. wntestq x1}{p_end}

{pstd}Same as above, but calculate 50 autocorrelations{p_end}
{phang2}{cmd:. wntestq x1, lags(50)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:wntestq} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(stat)}}Q statistic{p_end}
{synopt:{cmd:r(df)}}degrees of freedom{p_end}
{synopt:{cmd:r(p)}}probability value{p_end}
{p2colreset}{...}

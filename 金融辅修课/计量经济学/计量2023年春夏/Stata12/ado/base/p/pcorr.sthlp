{smcl}
{* *! version 1.1.2  11feb2011}{...}
{viewerdialog pcorr "dialog pcorr"}{...}
{vieweralsosee "[R] pcorr" "mansection R pcorr"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] correlate" "help correlate"}{...}
{vieweralsosee "[R] spearman" "help spearman"}{...}
{viewerjumpto "Syntax" "pcorr##syntax"}{...}
{viewerjumpto "Description" "pcorr##description"}{...}
{viewerjumpto "Examples" "pcorr##examples"}{...}
{viewerjumpto "Saved results" "pcorr##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink R pcorr} {hline 2}}Partial and semipartial correlation coefficients{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:pcorr} {it:{help varname:varname1}} {varlist} {ifin} {weight} 

{phang}
{it:varname1} and {it:varlist} may contain time-series operators; see {help tsvarlist}.{p_end}
{phang}
{opt by} is allowed; see {manhelp by D}.{p_end}
{phang}
{opt aweight}s and {opt fweight}s are allowed; see {help weight}.


{title:Menu}

{phang}
{bf:Statistics > Summaries, tables, and tests >}
     {bf:Summary and descriptive statistics > Partial correlations}


{marker description}{...}
{title:Description}

{pstd}
{cmd:pcorr} displays the partial and semipartial correlation coefficient of 
{it:{help varname:varname1}} with each variable in {varlist} after removing
the effects of all other variables in {it: varlist}. The squared correlations
and corresponding significance are also reported.


{marker examples}{...}
{title:Example}

{phang}{cmd:. sysuse auto}{p_end}
{phang}{cmd:. pcorr price mpg weight foreign}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:pcorr} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(df)}}degrees of freedom{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(p_corr)}}partial correlation coefficient vector{p_end}
{synopt:{cmd:r(sp_corr)}}semipartial correlation coefficient vector{p_end}

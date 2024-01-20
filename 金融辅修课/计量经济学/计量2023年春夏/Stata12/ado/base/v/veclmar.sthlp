{smcl}
{* *! version 1.1.2  11feb2011}{...}
{viewerdialog veclmar "dialog veclmar"}{...}
{vieweralsosee "[TS] veclmar" "mansection TS veclmar"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] varlmar" "help varlmar"}{...}
{vieweralsosee "[TS] vec" "help vec"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] vec intro" "help vec_intro"}{...}
{viewerjumpto "Syntax" "veclmar##syntax"}{...}
{viewerjumpto "Description" "veclmar##description"}{...}
{viewerjumpto "Options" "veclmar##options"}{...}
{viewerjumpto "Examples" "veclmar##examples"}{...}
{viewerjumpto "Saved results" "veclmar##saved_results"}{...}
{title:Title}

{p2colset 5 21 22 2}{...}
{p2col :{manlink TS veclmar} {hline 2}}Perform LM test for residual autocorrelation after vec{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 19 2}
{cmd:veclmar} [{cmd:,} {it:options}]

{synoptset}{...}
{synopthdr}
{synoptline}
{synopt :{opt ml:ag(#)}}use {it:#} for the maximum order of autocorrelation; default is 
  {cmd:mlag(2)}{p_end}
{synopt :{opt est:imates(estname)}}use previously saved results {it:estname};
  default is to use active results{p_end}
{synopt :{opt sep:arator(#)}}draw separator line after every {it:#}
  rows{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{cmd:veclmar} can be used only after {cmd:vec}; see
{helpb vec:[TS] vec}.{p_end}
{p 4 6 2}You must {cmd:tsset} your data before using {cmd:veclmar}; see
{helpb tsset:[TS] tsset}.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Multivariate time series > VEC diagnostics and tests >}
     {bf:LM test for residual autocorrelation}


{marker description}{...}
{title:Description}

{pstd}
{cmd:veclmar} implements a Lagrange-multiplier (LM) test for autocorrelation
in the residuals of vector error-correction models (VECMs).


{marker options}{...}
{title:Options}

{phang}
{opt mlag(#)} specifies the maximum order of autocorrelation to be tested.
The integer specified in {opt mlag()} must be greater than 0; the default is
2.

{phang}
{opt estimates(estname)} requests that {cmd:veclmar} use the previously
obtained set of {cmd:vec} estimates saved as {it:estname}.  By default,
{cmd:veclmar} uses the active results.  See {manhelp estimates R} for
information on saving and restoring estimation results.

{phang}
{opt separator(#)} specifies how many rows should appear in the table between
separator lines.  By default, separator lines do not appear.  For example,
{cmd:separator(1)} would draw a line between each row, {cmd:separator(2)}
between every other row, and so on.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse rdinc}{p_end}

{pstd}Fit vector error-correction model{p_end}
{phang2}{cmd:. vec ln_ne ln_se}{p_end}

{pstd}Perform Lagrange-multiplier test for residual autocorrelation{p_end}
{phang2}{cmd:. veclmar}{p_end}

{pstd}Same as above, but use 4 for the maximum order of autocorrelation{p_end}
{phang2}{cmd:. veclmar, mlag(4)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:veclmar} saves the following in {cmd:r()}:

{synoptset 10 tabbed}{...}
{p2col 5 10 14 2: Matrices}{p_end}
{synopt:{cmd:r(lm)}}chi-squared, df, and p-values{p_end}
{p2colreset}{...}

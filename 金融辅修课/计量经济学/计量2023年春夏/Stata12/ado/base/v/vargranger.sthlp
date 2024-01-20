{smcl}
{* *! version 1.1.2  11feb2011}{...}
{viewerdialog vargranger "dialog vargranger"}{...}
{vieweralsosee "[TS] vargranger" "mansection TS vargranger"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] var" "help var"}{...}
{vieweralsosee "[TS] var svar" "help svar"}{...}
{vieweralsosee "[TS] varbasic" "help varbasic"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] var intro" "help var_intro"}{...}
{viewerjumpto "Syntax" "vargranger##syntax"}{...}
{viewerjumpto "Description" "vargranger##description"}{...}
{viewerjumpto "Options" "vargranger##options"}{...}
{viewerjumpto "Examples" "vargranger##examples"}{...}
{viewerjumpto "Saved results" "vargranger##saved_results"}{...}
{title:Title}

{p2colset 5 24 26 2}{...}
{p2col:{manlink TS vargranger} {hline 2}}Perform pairwise Granger causality
tests after var or svar {p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:vargranger}
[{cmd:,}
{opt est:imates(estname)}
{opt sep:arator(#)}]

{p 4 6 2}
{opt vargranger} can be used only after {cmd:var} or {cmd:svar};
see {helpb var:[TS] var} or {helpb svar:[TS] var svar}.


{title:Menu}

{phang}
{bf:Statistics > Multivariate time series > VAR diagnostics and tests >}
     {bf:Granger causality tests}


{marker description}{...}
{title:Description}

{pstd}
{opt vargranger} performs a set of Granger causality tests for each equation
in a VAR, providing a convenient alternative to {helpb test}.


{marker options}{...}
{title:Options}

{phang}
{opt estimates(estname)} requests that {opt vargranger}
   use the previously obtained set of {opt var} or {opt svar} estimates saved
   as {it:estname}.  By default, {opt vargranger} uses the active results.
   See {manhelp estimates R} for information about saving and restoring
   estimation results.

{phang}
{opt separator(#)} specifies how often separator lines should be
   drawn between rows.  By default, separator lines appear every K lines,
   where K is the number of equations in the VAR under analysis.  For
   example, {cmd:separator(1)} would draw a line between each row,
   {cmd:separator(2)} between every other row, and so on. 
   {cmd:separator(0)} specifies that lines not appear in the table.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse lutkepohl2}{p_end}
{phang2}{cmd:. tsset}{p_end}

{pstd}Fit a vector autoregressive (VAR) model{p_end}
{phang2}{cmd:. var dln_inv dln_inc dln_consump if qtr<=tq(1978q4)}{p_end}

{pstd}Store estimation results in {cmd:basic}{p_end}
{phang2}{cmd:. estimates store basic}{p_end}

{pstd}Fit a second VAR model{p_end}
{phang2}{cmd:. var dln_inv dln_inc dln_consump if qtr<=tq(1978q4), lags(1/3)}
                {cmd:dfk small}

{pstd}Perform pairwise Granger causality tests on the second VAR model{p_end}
{phang2}{cmd:. vargranger}{p_end}

{pstd}Perform pairwise Granger causality tests on the first VAR model{p_end}
{phang2}{cmd:. vargranger, estimates(basic)}{p_end}

{pstd}Setup{p_end}
{phang2}{cmd:. matrix A = (.,0,0\.,.,0\.,.,.)}{p_end}
{phang2}{cmd:. matrix B = I(3)}{p_end}

{pstd}Fit a structural vector autoregressive (SVAR) model{p_end}
{phang2}{cmd:. svar dln_inv dln_inc dln_consump if qtr<=tq(1978q4),}
                {cmd:dfk small aeq(A) beq(B)}

{pstd}Perform pairwise Granger causality test after SVAR model{p_end}
{phang2}{cmd:. vargranger}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:vargranger} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(gstats)}}chi-squared, df, and p-values (if
						{cmd:e(small)==""}){p_end}
{synopt:{cmd:r(gstats)}}F, df, df_r, and p-values (if
						{cmd:e(small)!==""}){p_end}
{p2colreset}{...}

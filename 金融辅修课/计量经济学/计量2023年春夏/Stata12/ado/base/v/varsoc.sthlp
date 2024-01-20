{smcl}
{* *! version 1.1.8  27jun2011}{...}
{viewerdialog "varsoc (preestimation)" "dialog varsoc"}{...}
{viewerdialog "varsoc (postestimation)" "dialog varsoc_post"}{...}
{vieweralsosee "[TS] varsoc" "mansection TS varsoc"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] var" "help var"}{...}
{vieweralsosee "[TS] var svar" "help svar"}{...}
{vieweralsosee "[TS] varbasic" "help varbasic"}{...}
{vieweralsosee "[TS] vec" "help vec"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] var intro" "help var_intro"}{...}
{vieweralsosee "[TS] vec intro" "help vec_intro"}{...}
{viewerjumpto "Syntax" "varsoc##syntax"}{...}
{viewerjumpto "Description" "varsoc##description"}{...}
{viewerjumpto "Preestimation options" "varsoc##pre_options"}{...}
{viewerjumpto "Postestimation option" "varsoc##post_option"}{...}
{viewerjumpto "Examples" "varsoc##examples"}{...}
{viewerjumpto "Saved results" "varsoc##saved_results"}{...}
{viewerjumpto "References" "varsoc##references"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col:{manlink TS varsoc} {hline 2}}Obtain lag-order selection statistics for
VARs and VECMs {p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
    Preestimation syntax

{p 8 15 2}
{cmd:varsoc}
{depvarlist}
{ifin}
[{cmd:,} {it:preestimation_options}]


{pstd}
    Postestimation syntax

{p 8 15 2}
{cmd:varsoc}
[{cmd:,} {opt est:imates(estname)}]


{synoptset 28 tabbed}{...}
{synopthdr:preestimation_options}
{synoptline}
{syntab:Main}
{synopt:{opt m:axlag(#)}}set maximum lag order to {it:#}; default is {cmd:maxlag(4)}{p_end}
{synopt:{opth ex:og(varlist)}}use {it:varlist} as exogenous variables{p_end}
{synopt:{opt const:raints(constraints)}}apply constraints to exogenous variables{p_end}
{synopt:{opt nocons:tant}}suppress constant term{p_end}
{synopt:{opt lut:stats}}use L{c u:}tkepohl's version of information criteria{p_end}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt:{opt sep:arator(#)}}draw separator line after every {it:#} rows{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}You must {cmd:tsset} your data before using {cmd:varsoc}; see
{helpb tsset:[TS] tsset}.{p_end}
{p 4 6 2}
{opt by} is allowed with the preestimation version of {cmd:varsoc}; see
{help prefix}.{p_end}


{title:Menu}

    {title:Preestimation for VARs}

{phang2}
{bf:Statistics > Multivariate time series > VAR diagnostics and tests >}
     {bf:Lag-order selection statistics (preestimation)}

    {title:Postestimation for VARs}

{phang2}
{bf:Statistics > Multivariate time series > VAR diagnostics and tests >}
      {bf:Lag-order selection statistics (postestimation)}

    {title:Preestimation for VECMs}

{phang2}
{bf:Statistics > Multivariate time series > VEC diagnostics and tests >}
     {bf:Lag-order selection statistics (preestimation)}

    {title:Postestimation for VECMs}

{phang2}
{bf:Statistics > Multivariate time series > VEC diagnostics and tests >}
      {bf:Lag-order selection statistics (postestimation)}


{marker description}{...}
{title:Description}

{pstd}
{opt varsoc} reports the final prediction error (FPE), Akaike's
information criterion (AIC), Schwarz's Bayesian information criterion
(SBIC), and the Hannan and Quinn information criterion (HQIC)
lag-order selection statistics for a series of vector autoregressions of order
1,..,{opt maxlag()}.  A sequence of likelihood-ratio test statistics for all
the full VARs of order less than or equal to the highest lag order
requested is also reported.  In the postestimation version, the maximum
lag and estimation options are based on the model just fit or the model 
specified in {opt estimates(estname)}.

{pstd}
The preestimation version of {opt varsoc} can also be used to select the lag
order for a vector error-correction model (VECM).  As shown by
{help varsoc##N2001:Nielsen (2001)}, the lag-order selection
statistics discussed here can be used in the presence of I(1) variables.


{marker pre_options}{...}
{title:Preestimation options}

{dlgtab:Main}

{phang}
{opt maxlag(#)} specifies the maximum lag order for which the statistics are
   to be obtained.  

{phang}
{opth exog(varlist)} specifies exogenous variables to include in the
VARs fit by {opt varsoc}.

{phang}
{opt constraints(constraints)} specifies a list of constraints on the
   exogenous variables to be applied.  Do not specify constraints on the lags
   of the endogenous variables because specifying one would mean that at least
   one of the VAR models considered by {opt varsoc} will not contain the lag
   specified in the constraint.  Use {cmd:var} directly to obtain
   selection-order criteria with constraints on lags of the endogenous
   variables.

{phang}
{opt noconstant} suppresses the constant terms from the model.  By default,
   constant terms are included.

{phang}
{opt lutstats} requests that the
   {help varsoc##L2005:L{c u:}tkepohl (2005)} versions of the
   information criteria be reported.  See 
   {it:{mansection TS varsocMethodsandformulas:Methods and formulas}} in
   {hi:[TS] varsoc} for details.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, that is used
   to identify the first likelihood-ratio test that rejects the null
   hypothesis that the additional parameters from adding a lag are jointly
   zero.  The default is {cmd:level(95)} or as set by {helpb set level}.

{phang}
{opt separator(#)} specifies how often separator lines should be drawn between
   rows.  By default, separator lines do not appear.  For example,
   {cmd:separator(1)} would draw a line between each row, {cmd:separator(2)}
   between every other row, and so on.


{marker post_option}{...}
{title:Postestimation option}

{phang}
{opt estimates(estname)} specifies the name of a previously stored set of
   {cmd:var} or {cmd:svar} estimates.  When no {depvarlist} is specified,
   {opt varsoc} uses the postestimation syntax and uses the currently
   active estimation results or the results specified in
   {opt estimates(estname)}.  See {manhelp estimates R} for information about
   saving and restoring estimation results.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse lutkepohl2}

{pstd}Preestimation {cmd:varsoc}, used to select the lag order for a
VAR or VECM{p_end}
{phang2}{cmd:. varsoc dln_inv dln_inc dln_consump}

{pstd}Same as above, but report L{c u:}tkepohl versions of the information
criteria{p_end}
{phang2}{cmd:. varsoc dln_inv dln_inc dln_consump, lutstats}

{pstd}Fit vector autoregressive model{p_end}
{phang2}{cmd:. var dln_inc dln_consump if qtr<=tq(1978q4), exog(l.dln_inv)}
{p_end}

{pstd}Postestimation {cmd:varsoc}{p_end}
{phang2}{cmd:. varsoc}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:varsoc} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(tmax)}}last time period in sample{p_end}
{synopt:{cmd:r(tmin)}}first time period in sample{p_end}
{synopt:{cmd:r(mlag)}}maximum lag order{p_end}
{synopt:{cmd:r(N_gaps)}}the number of gaps in the sample{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(endog)}}names of endogenous variables{p_end}
{synopt:{cmd:r(lutstats)}}{cmd:lutstats}, if specified{p_end}
{synopt:{cmd:r(cns}{it:#}{cmd:)}}the {it:#}th constraint{p_end}
{synopt:{cmd:r(exog)}}names of exogenous variables{p_end}
{synopt:{cmd:r(rmlutstats)}}{cmd:rmlutstats}, if specified{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(stats)}}LL, LR, FPE, AIC, HQIC, SBIC, and p-values{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker L2005}{...}
{phang}
L{c u:}tkepohl, H. 2005. 
{browse "http://www.stata.com/bookstore/imtsa.html":{it:New Introduction to Multiple Time Series Analysis}}.
New York: Springer.

{marker N2001}{...}
{phang}
Nielsen, B. 2001. Order determination in general vector autoregressions.
Working paper, Department of Economic, University of Oxford and Nuffield
College. {browse "http://ideas.repec.org/p/nuf/econwp/0110.html":http://ideas.repec.org/p/nuf/econwp/0110.html}.
{p_end}

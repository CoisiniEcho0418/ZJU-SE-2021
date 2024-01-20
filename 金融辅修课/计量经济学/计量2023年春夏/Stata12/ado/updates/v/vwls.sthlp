{smcl}
{* *! version 1.1.15  15aug2011}{...}
{viewerdialog vwls "dialog vwls"}{...}
{vieweralsosee "[R] vwls" "mansection R vwls"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] vwls postestimation" "help vwls postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{viewerjumpto "Syntax" "vwls##syntax"}{...}
{viewerjumpto "Description" "vwls##description"}{...}
{viewerjumpto "Options" "vwls##options"}{...}
{viewerjumpto "Examples" "vwls##examples"}{...}
{viewerjumpto "Saved results" "vwls##saved_results"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink R vwls} {hline 2}}Variance-weighted least squares{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:vwls} {depvar} {indepvars} {ifin} {weight} 
[{cmd:,} {it:options}]

{synoptset 17 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Model}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{synopt :{opth sd(varname)}}variable containing estimate of conditional
standard deviation{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{it:{help vwls##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}{cmd:bootstrap}, {cmd:by}, {cmd:jackknife}, {cmd:rolling}, 
and {cmd:statsby} are allowed; see {help prefix}.{p_end}
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{cmd:fweight}s are allowed; see {help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}See {manhelp vwls_postestimation R:vwls postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Other >}
         {bf:Variance-weighted least squares}


{marker description}{...}
{title:Description}

{pstd}
{cmd:vwls} estimates a linear regression using variance-weighted least
squares.  It differs from ordinary least-squares (OLS) regression in that it
does not assume homogeneity of variance, but requires that the conditional
variance of {depvar} be estimated prior to the regression.  The estimated
variance need not be constant across observations.  {cmd:vwls} treats the
estimated variance as if it were the true variance when it computes standard
errors of the coefficients.

{pstd}
You must supply an estimate of the conditional standard deviation of {it:depvar}
to {cmd:vwls} by using the {opth sd(varname)} option, or you must have grouped
data with groups defined by the {indepvars} variables.  In the latter case,
{cmd:vwls} treats all {it:indepvars} as categorical variables, computes the
mean and standard deviation of {it:depvar} separately for each subgroup, and 
computes the regression of the subgroup means on {it:indepvars}. 

{pstd}
{cmd:regress} with analytic weights can be used to produce another kind of
"variance-weighted least squares"; see 
{mansection R vwlsRemarks:{it:Remarks}} in {bf:[R] vwls} for an explanation of
the difference.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant}; see
{helpb estimation options##noconstant:[R] estimation options}. 

{phang}
{opth sd(varname)} specifies an estimate of the conditional standard deviation
of {depvar} (that is, it can vary observation by observation).  All values of
{it:varname} must be > 0.  If you specify {opt sd()}, you cannot use
{cmd:fweight}s.

{pmore}
If {opt sd()} is not given, the data will be grouped by {indepvars}.  Here 
{it:indepvars} are treated as categorical variables, and the means and
standard deviations of {it:depvars} for each subgroup are calculated and used
for the regression.  Any subgroup for which the standard deviation is zero is
dropped.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}. 

{marker display_options}{...}
{phang}
{it:display_options}:
{opt noomit:ted},
{opt vsquish},
{opt noempty:cells},
{opt base:levels},
{opt allbase:levels},
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.

{pstd}
The following option is available with {opt vwls} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse bp}{p_end}

{pstd}Fit variance-weighted least-squares linear regression{p_end}
{phang2}{cmd:. vwls bp gender race}

{pstd}Replay results, showing coefficients, standard errors, and CIs with
4 decimal places{p_end}
{phang2}{cmd:. vwls, cformat(%8.4f)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:vwls} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(chi2)}}model chi-squared{p_end}
{synopt:{cmd:e(df_gf)}}goodness-of-fit degrees of freedom{p_end}
{synopt:{cmd:e(chi2_gf)}}goodness-of-fit chi-squared{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:vwls}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

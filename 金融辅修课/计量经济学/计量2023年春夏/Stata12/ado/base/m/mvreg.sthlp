{smcl}
{* *! version 1.1.12  03may2011}{...}
{viewerdialog mvreg "dialog mvreg"}{...}
{vieweralsosee "[R] mvreg" "mansection R mvreg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] mvreg postestimation" "help mvreg postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] manova" "help manova"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] nlsur" "help nlsur"}{...}
{vieweralsosee "[R] reg3" "help reg3"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[R] regress postestimation" "help regress_postestimation"}{...}
{vieweralsosee "[SEM] sem" "help sem"}{...}
{vieweralsosee "[R] sureg" "help sureg"}{...}
{viewerjumpto "Syntax" "mvreg##syntax"}{...}
{viewerjumpto "Description" "mvreg##description"}{...}
{viewerjumpto "Options" "mvreg##options"}{...}
{viewerjumpto "Examples" "mvreg##examples"}{...}
{viewerjumpto "Saved results" "mvreg##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink R mvreg} {hline 2}}Multivariate regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:mvreg} {it:{help varlist:depvars}} {cmd:=} {indepvars} {ifin} {weight} 
[{cmd:,} {it:options}]

{synoptset 18 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{synopt :{opt nocon:stant}}suppress constant term{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt cor:r}}report correlation matrix{p_end}
{synopt :{it:{help mvreg##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{synopt:{opt noh:eader}}suppress header table from above coefficient table{p_end}
{synopt:{opt not:able}}suppress coefficient table{p_end}
INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}{it:depvars} and {it:indepvars} may contain time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}
{opt bootstrap}, {opt by}, {opt jackknife}, {opt mi estimate}, {opt rolling},
and {opt statsby} are allowed; see {help prefix}.{p_end}
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{cmd:aweight}s are not allowed with the {helpb jackknife} prefix.
{p_end}
{p 4 6 2}
{opt aweight}s and {opt fweight}s are allowed; see {help weight}.{p_end}
{p 4 6 2}{opt noheader}, {opt notable}, and {opt coeflegend} do not appear 
in the dialog box.{p_end}
{p 4 6 2}
See {manhelp mvreg_postestimation R:mvreg postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Multiple-equation models >}
     {bf:Multivariate regression}


{marker description}{...}
{title:Description}

{pstd}
{cmd:mvreg} fits multivariate regression models.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant} suppresses the constant term (intercept) in the model.

{dlgtab:Reporting}

{phang}
{opt level(#)} specifies the confidence level, as a percentage,
for confidence intervals.  The default is {cmd:level(95)} or as set by
{helpb set level}.

{phang}
{opt corr} displays the correlation matrix of the residuals between
equations.

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
The following options are available with {cmd:mvreg} but are not shown in the
dialog box:

{phang}
{opt noheader} suppresses display of the table reporting F statistics,
R-squared, and root mean squared error above the coefficient table.

{phang}
{opt notable} suppresses display of the coefficient table.

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Fit multivariate regression model{p_end}
{phang2}{cmd:. mvreg headroom trunk turn = price mpg displ gear_ratio length weight}{p_end}

{pstd}Replay results, suppressing header and coefficient tables but 
reporting correlation matrix{p_end}
{phang2}{cmd:. mvreg, notable noheader corr}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:mvreg} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(k)}}number of parameters in each equation{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(chi2)}}Breusch-Pagan chi-squared ({cmd:corr} only){p_end}
{synopt:{cmd:e(df_chi2)}}degrees of freedom for Breusch-Pagan chi-squared
	({cmd:corr} only){p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:mvreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}names of dependent variables{p_end}
{synopt:{cmd:e(eqnames)}}names of equations{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(r2)}}R-squared for each equation{p_end}
{synopt:{cmd:e(rmse)}}RMSE for each equation{p_end}
{synopt:{cmd:e(F)}}F statistic for each equation{p_end}
{synopt:{cmd:e(p_F)}}significance of F for each equation{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsok)}}predictions allowed by {cmd:margins}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(Sigma)}}Sigma hat matrix{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

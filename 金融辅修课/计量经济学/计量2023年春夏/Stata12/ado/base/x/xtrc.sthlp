{smcl}
{* *! version 1.1.17  28apr2011}{...}
{viewerdialog xtrc "dialog xtrc"}{...}
{vieweralsosee "[XT] xtrc" "mansection XT xtrc"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtrc postestimation" "help xtrc postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[XT] xtmixed" "help xtmixed"}{...}
{vieweralsosee "[XT] xtreg" "help xtreg"}{...}
{viewerjumpto "Syntax" "xtrc##syntax"}{...}
{viewerjumpto "Description" "xtrc##description"}{...}
{viewerjumpto "Options" "xtrc##options"}{...}
{viewerjumpto "Examples" "xtrc##examples"}{...}
{viewerjumpto "Saved results" "xtrc##saved_results"}{...}
{viewerjumpto "Reference" "xtrc##reference"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink XT xtrc} {hline 2}}Random-coefficients regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 13 2}
{cmd:xtrc} {depvar} {indepvars} {ifin} [{cmd:,} {it:options}]

{synoptset 19 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt :{opt noc:onstant}}suppress constant term{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient constrained to 1{p_end}

{syntab:SE}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt conventional},
  {opt boot:strap}, or {opt jack:knife}{p_end}

{syntab:Reporting}
{synopt :{opt level(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt beta:s}}display group-specific best linear predictors{p_end}
{synopt :{it:{help xtrc##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
A panel variable must be specified; use {helpb xtset}.{p_end}
INCLUDE help fvvarlist
{p 4 6 2}
{opt by}, {opt mi estimate}, and {opt statsby} are allowed; see {help prefix}.{p_end}
INCLUDE help vce_mi
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp xtrc_postestimation XT:xtrc postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Longitudinal/panel data > Random-coefficients regression by GLS}


{marker description}{...}
{title:Description}

{pstd}
{cmd:xtrc} fits the {help xtrc##S1970:Swamy (1970)} random-coefficients
linear regression model.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt noconstant}, {opth offset(varname)}; see
{helpb estimation options:[R] estimation options}.

{dlgtab:SE}

INCLUDE help xt_vce_asymptbj

{pmore}
{cmd:vce(conventional)}, the default, uses the conventionally derived variance
estimator for generalized least squares regression.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt betas} requests that the group-specific best linear predictors also be
displayed.

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
The following option is available with {opt xtrc} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse invest2}{p_end}

{pstd}Fit random-coefficients linear regression model{p_end}
{phang2}{cmd:. xtrc invest market stock}{p_end}

{pstd}Replay results and show group-specific best linear predictors{p_end}
{phang2}{cmd:. xtrc, beta}

{pstd}Replay results, showing coefficients, standard errors, and CIs to
4 decimal places{p_end}
{phang2}{cmd:. xtrc, cformat(%8.4f)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:xtrc} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(chi2_c)}}chi-squared for comparison test{p_end}
{synopt:{cmd:e(df_chi2c)}}degrees of freedom for comparison chi-squared test{p_end}
{synopt:{cmd:e(g_min)}}smallest group size{p_end}
{synopt:{cmd:e(g_avg)}}average group size{p_end}
{synopt:{cmd:e(g_max)}}largest group size{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtrc}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(tvar)}}variable denoting time within groups{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald}; type of model chi-squared test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(Sigma)}}Sigma hat matrix{p_end}
{synopt:{cmd:e(beta_ps)}}matrix of best linear predictors{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_ps)}}matrix of variances for the best linear predictors; row
	{it:i} contains vec of variance matrix for group {it:i} predictor{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker reference}{...}
{title:Reference}

{marker S1970}{...}
{phang}
Swamy, P. A. V. B. 1970.
Efficient inference in a random coefficient regression model.
{it:Econometrica} 38: 311-323.
{p_end}

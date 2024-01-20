{smcl}
{* *! version 1.2.11  11feb2011}{...}
{viewerdialog xthtaylor "dialog xthtaylor"}{...}
{vieweralsosee "[XT] xthtaylor" "mansection XT xthtaylor"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xthtaylor postestimation" "help xthtaylor postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtset" "help xtset"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtivreg" "help xtivreg"}{...}
{vieweralsosee "[XT] xtreg" "help xtreg"}{...}
{viewerjumpto "Syntax" "xthtaylor##syntax"}{...}
{viewerjumpto "Description" "xthtaylor##description"}{...}
{viewerjumpto "Options" "xthtaylor##options"}{...}
{viewerjumpto "Examples" "xthtaylor##examples"}{...}
{viewerjumpto "Saved results" "xthtaylor##saved_results"}{...}
{viewerjumpto "References" "xthtaylor##references"}{...}
{title:Title}

{p2colset 5 23 25 2}{...}
{p2col :{manlink XT xthtaylor} {hline 2}}Hausman-Taylor estimator for error-components models{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}{cmd:xthtaylor} {depvar} {indepvars} {ifin} {weight} 
{cmd:,} {opth e:ndog(varlist)} [{it:options}]

{synoptset 23 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt :{opt nocons:tant}}suppress constant term{p_end}
{p2coldent :* {opth e:ndog(varlist)}}explanatory variables in {indepvars} to be treated as endogenous{p_end}
{synopt :{opth cons:tant(varlist:varlist_ti)}}independent variables that are constant within panel{p_end}
{synopt :{opth v:arying(varlist:varlist_tv)}}independent variables that are time varying within panel{p_end}
{synopt :{opt am:acurdy}}fit model based on Amemiya and MaCurdy estimator{p_end}

{syntab:SE}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt conventional},
        {opt boot:strap}, or {opt jack:knife}{p_end}

{syntab:Reporting}
{synopt :{opt level(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt s:mall}}report small-sample statistics{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt endog(varlist)} is required.{p_end}
{p 4 6 2}
A panel variable must be specified.  For  {cmd:xthtaylor, amacurdy}, a time variable must also be specified. Use {helpb xtset}.{p_end}
{p 4 6 2}
{it:depvar}, {it:indepvars}, and all {it:varlists} may contain time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}
{opt by}, {opt statsby}, and {cmd:xi} are allowed; see {help prefix}.{p_end}
{p 4 6 2}
{opt iweight}s and {opt fweight}s are allowed unless the {opt amacurdy} option
 is specified.  Weights must be constant within panel; see {help weight}.{p_end}
{p 4 6 2}
See {manhelp xthtaylor_postestimation XT:xthtaylor postestimation} for
features available after estimation.{p_end}

{title:Menu}

{phang}
{bf:Statistics > Longitudinal/panel data > Endogenous covariates >}
     {bf:Hausman-Taylor regression (RE)}


{marker description}{...}
{title:Description}

{pstd}
{cmd: xthtaylor} fits panel-data random-effects models in which some of
the covariates are correlated with the unobserved individual-level
random effect.  The estimators, originally proposed by
{help xthtaylor##HT1981:Hausman and Taylor (1981)} and
{help xthtaylor##AM1986:Amemiya and MaCurdy (1986)}, are based on instrumental
variables.  By default, {cmd:xthtaylor} uses the Hausman-Taylor estimator.
When the {cmd:amacurdy} option is specified, {cmd:xthtaylor} uses the
Amemiya-MaCurdy estimator.

{pstd}
Although the estimators implemented in {cmd:xthtaylor} and {cmd:xtivreg} (see
{helpb xtivreg:[XT] xtivreg}) use the method of instrumental variables, each
command is designed for different problems.  The estimators implemented in
{cmd:xtivreg} assume that a subset of the explanatory variables in the model
are correlated with the idiosyncratic error e[i,t].  In contrast, the
Hausman-Taylor and Amemiya-MaCurdy estimators that are implemented in
{cmd:xthtaylor} assume that some of the explanatory variables are correlated
with the individual-level random effects, u[i], but that none of the
explanatory variables are correlated with the idiosyncratic error e[i,t].


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt noconstant}; see
    {helpb estimation options##noconstant:[R] estimation options}.

{phang}
{opth endog(varlist)} specifies that a subset of explanatory variables in
{indepvars} be treated as endogenous variables, that is, the explanatory
variables that are assumed to be correlated with the unobserved random effect.
{opt endog()} is required.

{phang}
{opth "constant(varlist:varlist_ti)"} specifies the subset of variables in
{indepvars} that are time invariant, that is, constant within panel.  By using
this option, you assert not only that the variables specified in
{it:varlist_ti} are time invariant, but also that all other variables in
{it:indepvars} are time varying.  If this assertion is false, {cmd:xthtaylor}
does not perform the estimation and will issue an error message.
{cmd:xthtaylor} automatically detects which variables are time invariant and
which are not.  However, users may want to check their understanding of the
data and specify which variables are time invariant and which are not.

{phang}
{opth "varying(varlist:varlist_tv)"} specifies the subset of the variables in
{indepvars} that are time varying.  By using this option, you assert not only 
that the variables specified in {it:varlist_tv} are time varying, but also
that all other variables in {it:indepvars} are time-invariant.  If this
assertion is false, {cmd:xthtaylor} does not perform the estimation and will
issue an error message.  {cmd:xthtaylor} automatically detects which variables
are time varying and which are not.  However, users may want to check their
understanding of the data and specify which variables are time varying and
which are not.

{phang}
{cmd:amacurdy} specifies that the Amemiya-MaCurdy estimator be used.  This
estimator uses extra instruments to gain efficiency at the cost of additional
assumptions on the data-generating process.  This option may be specified only
for samples containing balanced panels, and weights may not be specified.  The
panels must also have a common initial period.

{dlgtab:SE}

INCLUDE help xt_vce_asymptbj

{pmore}
{cmd:vce(conventional)}, the default, uses the conventionally derived variance
estimator for this Hausman-Taylor model.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt small} specifies that the {it:p}-values from the Wald tests in
the output and all subsequent Wald tests obtained via {cmd:test} 
use {it:t} and {it:F} distributions instead of the large-sample normal
and chi-squared distributions.  By default, the {it:p}-values are obtained
using the normal and chi-squared distributions.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse psidextract}{p_end}

{pstd}Hausman-Taylor estimates{p_end}
{phang2}{cmd:. xthtaylor lwage wks south smsa ms exp exp2 occ ind union fem}
           {cmd:blk ed, endog(exp exp2 occ ind union ed) constant(fem blk ed)}

{pstd}Amemiya-MaCurdy estimates{p_end}
{phang2}{cmd:. xthtaylor lwage wks south smsa ms exp exp2 occ ind union fem}
           {cmd:blk ed, endog(exp exp2 occ ind union ed) amacurdy}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:xthtaylor} saves the following in {cmd:e()}:

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom ({cmd:small} only){p_end}
{synopt:{cmd:e(g_min)}}smallest group size{p_end}
{synopt:{cmd:e(g_avg)}}average group size{p_end}
{synopt:{cmd:e(g_max)}}largest group size{p_end}
{synopt:{cmd:e(Tcon)}}{cmd:1} if panels balanced; {cmd:0} otherwise{p_end}
{synopt:{cmd:e(sigma_u)}}panel-level standard deviation{p_end}
{synopt:{cmd:e(sigma_e)}}standard deviation of epsilon_it{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(rho)}}rho{p_end}
{synopt:{cmd:e(F)}}model F ({cmd:small} only){p_end}
{synopt:{cmd:e(Tbar)}}harmonic mean of group sized{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xthtaylor}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(tvar)}}variable denoting time within groups, {cmd:amacurdy} only{p_end}
{synopt:{cmd:e(TVexogenous)}}exogenous time-varying variables{p_end}
{synopt:{cmd:e(TIexogenous)}}exogenout time-invariant variables{p_end}
{synopt:{cmd:e(TVendogenous)}}endogenous time-varying variables{p_end}
{synopt:{cmd:e(TIendogenous)}}endogenous time-invariant variables{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}{cmd:Hausman-Taylor} or {cmd:Amemiya-MaCurdy}{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald}; type of model chi-squared test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 18 tabbed}{...}
{p2col 5 18 22 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker AM1986}{...}
{phang}
Amemiya, T., and T. E. MaCurdy. 1986. Instrumental-variable estimation of an
error-components model. {it:Econometrica} 54: 869-880.

{marker HT1981}{...}
{phang}
Hausman, J. A., and W. E. Taylor. 1981. Panel data and unobservable individual
effects. {it:Econometrica} 49: 1377-1398.
{p_end}

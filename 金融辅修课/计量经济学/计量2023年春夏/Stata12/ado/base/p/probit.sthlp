{smcl}
{* *! version 1.2.17  03jun2011}{...}
{viewerdialog probit "dialog probit"}{...}
{viewerdialog "svy: probit" "dialog probit, message(-svy-) name(svy_probit)"}{...}
{vieweralsosee "[R] probit" "mansection R probit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] probit postestimation" "help probit postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] asmprobit" "help asmprobit"}{...}
{vieweralsosee "[R] biprobit" "help biprobit"}{...}
{vieweralsosee "[R] brier" "help brier"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] glm" "help glm"}{...}
{vieweralsosee "[R] hetprob" "help hetprob"}{...}
{vieweralsosee "[R] ivprobit" "help ivprobit"}{...}
{vieweralsosee "[R] logistic" "help logistic"}{...}
{vieweralsosee "[R] logit" "help logit"}{...}
{vieweralsosee "[R] mprobit" "help mprobit"}{...}
{vieweralsosee "[R] roc" "help roc"}{...}
{vieweralsosee "[R] scobit" "help scobit"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy_estimation"}{...}
{vieweralsosee "[XT] xtprobit" "help xtprobit"}{...}
{viewerjumpto "Syntax" "probit##syntax"}{...}
{viewerjumpto "Description" "probit##description"}{...}
{viewerjumpto "Options" "probit##options"}{...}
{viewerjumpto "Examples" "probit##examples"}{...}
{viewerjumpto "Saved results" "probit##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink R probit} {hline 2}}Probit regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{opt prob:it} {depvar} [{indepvars}] {ifin} {weight} 
[{cmd:,} {it:options}]

{synoptset 28 tabbed}{...}
{synopthdr :options}
{synoptline}
{syntab :Model}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient
constrained to 1{p_end}
{synopt :{opt asis}}retain perfect predictor variables{p_end}
{synopt :{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab :SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
   {opt r:obust}, {opt cl:uster} {it:clustvar}, {opt boot:strap}, or 
   {opt jack:knife}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is
{cmd:level(95)}{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help probit##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab :Maximization}
{synopt :{it:{help probit##probit_maximize:maximize_options}}}control the maximization process; seldom
used{p_end}

{synopt :{opt nocoe:f}}do not display the coefficient table; seldom
used{p_end}
INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}{it:depvar} and {it:indepvars} may
contain time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}{cmd:bootstrap}, {cmd:by}, {opt fracpoly}, {cmd:jackknife},
{opt mfp}, {cmd:mi estimate}, {cmd:nestreg},
{cmd:rolling}, {cmd:statsby}, {cmd:stepwise}, and {cmd:svy}
are allowed; see {help prefix}.{p_end}
INCLUDE help vce_mi
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{opt vce()}, {opt nocoef}, and weights are not allowed with the
{helpb svy} prefix.
{p_end}
{p 4 6 2}{opt fweight}s, {opt iweight}s, and {opt pweight}s
are allowed; see {help weight}.{p_end}
{p 4 6 2}{opt nocoef} and {opt coeflegend} do not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp probit_postestimation R:probit postestimation} for features
available after estimation.  {p_end}


{title:Menu}

{phang2}
{bf:Statistics > Binary outcomes > Probit regression}


{marker description}{...}
{title:Description}

{pstd}
{cmd:probit} fits a maximum-likelihood probit model.

{pstd}
If estimating on grouped data, see {helpb bprobit}.

{pstd}
Several auxiliary command may be run after {cmd:probit}, {cmd:logit}, or
{cmd:logistic}; see
{manhelp logistic_postestimation R:logistic postestimation} for a description
of these commands.

{pstd}
See {help logistic estimation commands} for a list of related estimation
commands.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant}, {opth offset(varname)},
{opt constraints(constraints)}, {opt collinear}; see
{helpb estimation options:[R] estimation options}.

{phang}
{marker asis}
{opt asis} specifies that all specified variables and observations be retained
in the maximization process.  This option is typically not specified and may
introduce numerical instability.  Normally {cmd:probit} drops variables that
perfectly predict success or failure in the dependent variable along with
their associated observations.  In those cases, the effective coefficient on
the dropped variables is infinity (negative infinity) for variables that
completely determine a success (failure).  Dropping the variable and perfectly
predicted observations has no effect on the likelihood or estimates of the
remaining coefficients and increases the numerical stability of the
optimization process.  Specifying this option forces retention of perfect
predictor variables and their associated observations.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{dlgtab:Reporting}

{phang}
{opt level(#)}; see 
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt nocnsreport}; see
     {helpb estimation options##nocnsreport:[R] estimation options}.

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

{marker probit_maximize}{...}
{dlgtab:Maximization}

{phang}
{it:maximize_options}:
{opt dif:ficult},
{opth tech:nique(maximize##algorithm_spec:algorithm_spec)},
{opt iter:ate(#)}, [{cmd:{ul:no}}]{opt lo:g}, {opt tr:ace}, 
{opt grad:ient}, {opt showstep},
{opt hess:ian},
{opt showtol:erance},
{opt tol:erance(#)},
{opt ltol:erance(#)},
{opt nrtol:erance(#)},
{opt nonrtol:erance}, and
{opt from(init_specs)}; see {manhelp maximize R}.  These options are seldom
used.

{pstd}
The following options are available with {opt probit} but are not shown in the
dialog box:

{phang}
{opt nocoef} specifies that the coefficient table not be displayed.  This
option is sometimes used by programmers but is of no use interactively. 

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Probit regression{p_end}
{phang2}{cmd:. probit foreign weight mpg}{p_end}

{phang}Same as above, but with robust standard errors{p_end}
{phang2}{cmd:. probit foreign weight mpg, vce(robust)}{p_end}

    {hline}
    Setup
{phang2}{cmd:. webuse union}{p_end}

{pstd}Probit regression{p_end}
{phang2}{cmd:. probit union age grade not_smsa south##c.year}{p_end}

{phang}Same as above, but adjust standard errors for clusters in {cmd:id}{p_end}
{phang2}{cmd:. probit union age grade not_smsa south##c.year, vce(cluster id)}
{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse nhanes2d}{p_end}
{phang2}{cmd:. svyset}

{pstd}Probit regression using survey data{p_end}
{phang2}{cmd:. svy: probit highbp height weight age female}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:probit} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_cds)}}number of completely determined successes{p_end}
{synopt:{cmd:e(N_cdf)}}number of completely determined failures{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(r2_p)}}pseudo-R-squared{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:probit}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(opt)}}type of optimization{p_end}
{synopt:{cmd:e(which)}}{cmd:max} or {cmd:min}; whether optimizer is to perform
                     maximization or minimization{p_end}
{synopt:{cmd:e(ml_method)}}type of {cmd:ml} method{p_end}
{synopt:{cmd:e(user)}}name of likelihood-evaluator program{p_end}
{synopt:{cmd:e(technique)}}maximization technique{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(Cns)}}constraints matrix{p_end}
{synopt:{cmd:e(ilog)}}iteration log (up to 20 iterations){p_end}
{synopt:{cmd:e(gradient)}}gradient vector{p_end}
{synopt:{cmd:e(mns)}}vector of means of the independent variables{p_end}
{synopt:{cmd:e(rules)}}information about perfect predictors{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

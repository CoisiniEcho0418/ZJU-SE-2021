{smcl}
{* *! version 1.2.19  03jun2011}{...}
{viewerdialog ologit "dialog ologit"}{...}
{viewerdialog "svy: ologit" "dialog ologit, message(-svy-) name(svy_ologit)"}{...}
{vieweralsosee "[R] ologit" "mansection R ologit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] ologit postestimation" "help ologit postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] clogit" "help clogit"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] logistic" "help logistic"}{...}
{vieweralsosee "[R] logit" "help logit"}{...}
{vieweralsosee "[R] mlogit" "help mlogit"}{...}
{vieweralsosee "[R] oprobit" "help oprobit"}{...}
{vieweralsosee "[R] rologit" "help rologit"}{...}
{vieweralsosee "[R] slogit" "help slogit"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy_estimation"}{...}
{viewerjumpto "Syntax" "ologit##syntax"}{...}
{viewerjumpto "Description" "ologit##description"}{...}
{viewerjumpto "Options" "ologit##options"}{...}
{viewerjumpto "Examples" "ologit##examples"}{...}
{viewerjumpto "Saved results" "ologit##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink R ologit} {hline 2}}Ordered logistic regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmdab:olog:it}
{depvar}
[{indepvars}]
{ifin}
{weight}
[{cmd:,} {it:options}]

{synoptset 28 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Model}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient constrained to 1{p_end}
{synopt :{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab :SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
        {opt r:obust}, {opt cl:uster} {it:clustvar}, {opt boot:strap}, or
	{opt jack:knife}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt or}}report odds ratios{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help ologit##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab :Maximization}
{synopt :{it:{help ologit##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}{it:depvar} and {it:indepvars} may contain time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}
{opt bootstrap}, {opt by}, {opt fracpoly}, {opt jackknife}, {opt mfp},
{opt mi estimate}, {opt nestreg}, {opt rolling}, {opt statsby},
{opt stepwise}, and {opt svy} are allowed; see {help prefix}.{p_end}
INCLUDE help vce_mi
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}
{opt vce()} and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}
{opt fweight}s, {opt iweight}s, and {opt pweight}s are allowed; see {help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp ologit_postestimation R:ologit postestimation} for features
available after estimation.  {p_end}


{title:Menu}

{phang}
{bf:Statistics > Ordinal outcomes > Ordered logistic regression}


{marker description}{...}
{title:Description}

{pstd}
{opt ologit} fits ordered logit models of ordinal variable {depvar} on the
independent variables {indepvars}.  The actual values taken on by the dependent
variable are irrelevant, except that larger values are assumed to correspond
to "higher" outcomes.

{pstd}
See {help logistic estimation commands} for a list of related estimation
commands.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opth offset(varname)},
{opt constraints(constraints)}, {opt collinear}; see
{helpb estimation options:[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{dlgtab:Reporting}

{phang}
{opt level(#)}; see 
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt or} reports the estimated coefficients transformed to odds
ratios, that is, exp(b) rather than b.  Standard errors and confidence intervals
are similarly transformed.  This option affects how results are displayed,
not how they are estimated.  {opt or} may be specified at
estimation or when replaying previously estimated results.

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

{marker maximize_options}{...}
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
The following option is available with {opt ologit} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse fullauto}{p_end}

{pstd}Ordered logistic regression{p_end}
{phang2}{cmd:. ologit rep77 foreign length mpg}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse nhanes2f}{p_end}
{phang2}{cmd:. svyset psuid [pw=finalwgt], strata(stratid)}

{pstd}Ordered logistic regression with survey data{p_end}
{phang2}{cmd:. svy: ologit health female black age c.age#c.age}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:ologit} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_cd)}}number of completely determined observations{p_end}
{synopt:{cmd:e(k_cat)}}number of categories{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
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
{synopt:{cmd:e(cmd)}}{cmd:ologit}{p_end}
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
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(Cns)}}constraints matrix{p_end}
{synopt:{cmd:e(ilog)}}iteration log (up to 20 iterations){p_end}
{synopt:{cmd:e(gradient)}}gradient vector{p_end}
{synopt:{cmd:e(cat)}}category values{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

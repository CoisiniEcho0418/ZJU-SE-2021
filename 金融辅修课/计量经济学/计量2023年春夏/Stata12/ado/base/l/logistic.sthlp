{smcl}
{* *! version 1.3.4  03may2011}{...}
{viewerdialog logistic "dialog logistic"}{...}
{viewerdialog "svy: logistic" "dialog logistic, message(-svy-) name(svy_logistic)"}{...}
{vieweralsosee "[R] logistic" "mansection R logistic"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] logistic postestimation" "help logistic postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] brier" "help brier"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] exlogistic" "help exlogistic"}{...}
{vieweralsosee "[R] logit" "help logit"}{...}
{vieweralsosee "[R] roc" "help roc"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy_estimation"}{...}
{vieweralsosee "[XT] xtlogit" "help xtlogit"}{...}
{viewerjumpto "Syntax" "logistic##syntax"}{...}
{viewerjumpto "Description" "logistic##description"}{...}
{viewerjumpto "Options" "logistic##options"}{...}
{viewerjumpto "Examples" "logistic##examples"}{...}
{viewerjumpto "Saved results" "logistic##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink R logistic} {hline 2}}Logistic regression, reporting odds ratios{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}
{cmd:logistic} {depvar} {indepvars} {ifin} {weight} [{cmd:,}
{it:options}] 

{synoptset 28 tabbed}{...}
{synopthdr}
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
{synopt :{opt coef}}report estimated coefficients{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help logistic##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab :Maximization}
{synopt :{it:{help logistic##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}
{it:depvar} and {it:indepvars} may contain time-series operators;
see {help tsvarlist}.{p_end}
{p 4 6 2}
{cmd:bootstrap}, {cmd:by}, {opt fracpoly}, {cmd:jackknife}, {opt mfp},
{cmd:mi estimate}, {cmd:nestreg}, {cmd:rolling}, {cmd:statsby},
{cmd:stepwise}, and {cmd:svy} are allowed; see {help prefix}.{p_end}
INCLUDE help vce_mi
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{opt vce()} and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}
{cmd:fweight}s, {cmd:iweight}s, and {cmd:pweight}s are allowed; see
{help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp logistic_postestimation R:logistic postestimation} for features
available after estimation.  {p_end}


{title:Menu}

{phang}
{bf:Statistics > Binary outcomes > Logistic regression (reporting odds ratios)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:logistic} fits a logistic regression model of {depvar} on {indepvars},
where {it:depvar} is a 0/1 variable (or, more precisely, a 0/non-0 variable).
Without arguments, {cmd:logistic} redisplays the last {cmd:logistic}
estimates.  {cmd:logistic} displays estimates as odds ratios; to view
coefficients, type {cmd:logit} after running {cmd:logistic}.  To obtain odds
ratios for any covariate pattern relative to another, see {manhelp lincom R}.

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
{opt asis} forces retention of perfect predictor variables and their
associated perfectly predicted observations and may produce instabilities in
maximization; see {manhelp probit R}.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{dlgtab:Reporting}

{phang}
{opt level(#)}; see 
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt coef} causes {cmd:logistic} to report the estimated coefficients
rather than the odds ratios (exponentiated coefficients).  {cmd:coef} may be
specified when the model is fit or may be used later to redisplay results.
{cmd:coef} affects only how results are displayed and not how they are
estimated.

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
The following option is available with {opt logistic} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse lbw}{p_end}

{pstd}Logistic regression{p_end}
{phang2}{cmd:. logistic low age lwt i.race smoke ptl ht ui}{p_end}

{pstd}Same as above, but use a robust estimate of variance{p_end}
{phang2}{cmd:. logistic low age lwt i.race smoke ptl ht ui, vce(robust)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse nhanes2d}{p_end}
{phang2}{cmd:. svyset}

{pstd}Logistic regression using survey data{p_end}
{phang2}{cmd:. svy: logistic highbp height weight age female}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse mheart5}{p_end}
{phang2}{cmd:. mi set mlong}{p_end}
{phang2}{cmd:. mi register imputed age bmi}{p_end}
{phang2}{cmd:. mi impute mvn age bmi = attack smokes hsgrad female, add(10)}

{pstd}Fit the logistic model separately on each of the 10 imputed datasets and
   combine the results{p_end}
{phang2}{cmd:. mi estimate, or: logistic attack smokes age bmi hsgrad female}

    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:logistic} saves the following in {cmd:e()}:

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
{synopt:{cmd:e(cmd)}}{cmd:logit}{p_end}
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
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}
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

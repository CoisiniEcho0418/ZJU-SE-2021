{smcl}
{* *! version 1.1.18  18may2011}{...}
{viewerdialog scobit "dialog scobit"}{...}
{viewerdialog "svy: scobit" "dialog scobit, message(-svy-) name(svy_scobit)"}{...}
{vieweralsosee "[R] scobit" "mansection R scobit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] scobit postestimation" "help scobit postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] cloglog" "help cloglog"}{...}
{vieweralsosee "[R] glm" "help glm"}{...}
{vieweralsosee "[R] logistic" "help logistic"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy estimation"}{...}
{viewerjumpto "Syntax" "scobit##syntax"}{...}
{viewerjumpto "Description" "scobit##description"}{...}
{viewerjumpto "Options" "scobit##options"}{...}
{viewerjumpto "Examples" "scobit##examples"}{...}
{viewerjumpto "Saved results" "scobit##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col:{manlink R scobit} {hline 2}}Skewed logistic regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:scobit}
{depvar}
[{indepvars}]
{ifin}
{weight}
[{cmd:,} {it:options}]

{synoptset 26 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{synopt:{opt nocon:stant}}suppress constant term{p_end}
{synopt:{opth off:set(varname)}}include {it:varname} in model with coefficient
constrained to 1{p_end}
{synopt:{opt asis}}retain perfect predictor variables{p_end}
{synopt:{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
{opt r:obust}, {opt cl:uster} {it:clustvar},
{opt opg}, {opt boot:strap}, or {opt jack:knife}{p_end}

{syntab:Reporting}
{synopt:{opt l:evel(#)}}set confidence level; default is
{cmd:level(95)}{p_end}
{synopt:{opt or}}report odds ratios{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help scobit##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Maximization}
{synopt:{it:{help scobit##maximize_options:maximize_options}}}control the maximization process{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}
{cmd:bootstrap}, {cmd:by}, {cmd:jackknife}, {cmd:nestreg},
{cmd:rolling}, {cmd:statsby},
{cmd:stepwise}, and {cmd:svy} are allowed; see {help prefix}.{p_end}
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}
{opt vce()} and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}
{opt fweight}s, {opt iweight}s, and {opt pweight}s are allowed; see
{help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp scobit_postestimation R:scobit postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Binary outcomes > Skewed logit regression}


{marker description}{...}
{title:Description}

{pstd}
{opt scobit} fits a maximum-likelihood skewed logit model.

{pstd}
See {help logistic estimation commands} for a list of related estimation
commands.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant}, {opth offset(varname)}, {opt constraint(constraints)},
{opt collinear}; see
{helpb estimation options:[R] estimation options}.

{phang}
{opt asis} forces retention of perfect predictor
variables and their associated perfectly predicted observations and may
produce instabilities in maximization; see {manhelp probit R}.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{dlgtab:Reporting}

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}.

{phang}
{opt or} reports the estimated coefficients transformed to odds ratios, that
is, exp(b) rather than b.  Standard errors and confidence intervals are
similarly transformed.  This option affects how results are displayed, not how
they are estimated.  {opt or} may be specified at estimation or when replaying
previously estimated results.

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
{opt iter:ate(#)},
[{cmdab:no:}]{opt lo:g},
{opt tr:ace},
{opt grad:ient},
{opt showstep},
{opt hess:ian},
{opt showtol:erance},
{opt tol:erance(#)},
{opt ltol:erance(#)},
{opt nrtol:erance(#)},
{opt nonrtol:erance(#)}, and
{opt from(init_specs)};
see {manhelp maximize R}.

{pmore}
Setting the optimization type to {cmd:technique(bhhh)} resets the default
{it:vcetype} to {cmd:vce(opg)}.

{pstd}
The following option is available with {opt scobit} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Fit skewed logistic regression model{p_end}
{phang2}{cmd:. scobit foreign mpg}{p_end}

{pstd}Same as above, but specify robust standard errors{p_end}
{phang2}{cmd:. scobit foreign mpg, vce(robust)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:scobit} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_c)}}log likelihood, comparison model{p_end}
{synopt:{cmd:e(N_f)}}number of failures (zero outcomes){p_end}
{synopt:{cmd:e(N_s)}}number of successes (nonzero outcomes){p_end}
{synopt:{cmd:e(alpha)}}alpha{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(chi2_c)}}chi-squared for comparison test{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:scobit}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test{p_end}
{synopt:{cmd:e(chi2_ct)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test corresponding to {cmd:e(chi2_c)}{p_end}
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
{synopt:{cmd:e(footnote)}}program used to implement the footnote display{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(Cns)}}constraints matrix{p_end}
{synopt:{cmd:e(ilog)}}iteration log (up to 20 iterations){p_end}
{synopt:{cmd:e(gradient)}}gradient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

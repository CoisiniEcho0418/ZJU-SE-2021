{smcl}
{* *! version 1.2.27  28apr2011}{...}
{viewerdialog xtnbreg "dialog xtnbreg"}{...}
{vieweralsosee "[XT] xtnbreg" "mansection XT xtnbreg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtnbreg postestimation" "help xtnbreg postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] nbreg" "help nbreg"}{...}
{vieweralsosee "[XT] xtgee" "help xtgee"}{...}
{vieweralsosee "[XT] xtpoisson" "help xtpoisson"}{...}
{viewerjumpto "Syntax" "xtnbreg##syntax"}{...}
{viewerjumpto "Description" "xtnbreg##description"}{...}
{viewerjumpto "Options for RE/FE models" "xtnbreg##options_re"}{...}
{viewerjumpto "Options for PA models" "xtnbreg##options_pa"}{...}
{viewerjumpto "Examples" "xtnbreg##examples"}{...}
{viewerjumpto "Saved results" "xtnbreg##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink XT xtnbreg} {hline 2}}Fixed-effects, random-effects, & population-averaged negative binomial models{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Random-effects (RE) and conditional fixed-effects (FE) overdispersion models

{p 8 16 2}
{cmd:xtnbreg} {depvar} [{indepvars}] {ifin} {weight} [{cmd:,}
[{opt re}|{opt fe}] {it:{help xtnbreg##reandfeopts:RE/FE_options}}]


{phang}
Population-averaged (PA) model

{p 8 16 2}
{cmd:xtnbreg} {depvar} [{indepvars}] {ifin} {weight} {cmd:,}
{opt pa} [{it:{help xtnbreg##paopts:PA_options}}]


{marker reandfeopts}{...}
{synoptset 27 tabbed}{...}
{synopthdr:RE/FE_options}
{synoptline}
{syntab :Model}
{synopt :{opt nocon:stant}}suppress constant term; not available with {opt fe}{p_end}
{synopt :{opt re}}use random-effects estimator; the default{p_end}
{synopt :{opt fe}}use fixed-effects estimator{p_end}
{synopt :{opth exp:osure(varname)}}include ln({it:varname}) in model with coefficient constrained to 1{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient constrained to 1{p_end}
{synopt :{opth const:raints(estimation options##constraints():constraints)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab :SE}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim}, {opt boot:strap},
         or {opt jack:knife}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt ir:r}}report incidence-rate ratios{p_end}
{synopt :{opt noskip}}perform likelihood-ratio test{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help xtnbreg##re_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab :Maximization}
{synopt :{it:{help xtnbreg##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}

{marker paopts}{...}
{synoptset 27 tabbed}{...}
{synopthdr:PA_options}
{synoptline}
{syntab :Model}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{synopt :{opt pa}}use population-averaged estimator{p_end}
{synopt :{opth exp:osure(varname)}}include ln({it:varname}) in model with coefficient constrained to 1{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient constrained to 1{p_end}

{syntab :Correlation}
{synopt :{cmdab:c:orr(}{it:{help xtnbreg##correlation:correlation}}{cmd:)}}within-group correlation structure{p_end}
{synopt :{opt force}}estimate even if observations unequally spaced in time{p_end}

{syntab :SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt conventional},
        {opt r:obust}, {opt boot:strap}, or {opt jack:knife}{p_end}
{synopt :{opt nmp}}use divisor N-P instead of the default N{p_end}
{synopt :{opt s:cale(parm)}}override the default scale parameter; {it:parm}
                  may be {cmd:x2}, {cmd:dev}, {cmd:phi}, or {it:#}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt irr}}report incidence-rate ratios{p_end}
{synopt :{it:{help xtnbreg##pa_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab :Optimization}
{synopt :{it:{help xtnbreg##optimize_options:optimize_options}}}control the optimization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}

{synoptset 23}{...}
{marker correlation}{...}
{synopthdr :correlation}
{synoptline}
{synopt :{opt exc:hangeable}}exchangeable{p_end}
{synopt :{opt ind:ependent}}independent{p_end}
{synopt :{opt uns:tructured}}unstructured{p_end}
{synopt :{opt fix:ed} {it:matname}}user-specified{p_end}
{synopt :{opt ar} {it:#}}autoregressive of order {it:#}{p_end}
{synopt :{opt sta:tionary} {it:#}}stationary of order {it:#}{p_end}
{synopt :{opt non:stationary} {it:#}}nonstationary of order {it:#}{p_end}
{synoptline}
{p2colreset}{...}

{p 4 6 2}
A panel variable must be specified. For {cmd:xtnbreg, pa}, correlation
structures other than {cmd:exchangeable} and {cmd:independent} require that a
time variable also be specified.  Use {helpb xtset}. {p_end}
INCLUDE help fvvarlist
{p 4 6 2}
{it:depvar} and {it:indepvars} may contain time-series operators;
see {help tsvarlist}.{p_end}
{p 4 6 2}
{opt by}, {opt mi estimate}, and {opt statsby} are allowed; see {help prefix}.{p_end}
INCLUDE help vce_mi
{p 4 6 2}
{opt iweight}s, {opt fweight}s, and {opt pweight}s are allowed for the
population-averaged model, and {opt iweight}s are allowed in the
random-effects and fixed-effects models; see {help weight}.  Weights must be
constant within panel.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp xtnbreg_postestimation XT:xtnbreg postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Longitudinal/panel data > Count outcomes >}
    {bf:Negative binomial regression (FE, RE, PA)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:xtnbreg} fits random-effects overdispersion models, conditional
fixed-effects overdispersion models, and population-averaged negative binomial
models.  Here "random effects" and "fixed effects" apply to the distribution
of the dispersion parameter, not to the xb term in the model.  In the
random-effects and fixed-effects overdispersion models, the dispersion is the
same for all elements in the same group (that is, elements with the same value
of the panel variable).  In the random-effects model, the dispersion varies
randomly from group to group, such that the inverse of one plus the dispersion
follows a b[r,s] distribution.  In the fixed-effects model, the dispersion
parameter in a group can take on any value, because a conditional likelihood is
used in which the dispersion parameter drops out of the estimation.

{pstd}
By default, the population-averaged model is an equal-correlation model;
{cmd:xtnbreg, pa} assumes {cmd:corr(exchangeable)}.  See {manhelp xtgee XT} for
information on how to fit other population-averaged models.


{marker options_re}{...}
{title:Options for RE/FE models}

{dlgtab:Model}

{phang}
{opt noconstant}; see
    {helpb estimation options##noconstant:[R] estimation options}.

{phang}
{opt re} requests the random-effects estimator, which is the default.

{phang}
{opt fe} requests the conditional fixed-effects estimator.

{phang}
{opth exposure(varname)}, {opt offset(varname)},
{opt constraints(constraints)}, {opt collinear};
see {helpb estimation options:[R] estimation options}.

{dlgtab:SE}

INCLUDE help xt_vce_asymptbj

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt irr} reports exponentiated coefficients e^b rather than b.  For the
negative binomial model, exponentiated coefficients have the interpretation of
incidence-rate ratios.

{phang}
{opt noskip}; see
{helpb estimation options##noskip:[R] estimation options}.

{phang}
{opt nocnsreport}; see
     {helpb estimation options##nocnsreport:[R] estimation options}.

{marker re_display_options}{...}
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

{dlgtab:Maximization}

{phang}
{marker maximize_options}
{it:maximize_options}: {opt dif:ficult},
{opth tech:nique(maximize##algorithm_spec:algorithm_spec)},
{opt iter:ate(#)}, [{opt no:}]{opt lo:g}, {opt tr:ace}, {opt grad:ient},
{opt showstep}, {opt hess:ian}, {opt showtol:erance}, {opt tol:erance(#)},
{opt ltol:erance(#)}, {opt nrtol:erance(#)},
{opt nonrtol:erance}, and {opt from(init_specs)}; see {manhelp maximize R}.
These options are seldom used.

{pstd}
The following option is available with {opt xtnbreg} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker options_pa}{...}
{title:Options for PA model}

{dlgtab:Model}

{phang}
{opt noconstant}; see
   {helpb estimation options##noconstant:[R] estimation options}.

{phang}
{opt pa} requests the population-averaged estimator.

{phang}
{opth exposure(varname)}, {opt offset(varname)}; see
        {helpb estimation options##exposure():[R] estimation options}.

{dlgtab:Correlation}

{phang}
{opt corr(correlation)}, {opt force}; see
 {helpb estimation options##corr():[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help xt_vce_asymptrbj

{pmore}
{cmd:vce(conventional)}, the default, uses the conventionally derived variance
estimator for generalized least squares regression.

{phang}
{opt nmp}, {cmd:scale(x2}|{cmd:dev}|{cmd:phi}|{it:#}{cmd:)}; see
{helpb xt_vce_options:[XT] {it:vce_options}}.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt irr} reports exponentiated coefficients e^b rather than b.  For the
negative binomial model, exponentiated coefficients have the interpretation of
incidence-rate ratios.

{marker pa_display_options}{...}
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

{dlgtab:Optimization}

{phang}
{marker optimize_options}
{it:optimize_options} control the iterative optimization process.  These options
are seldom used.

{pmore}
{opt iter:ate(#)} specifies the maximum number of iterations.  When the number
of iterations equals #, the optimization stops and presents the current results,
even if the convergence tolerance has not been reached.  The default value of
{opt iterate()} is 100.

{pmore}
{opt tol:erance(#)} specifies the tolerance for the coefficient vector.  When
the relative change in the coefficient vector from one iteration to the next is
less than or equal to #, the optimization process is stopped.
{cmd:tolerance(1e-6)} is the default.

{pmore}
{opt nolog} suppress the display of the iteration log.

{pmore}
{opt tr:ace} specifies that the current estimates should be printed at each
iteration.

{pstd}
The following option is available with {opt xtnbreg} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse airacc}

{pstd}Random-effects model{p_end}
{phang2}{cmd:. xtnbreg i_cnt inprog, exposure(pmiles) irr}

{pstd}Fixed-effects model{p_end}
{phang2}{cmd:. xtnbreg i_cnt inprog, exposure(pmiles) irr fe}

{pstd}Equal-correlation population-averaged model with robust variance{p_end}
{phang2}{cmd:. xtnbreg i_cnt inprog, exposure(pmiles) eform pa}
               {cmd:vce(robust)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:xtnbreg, re} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}
{synopt:{cmd:e(ll_c)}}log likelihood, comparison model{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(chi2_c)}}chi-squared for comparison test{p_end}
{synopt:{cmd:e(g_min)}}smallest group size{p_end}
{synopt:{cmd:e(g_avg)}}average group size{p_end}
{synopt:{cmd:e(g_max)}}largest group size{p_end}
{synopt:{cmd:e(r)}}value of r in Beta(r,s){p_end}
{synopt:{cmd:e(s)}}value of s in Beta(r,s){p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(rank0)}}rank of {cmd:e(V)} for constant-only model{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtnbreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(model)}}{cmd:re}{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test{p_end}
{synopt:{cmd:e(chi2_ct)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test corresponding to {cmd:e(chi2_c}{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(method)}}estimation method{p_end}
{synopt:{cmd:e(distrib)}}{cmd:Beta}; the distribution of the random
	effect{p_end}
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
{synopt:{cmd:e(ilog)}}iteration log{p_end}
{synopt:{cmd:e(gradient)}}gradient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}


{pstd}
{cmd:xtnbreg, fe} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(r2_p)}}pseudo R-squared{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(g_min)}}smallest group size{p_end}
{synopt:{cmd:e(g_avg)}}average group size{p_end}
{synopt:{cmd:e(g_max)}}largest group size{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtnbreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(model)}}{cmd:fe}{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:LR}; type of model chi-squared test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(method)}}requested estimation method{p_end}
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
{synopt:{cmd:e(ilog)}}iteration log{p_end}
{synopt:{cmd:e(gradient)}}gradient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}

{pstd}
{cmd:xtnbreg, pa} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(df_pear)}}degrees of freedom for Pearson chi-squared{p_end}
{synopt:{cmd:e(chi2_dev)}}chi-squared test of deviance{p_end}
{synopt:{cmd:e(chi2_dis)}}chi-squared test of deviance dispersion{p_end}
{synopt:{cmd:e(deviance)}}deviance{p_end}
{synopt:{cmd:e(dispers)}}deviance dispersion{p_end}
{synopt:{cmd:e(phi)}}scale parameter{p_end}
{synopt:{cmd:e(g_min)}}smallest group size{p_end}
{synopt:{cmd:e(g_avg)}}average group size{p_end}
{synopt:{cmd:e(g_max)}}largest group size{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(tol)}}target tolerance{p_end}
{synopt:{cmd:e(dif)}}achieved tolerance{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtgee}{p_end}
{synopt:{cmd:e(cmd2)}}{cmd:xtnbreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(tvar)}}variable denoting time within groups{p_end}
{synopt:{cmd:e(model)}}{cmd:pa}{p_end}
{synopt:{cmd:e(family)}}{cmd:negative binomial} (k=1){p_end}
{synopt:{cmd:e(link)}}{cmd:log}; link function{p_end}
{synopt:{cmd:e(corr)}}correlation structure{p_end}
{synopt:{cmd:e(scale)}}{cmd:x2}, {cmd:dev}, {cmd:phi}, or {it:#};
                  scale parameter{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald}; type of model chi-squared test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(nmp)}}{cmd:nmp}, if specified{p_end}
{synopt:{cmd:e(nbalpha)}}alpha{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(R)}}estimated working correlation matrix{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

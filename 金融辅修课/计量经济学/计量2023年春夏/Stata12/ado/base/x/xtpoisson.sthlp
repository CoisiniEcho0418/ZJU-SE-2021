{smcl}
{* *! version 1.2.31  04may2011}{...}
{viewerdialog xtpoisson "dialog xtpoisson"}{...}
{vieweralsosee "[XT] xtpoisson" "mansection XT xtpoisson"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtpoisson postestimation" "help xtpoisson postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] poisson" "help poisson"}{...}
{vieweralsosee "[XT] quadchk" "help quadchk"}{...}
{vieweralsosee "[XT] xtgee" "help xtgee"}{...}
{vieweralsosee "[XT] xtnbreg" "help xtnbreg"}{...}
{viewerjumpto "Syntax" "xtpoisson##syntax"}{...}
{viewerjumpto "Description" "xtpoisson##description"}{...}
{viewerjumpto "Options for RE model" "xtpoisson##options_re"}{...}
{viewerjumpto "Options for FE model" "xtpoisson##options_fe"}{...}
{viewerjumpto "Options for PA model" "xtpoisson##options_pa"}{...}
{viewerjumpto "Technical note" "xtpoisson##technote"}{...}
{viewerjumpto "Examples" "xtpoisson##examples"}{...}
{viewerjumpto "Saved results" "xtpoisson##saved_results"}{...}
{title:Title}

{p2colset 5 23 25 2}{...}
{p2col :{manlink XT xtpoisson} {hline 2}}Fixed-effects, random-effects, and population-averaged Poisson models{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Random-effects (RE) model

{p 8 18 2}
{cmd:xtpoisson} {depvar} [{indepvars}] {ifin} {weight}
[{cmd:, re} {it:{help xtpoisson##reoptions:RE_options}}]


{phang}
Conditional fixed-effects (FE) model

{p 8 18 2}
{cmd:xtpoisson} {depvar} [{indepvars}] {ifin} {weight}
{cmd:, fe} [{it:{help xtpoisson##feoptions:FE_options}}]


{phang}
Population-averaged (PA) model

{p 8 18 2}
{cmd:xtpoisson} {depvar} [{indepvars}] {ifin} {weight}
{cmd:, pa} [{it:{help xtpoisson##paoptions:PA_options}}]


{marker reoptions}{...}
{synoptset 27 tabbed}{...}
{synopthdr:RE_options}
{synoptline}
{syntab :Model}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{synopt :{opt re}}use random-effects estimator; the default{p_end}
{synopt :{opth e:xposure(varname)}}include ln({it:varname}) in model with coefficient constrained to 1{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient constrained to 1{p_end}
{synopt :{opt normal}}use a normal distribution for random effects instead of gamma{p_end}
{synopt :{opth const:raints(estimation options##constraints():constraints)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab :SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
      {opt boot:strap}, or {opt jack:knife}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt irr}}report incidence-rate ratios{p_end}
{synopt :{opt noskip}}fit constant-only model and perform likelihood-ratio
                   test{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help xtpoisson##re_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

INCLUDE help intpts1

{syntab :Maximization}
{synopt :{it:{help xtpoisson##maximize_optionsRE:maximize_options}}}control the maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}

{marker feoptions}{...}
{synoptset 27 tabbed}{...}
{synopthdr:FE_options}
{synoptline}
{syntab :Model}
{synopt :{opt fe}}use fixed-effects estimator{p_end}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{synopt :{opth e:xposure(varname)}}include ln({it:varname}) in model with coefficient constrained to 1{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient constrained to 1{p_end}
{synopt :{opth const:raints(estimation options##constraints():constraints)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab :SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim}, {opt r:obust},
                    {opt boot:strap}, or {opt jack:knife}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt irr}}report incidence-rate ratios{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help xtpoisson##fe_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab :Maximization}
{synopt :{it:{help xtpoisson##maximize_optionsFE:maximize_options}}}control the maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}

{marker paoptions}{...}
{synoptset 27 tabbed}{...}
{synopthdr:PA_options}
{synoptline}
{syntab :Model}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{synopt :{opt pa}}use population-averaged estimator{p_end}
{synopt :{opth e:xposure(varname)}}include ln({it:varname}) in model with coefficient constrained to 1{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient
constrained to 1{p_end}

{syntab :Correlation}
{synopt :{cmdab:c:orr(}{it:{help xtpoisson##correlation:correlation}}{cmd:)}}within-group correlation structure{p_end}
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
{synopt :{it:{help xtpoisson##pa_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab :Optimization}
{synopt :{it:{help xtpoisson##optimize_options:optimize_options}}}control the optimization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}

{marker correlation}{...}
{synoptset 23}{...}
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
A panel variable must be specified. For {cmd:xtpoisson, pa}, correlation
structures other than {cmd:exchangeable} and {cmd:independent} require that a
time variable also be specified.  Use {helpb xtset}. {p_end}
INCLUDE help fvvarlist
{p 4 6 2}
{it:depvar} and {it:indepvars} may contain time-series operators; see {help tsvarlist}.{p_end}
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
See {manhelp xtpoisson_postestimation XT:xtpoisson postestimation} for
features available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Longitudinal/panel data > Count outcomes >}
      {bf:Poisson regression (FE, RE, PA)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:xtpoisson} fits random-effects, conditional fixed-effects,
and population-averaged Poisson models.  Whenever we refer to a fixed-effects
model, we mean the conditional fixed-effects model.

{pstd}
By default, the population-averaged model is an equal-correlation model;
{cmd:xtpoisson, pa} assumes {cmd:corr(exchangeable)}.  See {manhelp xtgee XT}
for information on how to fit other population-averaged models.


{marker options_re}{...}
{title:Options for RE model}

{dlgtab:Model}

{phang}
{opt noconstant}; see
{helpb estimation options##noconstant:[R] estimation options}.

{phang}
{opt re}, the default, requests the random-effects estimator.

{phang}
{opth exposure(varname)}, {opt offset(varname)}; see
{helpb estimation options##exposure():[R] estimation options}.

{phang}
{opt normal} specifies that the random effects follow a normal distribution
instead of a gamma distribution.

{phang}
{opt constraints(constraints)}, {opt collinear}; see
     {helpb estimation options##constraints():[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help xt_vce_asymptbj

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
     {helpb estimation options##level():[R] estimation options}.

{phang}
{opt irr} reports exponentiated coefficients e^b rather than coefficients b.
For the Poisson model, exponentiated coefficients are interpreted as
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

INCLUDE help intpts4

{dlgtab:Maximization}

{phang}
{marker maximize_optionsRE}
{it:maximize_options}: {opt dif:ficult},
{opth tech:nique(maximize##algorithm_spec:algorithm_spec)},
{opt iter:ate(#)}, [{opt no:}]{opt lo:g}, {opt tr:ace}, {opt grad:ient},
{opt showstep}, {opt hess:ian}, {opt showtol:erance}, {opt tol:erance(#)},
{opt ltol:erance(#)}, {opt nrtol:erance(#)},
{opt nonrtol:erance}, and {opt from(init_specs)}; see {manhelp maximize R}.
These options are seldom used.

{pstd}
The following option is available with {opt xtpoisson} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker options_fe}{...}
{title:Options for FE model}

{dlgtab:Model}

{phang}
{opt fe} requests the fixed-effects estimator.

{phang}
{opth exposure(varname)}, {opt offset(varname)},
{opt constraints(constraints)},
{opt collinear};
see {helpb estimation options:[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help xt_vce_asymptrbj

{pmore}
{bf:vce(robust)} invokes a cluster-robust estimate of the VCE in which the ID
variable specifies the clusters.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt irr} reports exponentiated coefficients e^b rather than coefficients b.
For the Poisson model, exponentiated coefficients are interpreted as
incidence-rate ratios.

{phang}
{opt nocnsreport}; see
     {helpb estimation options##nocnsreport:[R] estimation options}.

{marker fe_display_options}{...}
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
{marker maximize_optionsFE}
{it:maximize_options}: {opt dif:ficult},
{opth tech:nique(maximize##algorithm_spec:algorithm_spec)},
{opt iter:ate(#)}, [{opt no:}]{opt lo:g}, {opt tr:ace}, {opt grad:ient},
{opt showstep}, {opt hess:ian}, {opt showtol:erance}, {opt tol:erance(#)},
{opt ltol:erance(#)}, {opt nrtol:erance(#)},
{opt nonrtol:erance}, and {opt from(init_specs)}; see {manhelp maximize R}.
These options are seldom used.

{pstd}
The following option is available with {opt xtpoisson} but is not shown in the
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
{opt irr} reports exponentiated coefficients e^b rather than coefficients b.
For the Poisson model, exponentiated coefficients are interpreted as
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
The following option is available with {opt xtpoisson} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker technote}{...}
{title:Technical note}

{pstd}
The random-effects model is calculated using quadrature, which is an
approximation whose accuracy depends partially on the number of integration
points used.  We can use the {cmd:quadchk} command to see if changing the
number of integration points affects the results.  If the results change, the
quadrature approximation is not accurate given the number of integration
points.  Try increasing the number of integration points using the
{cmd:intpoints()} option and again run {cmd:quadchk}.  Do not attempt to
interpret the results of estimates when the coefficients reported by
{cmd:quadchk} differ substantially.  See {manhelp quadchk XT} for details and
{bf:[XT] xtprobit} for an 
{mansection XT xtprobitRemarkstechnote:example}.

{pstd}
Because the {cmd:xtpoisson, re normal} likelihood function is calculated by
Gauss-Hermite quadrature, on large problems, the computations can be slow.
Computation time is roughly proportional to the number of points used for the
quadrature.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse ships}{p_end}
{phang2}{cmd:. xtset ship}{p_end}

{pstd}Random-effects model{p_end}
{phang2}{cmd:. xtpoisson accident op_75_79 co_65_69 co_70_74 co_75_79,}
                {cmd:exposure(service) irr}

{pstd}Fixed-effects model{p_end}
{phang2}{cmd:. xtpoisson accident op_75_79 co_65_69 co_70_74 co_75_79,}
                {cmd:exposure(service) irr fe}

{pstd}Random-effects model with random effects following normal
distribution{p_end}
{phang2}{cmd:. xtpoisson accident op_75_79 co_65_69 co_70_74 co_75_79,}
              {cmd:exposure(service) irr normal}

{pstd}Equal-correlation population-averaged model with robust variance{p_end}
{phang2}{cmd:. xtpoisson accident op_75_79 co_65_69 co_70_74 co_75_79,}
              {cmd:exposure(service) pa vce(robust) irr}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:xtpoisson, re} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(N_cd)}}number of completely determined observations{p_end}
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
{synopt:{cmd:e(sigma_u)}}panel-level standard deviation{p_end}
{synopt:{cmd:e(alpha)}}the value of alpha{p_end}
{synopt:{cmd:e(g_min)}}smallest group size{p_end}
{synopt:{cmd:e(g_avg)}}average group size{p_end}
{synopt:{cmd:e(g_max)}}largest group size{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(rank0)}}rank of {cmd:e(V)} for constant-only model{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtpoisson}{p_end}
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
{synopt:{cmd:e(method)}}requested estimation method{p_end}
{synopt:{cmd:e(distrib)}}{cmd:Gamma}; the distribution of the random
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
{cmd:xtpoisson, re normal} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(N_cd)}}number of completely determined observations{p_end}
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
{synopt:{cmd:e(sigma_u)}}panel-level standard deviation{p_end}
{synopt:{cmd:e(n_quad)}}number of quadrature points{p_end}
{synopt:{cmd:e(g_min)}}smallest group size{p_end}
{synopt:{cmd:e(g_avg)}}average group size{p_end}
{synopt:{cmd:e(g_max)}}largest group size{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(rank0)}}rank of {cmd:e(V)} for constant-only model{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtpoisson}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(model)}}{cmd:re}{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
{synopt:{cmd:e(offset1)}}ln({it:varname}), where {it:varname} is
       variable from {cmd:exposure()}{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test{p_end}
{synopt:{cmd:e(chi2_ct)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test corresponding to {cmd:e(chi2_c}{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(intmethod)}}integration method{p_end}
{synopt:{cmd:e(distrib)}}{cmd:Gaussian}; the distribution of the random
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
{cmd:xtpoisson, fe} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}
{synopt:{cmd:e(ll_c)}}log likelihood, comparison model{p_end}
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
{synopt:{cmd:e(cmd)}}{cmd:xtpoisson}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(model)}}{cmd:fe}{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
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
{cmd:xtpoisson, pa} saves the following in {cmd:e()}:

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
{synopt:{cmd:e(cmd2)}}{cmd:xtpoisson}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(tvar)}}variable denoting time within groups{p_end}
{synopt:{cmd:e(model)}}{cmd:pa}{p_end}
{synopt:{cmd:e(family)}}{cmd:Poisson}{p_end}
{synopt:{cmd:e(link)}}{cmd:log}; link function{p_end}
{synopt:{cmd:e(corr)}}correlation structure{p_end}
{synopt:{cmd:e(scale)}}{cmd:x2}, {cmd:dev}, {cmd:phi}, or {it:#}; scale
           parameter{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald}; type of model chi-squared test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}covariance estimation method{p_end}
{synopt:{cmd:e(nmp)}}{cmd:nmp}, if specified{p_end}
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

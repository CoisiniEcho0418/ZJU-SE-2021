{smcl}
{* *! version 1.1.19  18may2011}{...}
{viewerdialog "treatreg ml" "dialog treatreg_ml"}{...}
{viewerdialog "treatreg two-step"  "dialog treatreg_2step"}{...}
{viewerdialog "svy: treatreg ml" "dialog treatreg_ml, message(-svy-) name(svy_treatreg_ml)"}{...}
{vieweralsosee "[R] treatreg" "mansection R treatreg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] treatreg postestimation" "help treatreg postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] heckman" "help heckman"}{...}
{vieweralsosee "[R] probit" "help probit"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy estimation"}{...}
{viewerjumpto "Syntax" "treatreg##syntax"}{...}
{viewerjumpto "Description" "treatreg##description"}{...}
{viewerjumpto "Options for maximum likelihood estimates" "treatreg##options_ml"}{...}
{viewerjumpto "Options for two-step consistent estimates" "treatreg##options_twostep"}{...}
{viewerjumpto "Examples" "treatreg##examples"}{...}
{viewerjumpto "Saved results" "treatreg##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink R treatreg} {hline 2}}Treatment-effects model{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Basic syntax

{p 8 17 2}
{cmd:treatreg}
{depvar}
[{indepvars}]{cmd:,}
{cmdab:tr:eat:(}{depvar:_t} {cmd:=} {indepvars:_t}{cmd:)}
[{opt two:step}]


{phang}
Full syntax for maximum likelihood estimates only

{p 8 17 2}
{cmd:treatreg}
{depvar}
[{indepvars}]
{ifin}
{weight}{cmd:,}
{cmdab:tr:eat:(}{depvar:_t} {cmd:=} {indepvars:_t} [{cmd:,}
{opt noc:onstant}]{cmd:)}
[{it:{help treatreg##treatreg_ml_options:treatreg_ml_options}}]


{phang}
Full syntax for two-step consistent estimates only

{p 8 17 2}
{cmd:treatreg}
{depvar}
[{indepvars}]
{ifin}{cmd:,}
{cmdab:tr:eat:(}{depvar:_t} {cmd:=} {indepvars:_t} [{cmd:,}
{opt noc:onstant}]{cmd:)}
{opt two:step}
[{it:{help treatreg##treatreg_ts_options:treatreg_ts_options}}]


{marker treatreg_ml_options}{...}
{synoptset 26 tabbed}{...}
{synopthdr:treatreg_ml_options}
{synoptline}
{syntab:Model}
{p2coldent :* {opt tr:eat()}}equation for treatment effects{p_end}
{synopt:{opt noc:onstant}}suppress constant term{p_end}
{synopt:{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
    {opt r:obust}, {opt cl:uster} {it:clustvar}, {opt opg}, {opt boot:strap},
    or {opt jack:knife}{p_end}

{syntab:Reporting}
{synopt:{opt l:evel(#)}}set confidence level; default is
	{cmd:level(95)}{p_end}
{synopt :{opt fir:st}}report first-step probit estimates{p_end}
{synopt :{opt noskip}}perform likelihood-ratio test{p_end}
{synopt :{opth ha:zard(newvar)}}create {it:newvar} containing hazard from
	treatment equation{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help treatreg##ml_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Maximization}
{synopt:{it:{help treatreg##maximize_options:maximize_options}}}control
	maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p 4 6 2}
* {opt treat}{cmd:(}{it:depvar_t} {cmd:=} {it:indepvars_t}[{cmd:,}
{opt noc:onstant}]{cmd:)} is required.{p_end}


{marker treatreg_ts_options}{...}
{synopthdr:treatreg_ts_options}
{synoptline}
{syntab:Model}
{p2coldent :* {opt tr:eat()}}equation for treatment effects{p_end}
{p2coldent :* {opt two:step}}produce two-step consistent estimate{p_end}
{synopt:{opt noc:onstant}}suppress constant term{p_end}

{syntab:SE}
{synopt:{opth vce(vcetype)}}{it:vcetype} may be {opt conventional},
	{opt boot:strap}, or {opt jack:knife}{p_end}

{syntab:Reporting}
{synopt:{opt l:evel(#)}}set confidence level; default is
	{cmd:level(95)}{p_end}
{synopt:{opt fir:st}}report first-step probit estimates{p_end}
{synopt:{opth ha:zard(newvar)}}create {it:newvar} containing hazard from
	treatment equation{p_end}
{synopt :{it:{help treatreg##ts_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt treat}{cmd:(}{it:depvar_t} {cmd:=} {it:indepvars_t}[{cmd:,}
{opt noc:onstant}]{cmd:)} and {opt twostep} are required.{p_end}

{p 4 6 2}{it:indepvars} and {it:indepvars_t} may contain factor variables; see
{help fvvarlist}.{p_end}
{p 4 6 2}
{it:depvar}, {it:indepvars}, {it:depvar_t}, and {it:indepvars_t} may contain
time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}
{opt bootstrap}, {opt by}, {opt jackknife}, {opt rolling}, {opt statsby},
and {cmd:svy} are allowed; see {help prefix}.{p_end}
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{cmd:aweight}s are not allowed with the {helpb jackknife} prefix.
{p_end}
{p 4 6 2}
{opt twostep},
{opt vce()},
{opt first},
{opt noskip},
{opt hazard()},
and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}
{opt pweight}s, {opt aweight}s, {opt fweight}s, and {opt iweight}s are
allowed with maximum likelihood estimation; see {help weight}.  No weights are
allowed if {opt twostep} is specified.
	{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp treatreg_postestimation R:treatreg postestimation} for features
available after estimation.  {p_end}


{title:Menu}

    {title:treatreg for maximum likelihood estimates}

{phang2}
{bf:Statistics > Sample-selection models > Treatment-effects model (ML)}

    {title:treatreg for two-step consistent estimates}

{phang2}
{bf:Statistics > Sample-selection models > Treatment-effects model (two-step)}


{marker description}{...}
{title:Description}

{pstd}
{opt treatreg} fits a treatment-effects model by using either a
two-step consistent estimator or full maximum likelihood.  The
treatment-effects model considers the effect of an endogenously chosen binary
treatment on another endogenous continuous variable, conditional on two sets
of independent variables.


{marker options_ml}{...}
{title:Options for maximum likelihood estimates}

{dlgtab:Model}

{phang}
{cmd:treat(}{depvar:_t} {cmd:=} {indepvars:_t}[{cmd:,} {opt noc:onstant}]{cmd:)}
   specifies the variables and options for the
   treatment equation.  It is an integral part of specifying a treatment-effects
   model and is required.

{phang}
{opt noconstant}, {opt constraints(constraints)}, {opt collinear}; see
     {helpb estimation options:[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{dlgtab:Reporting}

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}.

{phang}
{opt first} specifies that the first-step probit estimates of the treatment
   equation be displayed before estimation.

{phang}
{opt noskip} specifies that a full maximum-likelihood model with only a
   constant for the regression equation be fit.  This model is not
   displayed but is used as the base model to compute a likelihood-ratio test
   for the model test statistic displayed in the estimation header.  By
   default, the overall model test statistic is an asymptotically equivalent
   Wald test that all the parameters in the regression equation are zero
   (except the constant).  For many models, this option can substantially
   increase estimation time.

{phang}
{opth hazard(newvar)} will create a new variable containing the
   hazard from the treatment equation.  The hazard is computed from the
   estimated parameters of the treatment equation.

{phang}
{opt nocnsreport}; see
     {helpb estimation options##nocnsreport:[R] estimation options}.

{marker ml_display_options}{...}
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
see {manhelp maximize R}.  These options are seldom used.

{pmore}
Setting the optimization type to {cmd:technique(bhhh)} resets the default
{it:vcetype} to {cmd:vce(opg)}.

{pstd}
The following option is available with {opt treatreg} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker options_twostep}{...}
{title:Options for two-step consistent estimates}

{dlgtab:Model}

{phang}
{cmd:treat(}{depvar:_t} {cmd:=} {indepvars:_t}[{cmd:,} {opt noc:onstant}]{cmd:)}
   specifies the variables and options for the
   treatment equation.  It is an integral part of specifying a treatment-effects
   model and is required.

{phang}
{opt twostep} specifies that two-step consistent
   estimates of the parameters, standard errors, and covariance matrix of the
   model be produced, instead of the default maximum likelihood estimates.

{phang}
{opt noconstant}; see
{helpb estimation options##noconstant:[R] estimation options}.

{dlgtab:SE}

INCLUDE help vce_asymptbj

{pmore}
{cmd:vce(conventional)}, the default, uses the conventionally derived variance
estimator for the two-step estimator of the treatment-effects model.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}.

{phang}
{opt first} specifies that the first-step probit estimates of the treatment
   equation be displayed before estimation.

{phang}
{opth hazard(newvar)} will create a new variable containing the
   hazard from the treatment equation.  The hazard is computed from the
   estimated parameters of the treatment equation.

{marker ts_display_options}{...}
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
The following option is available with {opt treatreg} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse labor}{p_end}
{phang2}{cmd:. generate wc = 0}{p_end}
{phang2}{cmd:. replace wc = 1 if we > 12}{p_end}

{p 4 4 2}Obtain full ML estimates{p_end}
{p 8 12 2}{cmd:. treatreg ww wa cit, treat(wc=wmed wfed)}

{p 4 4 2}Obtain two-step consistent estimates{p_end}
{p 8 12 2}{cmd:. treatreg ww wa cit, treat(wc=wmed wfed) twostep}

{p 4 4 2}Define and use each equation separately{p_end}
{p 8 12 2}{cmd:. global wage_eqn ww wa cit}{p_end}
{p 8 12 2}{cmd:. global trteqn wc=wmed wfed}{p_end}
{p 8 12 2}{cmd:. treatreg $wage_eqn, treat($trteqn)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:treatreg} (maximum likelihood) saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(lambda)}}lambda{p_end}
{synopt:{cmd:e(selambda)}}standard error of lambda{p_end}
{synopt:{cmd:e(sigma)}}estimate of sigma{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(chi2_c)}}chi-squared for comparison test{p_end}
{synopt:{cmd:e(p_c)}}p-value for comparison test{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rho)}}rho{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:treatreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(hazard)}}variable containing hazard{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test{p_end}
{synopt:{cmd:e(chi2_ct)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test corresponding to {cmd:e(chi2_c)}{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(opt)}}type of optimization{p_end}
{synopt:{cmd:e(which)}}{cmd:max} or {cmd:min}; whether optimizer is to perform
                         maximization or minimization{p_end}
{synopt:{cmd:e(method)}}{cmd:ml}{p_end}
{synopt:{cmd:e(ml_method)}}type of {cmd:ml} method{p_end}
{synopt:{cmd:e(user)}}name of likelihood-evaluator program{p_end}
{synopt:{cmd:e(technique)}}maximization technique{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(footnote)}}program used to implement the footnote display{p_end}
{synopt:{cmd:e(marginsok)}}predictions allowed by {cmd:margins}{p_end}
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


{pstd}
{cmd:treatreg} (two-step) saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(lambda)}}lambda{p_end}
{synopt:{cmd:e(selambda)}}standard error of lambda{p_end}
{synopt:{cmd:e(sigma)}}estimate of sigma{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rho)}}rho{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:treatreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(hazard)}}variable specified in {cmd:hazard()}{p_end}
{synopt:{cmd:e(method)}}{cmd:twostep}{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(footnote)}}program used to implement the footnote display{p_end}
{synopt:{cmd:e(marginsok)}}predictions allowed by {cmd:margins}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

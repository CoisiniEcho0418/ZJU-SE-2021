{smcl}
{* *! version 1.2.20  18may2011}{...}
{viewerdialog zinb "dialog zinb"}{...}
{viewerdialog "svy: zinb" "dialog zinb, message(-svy-) name(svy_zinb)"}{...}
{vieweralsosee "[R] zinb" "mansection R zinb"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] zinb postestimation" "help zinb postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] nbreg" "help nbreg"}{...}
{vieweralsosee "[R] poisson" "help poisson"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy estimation"}{...}
{vieweralsosee "[R] tnbreg" "help tnbreg"}{...}
{vieweralsosee "[R] tpoisson" "help tpoisson"}{...}
{vieweralsosee "[XT] xtnbreg" "help xtnbreg"}{...}
{vieweralsosee "[R] zip" "help zip"}{...}
{viewerjumpto "Syntax" "zinb##syntax"}{...}
{viewerjumpto "Description" "zinb##description"}{...}
{viewerjumpto "Options" "zinb##options"}{...}
{viewerjumpto "Examples" "zinb##examples"}{...}
{viewerjumpto "Saved results" "zinb##saved_results"}{...}
{viewerjumpto "Reference" "zinb##reference"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink R zinb} {hline 2}}Zero-inflated negative binomial 
regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:zinb} {depvar} [{indepvars}] {ifin} {weight}{cmd:,}
{opt inf:late}{cmd:(}{varlist}[{cmd:,} {opth off:set(varname)}]|{cmd:_cons)}
[{it:options}]

{marker zinb_options}{...}
{synoptset 28 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Model}
{p2coldent:* {opt inf:late()}}equation that determines whether the count is
zero{p_end}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{synopt :{opth exp:osure(varname:varname_e)}}include {opt ln(varname_e)} in model with
coefficient constrained to 1{p_end}
{synopt :{opth off:set(varname:varname_o)}}include {it:varname_o} in model with
coefficient constrained to 1{p_end}
{synopt :{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}
{synopt :{opt probit}}use probit model to characterize excess zeros;
default is logit{p_end}

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
   {opt r:obust}, {opt cl:uster} {it:clustvar}, {opt opg}, {opt boot:strap},
   or {opt jack:knife}{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is
{cmd:level(95)}.{p_end}
{synopt :{opt irr}}report incidence-rate ratios{p_end}
{synopt :{opt vuong}}perform Vuong test{p_end}
{synopt :{opt zip}}perform ZIP likelihood-ratio test{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help zinb##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Maximization}
{synopt :{it:{help zinb##maximize_options:maximize_options}}}control the maximization process; seldom
used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt inf:late}{cmd:(}{it:varlist}[{cmd:,} {opt off:set(varname)}]|{cmd:_cons)}
is required.{p_end}
INCLUDE help fvvarlist2
{p 4 6 2}{cmd:bootstrap}, {cmd:by}, {cmd:jackknife}, {cmd:rolling},
{cmd:statsby}, and {cmd:svy} are allowed; see {help prefix}.{p_end}
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}
{opt vce()},
{opt vuong},
{opt zip},
and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}{cmd:fweight}s, {cmd:iweight}s, and {cmd:pweight}s are allowed; see
{help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}See {manhelp zinb_postestimation R:zinb postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Count outcomes > Zero-inflated negative binomial regression}


{marker description}{...}
{title:Description}

{pstd}
{cmd:zinb} estimates a zero-inflated negative binomial (ZINB) regression of
{depvar} on {indepvars}, where {it:depvar} is a nonnegative count variable.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{cmd:inflate(}{varlist}[{cmd:,} {cmd:offset(}{varname}{cmd:)}]|{cmd:_cons)}
specifies the equation that determines whether the observed count is zero.
Conceptually, omitting {opt inflate()} would be equivalent to fitting the
model with {cmd:nbreg}.

{pmore}
{cmd:inflate(}{it:varlist}[{cmd:, offset(}{it:varname}{cmd:)}]{cmd:)}
specifies the variables in the equation.  You may optionally include an offset
for this {it:varlist}.

{pmore}
{cmd:inflate(_cons)} specifies that the equation determining whether
the count is zero contains only an intercept.  To run a zero-inflated model of
{depvar} with only an intercept in both equations, type
{bind:{cmd:zinb} {it:depvar}{cmd:,} {cmd:inflate(_cons)}}.

{phang}
{opt noconstant}, {opth exposure:(varname:varname_e)}, {opt offset(varname_o)}, 
{opt constraints(constraints)}, {opt collinear}; see
{helpb estimation options:[R] estimation options}.

{phang}
{opt probit} specifies that a probit, instead of logit, model be
used to characterize the excess zeros in the data.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{dlgtab:Reporting}

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}. 

{phang}
{opt irr} reports estimated coefficients transformed to incidence-rate
ratios.  Standard errors and confidence intervals are similarly transformed.
This option affects how results are displayed, not how they are estimated or
stored.  {opt irr} may be specified at estimation or when replaying
previously estimated results.

{phang}
{opt vuong} specifies that the
{help zinb##V1989:Vuong (1989)} test of ZINB versus negative
binomial be reported.  This test statistic has a standard normal distribution
with large positive values favoring the ZINB model and large negative values
favoring the negative binomial model.

{phang}
{opt zip} requests that a likelihood-ratio test comparing the ZINB 
model with the zero-inflated Poisson model be included in the output.

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
{it:maximize_options}: {opt dif:ficult},
{opth tech:nique(maximize##algorithm_spec:algorithm_spec)}, 
{opt iter:ate(#)}, [{cmd:{ul:no}}]{cmd:{ul:lo}}{cmd:g}, {opt tr:ace}, 
{opt grad:ient},
{opt showstep},
{opt hess:ian},
{opt showtol:erance},
{opt tol:erance(#)}, 
{opt ltol:erance(#)}, {opt nrtol:erance(#)}, 
{opt nonrtol:erance}, and {opt from(init_specs)}; see {manhelp maximize R}.
These options are seldom used.

{pmore}
Setting the optimization type to {cmd:technique(bhhh)} resets the default
{it:vcetype} to {cmd:vce(opg)}.

{pstd}
The following option is available with {opt zinb} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse fish}{p_end}

{pstd}Fit zero-inflated negative binomial regression model{p_end}
{phang2}{cmd:. zinb count persons livebait, inflate(child camper)}{p_end}

{pstd}Same as above, but report Vuong test of ZINB versus negative binomial
{p_end}
{phang2}{cmd:. zinb count persons livebait, inflate(child camper) vuong}

{pstd}Replay results, displaying coefficients, standard errors, and CIs to
4 decimal places{p_end}
{phang2}{cmd:. zinb, cformat(%8.4f)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:zinb} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_zero)}}number of zero observations{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}
{synopt:{cmd:e(df_c)}}degrees of freedom for comparison test{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(p)}}significance of model test{p_end}
{synopt:{cmd:e(chi2_cp)}}chi-squared for test of alpha = 0{p_end}
{synopt:{cmd:e(vuong)}}Vuong test statistic{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:zinb}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(inflate)}}{cmd:logit} or {cmd:probit}{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(offset1)}}offset{p_end}
{synopt:{cmd:e(offset2)}}offset for {cmd:inflate()}{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
        test{p_end}
{synopt:{cmd:e(chi2_cpt)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test corresponding to {cmd:e(chi2_cp)}{p_end}
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
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker reference}{...}
{title:Reference}

{marker V1989}{...}
{phang}
Vuong, Q. 1989.
Likelihood ratio tests for model selection and non-nested hypotheses.
{it:Econometrica} 57: 307-333.
{p_end}

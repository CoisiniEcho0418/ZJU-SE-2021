{smcl}
{* *! version 1.1.16  18may2011}{...}
{viewerdialog truncreg "dialog truncreg"}{...}
{viewerdialog "svy: truncreg" "dialog truncreg, message(-svy-) name(svy_truncreg)"}{...}
{vieweralsosee "[R] truncreg" "mansection R truncreg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] truncreg postestimation" "help truncreg postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy estimation"}{...}
{vieweralsosee "[R] tobit" "help tobit"}{...}
{viewerjumpto "Syntax" "truncreg##syntax"}{...}
{viewerjumpto "Description" "truncreg##description"}{...}
{viewerjumpto "Options" "truncreg##options"}{...}
{viewerjumpto "Examples" "truncreg##examples"}{...}
{viewerjumpto "Saved results" "truncreg##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink R truncreg} {hline 2}}Truncated regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:truncreg}
{depvar}
[{indepvars}]
{ifin}
{weight}
[{cmd:,} {it:options}]

{synoptset 28 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{synopt:{opt nocon:stant}}suppress constant term
{p_end}
{synopt:{cmd:ll(}{varname}|{it:#}{cmd:)}}lower limit for left-truncation
{p_end}
{synopt:{cmd:ul(}{varname}|{it:#}{cmd:)}}upper limit for right-truncation
{p_end}
{synopt:{opth off:set(varname)}}include {it:varname} in model with
coefficient constrained to 1
{p_end}
{synopt:{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints
{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
   {opt r:obust}, {opt cl:uster} {it:clustvar}, {opt opg}, {opt boot:strap},
   or {opt jack:knife}{p_end}

{syntab:Reporting}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}
{p_end}
{synopt :{opt noskip}}perform likelihood-ratio test
{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help truncreg##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Maximization}
{synopt:{it:{help truncreg##maximize_options:maximize_options}}}control
maximization process; seldom used
{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}
{it:depvar} and {it:indepvars} may contain time-series operators; see
	{help tsvarlist}.
	{p_end}
{p 4 6 2}
{opt bootstrap}, {opt by}, {opt jackknife}, {opt mi estimate}, {opt rolling},
{opt statsby}, and {opt svy} are allowed; see {help prefix}.{p_end}
INCLUDE help vce_mi
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{cmd:aweight}s are not allowed with the {helpb jackknife} prefix.
{p_end}
{p 4 6 2}
{opt vce()},
{opt noskip},
and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}
{opt aweight}s, {opt fweight}s, {opt iweight}s, and {opt pweight}s are allowed;
see {help weight}.
	{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp truncreg_postestimation R:truncreg postestimation} for features
available after estimation.  {p_end}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Truncated regression}


{marker description}{...}
{title:Description}

{pstd}
{opt truncreg} fits a regression model of {depvar} on {indepvars} from a sample
drawn from a restricted part of the population.  Under the normality
assumption for the whole population, the error terms in the truncated
regression model have a truncated normal distribution, which is a normal
distribution that has been scaled upward so that the distribution integrates
to one over the restricted range.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant}; see
{helpb estimation options##noconstant:[R] estimation options}.

{phang}
{cmd:ll(}{varname}|{it:#}{cmd:)} and
{opt ul(varname|#)} indicate the upper and lower limits for truncation,
respectively.  You may specify one or both.
Observations with {depvar} {ul:<} {opt ll()} are left-truncated,
observations with {it:depvar} {ul:>} {opt ul()} are right-truncated,
and the remaining observations are not truncated.
See {manhelp tobit R} for a more detailed description.

{phang}
{opth offset(varname)}, {opt constraints(constraints)}, {opt collinear};
see {helpb estimation options:[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt noskip} specifies that a full maximum-likelihood model with only a
   constant for the regression equation be fit.  This model is not
   displayed but is used as the base model to compute a likelihood-ratio test
   for the model test statistic displayed in the estimation header.  By
   default, the overall model test statistic is an asymptotically equivalent
   Wald test of all the parameters in the regression equation being zero
   (except the constant).  For many models, this option can substantially
   increase estimation time.

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
see {manhelp maximize R}.  These options are seldom used, but you may use the
{opt ltol(#)} option to relax the convergence criterion; the default is
{cmd:1e-6} during specification searches.

{pmore}
Setting the optimization type to {cmd:technique(bhhh)} resets the default
{it:vcetype} to {cmd:vce(opg)}.

{pstd}
The following option is available with {opt truncreg} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse laborsub}{p_end}
{phang2}{cmd:. regress whrs kl6 k618 wa we if whrs > 0}{p_end}

{pstd}Truncated regression with truncation from below 0{p_end}
{phang2}{cmd:. truncreg whrs kl6 k618 wa we, ll(0)}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. generate lowmpg = 20 if foreign == 0}{p_end}
{phang2}{cmd:. replace lowmpg = 25 if foreign == 1}

{pstd}Truncated regression with {cmd:lowmpg} containing the limit for
truncation{p_end}
{phang2}{cmd:. truncreg mpg price length displacement, ll(lowmpg)}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:truncreg} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_bf)}}number of observations before truncation{p_end}
{synopt:{cmd:e(chi2)}}model chi-squared{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(sigma)}}estimate of sigma{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:truncreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(llopt)}}contents of {cmd:ll()}, if specified{p_end}
{synopt:{cmd:e(ulopt)}}contents of {cmd:ul()}, if specified{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(offset1)}}offset{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test{p_end}
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
{synopt:{cmd:e(means)}}means of independent variables{p_end}
{synopt:{cmd:e(dummy)}}indicator for dummy variables{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

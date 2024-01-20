{smcl}
{* *! version 1.2.21  05may2011}{...}
{viewerdialog clogit "dialog clogit"}{...}
{viewerdialog "svy: clogit" "dialog clogit, message(-svy-) name(svy_clogit)"}{...}
{vieweralsosee "[R] clogit" "mansection R clogit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] clogit postestimation" "help clogit postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] asclogit" "help asclogit"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] logistic" "help logistic"}{...}
{vieweralsosee "[R] mlogit" "help mlogit"}{...}
{vieweralsosee "[R] nlogit" "help nlogit"}{...}
{vieweralsosee "[R] ologit" "help ologit"}{...}
{vieweralsosee "[R] scobit" "help scobit"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy_estimation"}{...}
{vieweralsosee "[XT] xtgee" "help xtgee"}{...}
{vieweralsosee "[XT] xtlogit" "help xtlogit"}{...}
{viewerjumpto "Syntax" "clogit##syntax"}{...}
{viewerjumpto "Description" "clogit##description"}{...}
{viewerjumpto "Options" "clogit##options"}{...}
{viewerjumpto "Examples" "clogit##examples"}{...}
{viewerjumpto "Saved results" "clogit##saved_results"}{...}
{viewerjumpto "References" "clogit##references"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink R clogit} {hline 2}}Conditional (fixed-effects) logistic
regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmdab:clog:it} 
{depvar} 
[{indepvars}] 
{ifin}
{weight} 
{cmd:,} 
{bind:{cmdab:gr:oup:(}{varname}{cmd:)} [{it:options}]}

{synoptset 26 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{p2coldent :* {opth gr:oup(varname)}}matched group variable{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient
constrained to 1{p_end}
{synopt :{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
{opt r:obust}, {opt cl:uster} {it:clustvar},
{opt opg}, {opt boot:strap}, or {opt jack:knife}{p_end}
{synopt :{opt nonest}}do not check that panels are nested within clusters
{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is
{cmd:level(95)}{p_end}
{synopt :{opt or}}report odds ratios{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help clogit##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Maximization}
{synopt :{it:{help clogit##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt group(varname)} is required.{p_end}
INCLUDE help fvvarlist
{p 4 6 2}
{opt bootstrap}, {opt by}, {opt fracpoly}, {opt jackknife}, {opt mfp},
{opt mi estimate}, {opt nestreg}, {opt rolling}, {opt statsby},
{opt stepwise}, and {opt svy} are allowed; see {help prefix}.{p_end}
INCLUDE help vce_mi
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}
{opt vce()}, {opt nonest}, and weights are not allowed with the {helpb svy}
prefix.{p_end}
{p 4 6 2}
{opt fweight}s, {opt iweight}s, and {opt pweight}s are allowed
(see {help weight}), but
they are interpreted to apply to groups as a whole, not to individual
observations. See {mansection R clogitRemarksUseofweights:{it:Use of weights}}
in {bf:[R] clogit}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp clogit_postestimation R:clogit postestimation} for features
available after estimation.  {p_end}


{title:Menu}

{phang}
{bf:Statistics > Categorical outcomes > Conditional logistic regression}


{marker description}{...}
{title:Description}

{pstd}
{cmd:clogit} fits what biostatisticians and epidemiologists call conditional
logistic regression for matched case-control groups
(see, for example, {help clogit##HL2000:Hosmer and Lemeshow [2000, chap. 7]})
and what economists and other social scientists call fixed-effects logit for
panel data (see, for example, {help clogit##C1980:Chamberlain [1980]}).
Computationally, these models are the same.
{it:depvar} equal to nonzero and nonmissing (typically {it:depvar} equal
to one) indicates a positive outcome, whereas {it:depvar} equal to zero
indicates a negative outcome.

{pstd}
See {manhelp asclogit R} if you want to fit McFadden's choice model
({help clogit##M1974:McFadden 1974}).
Also see {help logistic estimation commands} for a list of related estimation
commands.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opth group(varname)} is required; it specifies an identifier variable
(numeric or string) for the matched groups.  {opt strata(varname)} is a
synonym for {opt group()}.

{phang}
{opth offset(varname)},
{opt constraints(constraints)},
{opt collinear}; see
{helpb estimation options:[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{phang}
{opt nonest}, available only with {cmd:vce(cluster} {it:clustvar}{cmd:)},
prevents checking that matched groups are nested within clusters.
It is the user's responsibility to verify that the standard errors are
theoretically correct.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt or} reports the estimated coefficients transformed to odds ratios,
that is, exp(b) rather than b.  Standard errors and confidence intervals are
similarly transformed.  This option affects how results are displayed, not how
they are estimated.  {opt or} may be specified at estimation or when
replaying previously estimated results.

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
{opt ltol:erance(#)}, {opt nrtol:erance(#)},
{opt nonrtol:erance}, and
{opt from(init_specs)}; see {manhelp maximize R}.  These options are seldom
used.

{pmore}
Setting the optimization type to {cmd:technique(bhhh)} resets the default
{it:vcetype} to {cmd:vce(opg)}.

{pstd}
The following option is available with {opt clogit} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse lowbirth2}{p_end}

{pstd}Fit conditional logistic regression (matched case-control data){p_end}
{phang2}{cmd:. clogit low lwt smoke ptd ht ui i.race, group(pairid)}{p_end}

{pstd}Replay results, reporting odds ratios rather than coefficients{p_end}
{phang2}{cmd:. clogit, or}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse union}{p_end}

{pstd}Fit conditional logistic regression (panel data){p_end}
{phang2}{cmd:. clogit union age grade not_smsa, group(idcode)}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:clogit} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_drop)}}number of observations dropped because of all positive
   or all negative outcomes{p_end}
{synopt:{cmd:e(N_group_drop)}}number of groups dropped because of all positive
   or all negative outcomes{p_end}
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
{synopt:{cmd:e(cmd)}}{cmd:clogit}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(group)}}name of {cmd:group()} variable{p_end}
{synopt:{cmd:e(multiple)}}{cmd:multiple} if multiple positive outcomes within group{p_end}
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
{synopt:{cmd:e(marginsok)}}predictions allowed by {cmd:margins}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}
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


{marker references}{...}
{title:References}

{marker C1980}{...}
{phang}
Chamberlain, G. 1980. Analysis of covariance with qualitative data.
{it:Review of Economic Studies} 47: 225-238.

{marker HL2000}{...}
{phang}
Hosmer, D. W., Jr., and S. Lemeshow 2000. 
{browse "http://www.stata.com/bookstore/alr.html":{it:Applied Logistic Regression}. 2nd ed.}
New York: Wiley.

{marker M1974}{...}
{phang}
McFadden, D. L. 1974. Conditional logit analysis of qualitative choice
behavior. In {it:Frontiers in Econometrics}, ed. P. Zarembka, 105-142.
New York: Academic Press.
{p_end}

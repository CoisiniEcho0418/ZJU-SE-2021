{smcl}
{* *! version 1.3.18  03may2011}{...}
{viewerdialog mprobit "dialog mprobit"}{...}
{viewerdialog "svy: mprobit" "dialog mprobit, message(-svy-) name(svy_mprobit)"}{...}
{vieweralsosee "[R] mprobit" "mansection R mprobit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] mprobit postestimation" "help mprobit postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] asmprobit" "help asmprobit"}{...}
{vieweralsosee "[R] clogit" "help clogit"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] mlogit" "help mlogit"}{...}
{vieweralsosee "[R] nlogit" "help nlogit"}{...}
{vieweralsosee "[R] ologit" "help ologit"}{...}
{vieweralsosee "[R] oprobit" "help oprobit"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy_estimation"}{...}
{viewerjumpto "Syntax" "mprobit##syntax"}{...}
{viewerjumpto "Description" "mprobit##description"}{...}
{viewerjumpto "Options" "mprobit##options"}{...}
{viewerjumpto "Examples" "mprobit##examples"}{...}
{viewerjumpto "Saved results" "mprobit##saved_results"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{synopt :{manlink R mprobit} {hline 2}}Multinomial probit regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 13 2}
{cmd:mprobit} 
{depvar} 
[{indepvars}] 
{ifin}
{weight}{cmd:,}
[{it:options}]

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Model}
{synopt :{opt nocon:stant}}suppress constant terms{p_end}
{synopt :{opt base:outcome(#|lbl)}}outcome used for normalizing location{p_end}
{synopt :{opt probit:param}}use the probit variance parameterization{p_end}
{synopt :{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab :SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
{opt r:obust}, {opt cl:uster} {it:clustvar}, {opt opg}, {opt boot:strap},
   or {opt jack:knife}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is 
{cmd:level(95)}{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help mprobit##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab :Integration}
{synopt :{opt intp:oints(#)}}number of quadrature points{p_end}

{syntab :Maximization}
{synopt :{it:{help mprobit##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}{cmd:bootstrap}, {cmd:by}, {cmd:jackknife}, 
{cmd:mi estimate}, {cmd:rolling}, {cmd:statsby}, and {cmd:svy} are allowed; see
{help prefix}.{p_end}
INCLUDE help vce_mi
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}
{opt vce()} and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}{cmd:fweight}s, {cmd:iweight}s, and {cmd:pweight}s are allowed; see {help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp mprobit_postestimation R:mprobit postestimation} for features
available after estimation.  {p_end}


{title:Menu}

{phang}
{bf:Statistics > Categorical outcomes > Independent multinomial probit}

 
{marker description}{...}
{title:Description}

{pstd}
{cmd:mprobit} fits multinomial probit (MNP) models via maximum 
likelihood.  {depvar} contains the outcome for each observation, 
and {indepvars} are the associated covariates.  The error terms are 
assumed to be independent, standard normal, random variables.  
See {manhelp asmprobit R} for the case where the latent-variable
errors are correlated or heteroskedastic and you have 
alternative-specific variables.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}{opt noconstant} suppresses the J-1 constant terms.

{phang}{opt baseoutcome(#|lbl)} specifies the outcome used to normalize the
location of the latent variable.  The base outcome may be specified
as a number or a label.  The default is to use the most frequent outcome.  The
coefficients associated with the base outcome are zero.

{phang}{opt probitparam} specifies to use the probit variance
parameterization by fixing the variance of the differenced latent errors
between the scale and the base alternatives to be one.  The default is to make
the variance of the base and scale latent errors one, thereby making the
variance of the difference to be two.

{phang}{opt constraints(constraints)}, {opt collinear}; see
{helpb estimation options:[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{pmore}
If specifying {cmd:vce(bootstrap)} or {cmd:vce(jackknife)}, you must also
specify {cmd:baseoutcome()}.

{dlgtab:Reporting}

{phang}{opt level(#)}; see
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

{dlgtab:Integration}

{phang}{opt intpoints(#)} specifies the number of Gaussian quadrature
points to use in approximating the likelihood.  The default is 15. 

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
{opt nonrtol:erance}, and
{opt from(init_specs)}; see {manhelp maximize R}.  These options are seldom
used.

{pmore}
Setting the optimization type to {cmd:technique(bhhh)} resets the default
{it:vcetype} to {cmd:vce(opg)}.

{pstd}
The following option is available with {opt mprobit} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sysdsn1}{p_end}

{pstd}Fit multinomial probit model{p_end}
{phang2}{cmd:. mprobit insure age male nonwhite i.site}{p_end}

{pstd}Same as above, but use outcome 2 to normalize the location of the latent
variable{p_end}
{phang2}{cmd:. mprobit insure age male nonwhite i.site, baseoutcome(2)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:mprobit} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(k_out)}}number of outcomes{p_end}
{synopt:{cmd:e(k_points)}}number of quadrature points{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_indvars)}}number of independent variables{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(ll)}}log simulated-likelihood{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(i_base)}}base outcome index{p_end}
{synopt:{cmd:e(const)}}{cmd:0} if {cmd:noconstant} is specified, {cmd:1}
              otherwise{p_end}
{synopt:{cmd:e(probitparam)}}{cmd:1} if {cmd:probitparam} is specified,
               {cmd:0} otherwise{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:mprobit}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(indvars)}}independent variables{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald}, type of model chi-squared test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(outeqs)}}outcome equations{p_end}
{synopt:{cmd:e(out}{it:#}{cmd:)}}outcome labels, {it:#}=1,...,{cmd:e(k_out)}{p_end}
{synopt:{cmd:e(opt)}}type of optimization{p_end}
{synopt:{cmd:e(which)}}{cmd:max} or {cmd:min}; whether optimizer is to perform
                         maximization or minimization{p_end}
{synopt:{cmd:e(ml_method)}}type of {cmd:ml} method{p_end}
{synopt:{cmd:e(user)}}name of likelihood-evaluator program{p_end}
{synopt:{cmd:e(technique)}}maximization technique{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(outcomes)}}outcome values{p_end}
{synopt:{cmd:e(Cns)}}constraints matrix{p_end}
{synopt:{cmd:e(ilog)}}iteration log (up to 20 iterations){p_end}
{synopt:{cmd:e(gradient)}}gradient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

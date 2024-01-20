{smcl}
{* *! version 1.2.19  28apr2011}{...}
{viewerdialog xtintreg "dialog xtintreg"}{...}
{vieweralsosee "[XT] xtintreg" "mansection XT xtintreg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtintreg postestimation" "help xtintreg postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] intreg" "help intreg"}{...}
{vieweralsosee "[XT] quadchk" "help quadchk"}{...}
{vieweralsosee "[R] tobit" "help tobit"}{...}
{vieweralsosee "[XT] xtreg" "help xtreg"}{...}
{vieweralsosee "[XT] xttobit" "help xttobit"}{...}
{viewerjumpto "Syntax" "xtintreg##syntax"}{...}
{viewerjumpto "Description" "xtintreg##description"}{...}
{viewerjumpto "Options" "xtintreg##options"}{...}
{viewerjumpto "Technical note" "xtintreg##technote"}{...}
{viewerjumpto "Examples" "xtintreg##examples"}{...}
{viewerjumpto "Saved results" "xtintreg##saved_results"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink XT xtintreg} {hline 2}}Random-effects interval-data 
regression models{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 18 2}
{cmd:xtintreg} 
{it:{help depvar:depvar_lower}}
{it:{help depvar:depvar_upper}}
[{indepvars}]
{ifin}
{weight}
[{cmd:,} {it:options}]

{synoptset 27 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Model}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient constrained to 1{p_end}
{synopt :{opth constr:aints(estimation options##constraints():constraints)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab :SE}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
      {opt boot:strap}, or {opt jack:knife}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt noskip}}perform likelihood-ratio test{p_end}
{synopt :{opt intreg}}perform likelihood-ratio test against pooled model{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help xtintreg##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

INCLUDE help intpts1
 
{syntab :Maximization}
{synopt :{it:{help xtintreg##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
A panel variable must be specified; use {helpb xtset}.{p_end}
INCLUDE help fvvarlist
{p 4 6 2}
{it:depvar_lower}, {it:depvar_upper}, and {it:indepvars} may contain time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}
{opt by} and {opt statsby} are allowed; see {help prefix}.{p_end}
{p 4 6 2}
{opt iweight}s are allowed; see {help weight}.  Weights must be constant
within panel.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {helpb xtintreg postestimation:[XT] xtintreg postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Longitudinal/panel data > Censored outcomes >}
     {bf:Interval regression (RE)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:xtintreg} fits a random-effects regression model whose dependent variable
may be measured as point data, interval data, left-censored data, or
right-censored data.  {it:{help depvar:depvar_lower}} and {it:depvar_upper}
represent how the dependent variable was measured.

{pstd}
The values in {it:depvar_lower} and {it:depvar_upper} have the following form:

             Type of data {space 16} {it:depvar_lower}  {it:depvar_upper}
             {hline 56}
             point data{space 10}{it:a} = [{it:a},{it:a}]{space 4}{it:a}{space 13}{it:a} 
             interval data{space 11}[{it:a},{it:b}]{space 4}{it:a}{space 13}{it:b}
             left-censored data{space 3}(-inf,{it:b}]{space 4}{cmd:.}{space 13}{it:b}
             right-censored data{space 3}[{it:a},inf){space 4}{it:a}{space 13}{cmd:.} 
             {hline 56}


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant}, {opth offset(varname)}, 
{opt constraints(constraints)}, {opt collinear};
see {helpb estimation options:[R] estimation options}.

{dlgtab:SE}

INCLUDE help xt_vce_asymptbj

{dlgtab:Reporting}

{phang}
{opt level(#)}, {opt noskip}; see
 {helpb estimation options##level():[R] estimation options}. 

{phang}
{opt intreg} specifies that a likelihood-ratio test comparing the
random-effects model with the pooled ({cmd:intreg}) model be included in the
output.

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

INCLUDE help intpts4

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
The following option is available with {opt xtintreg} but is not shown in the
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
Because the {cmd:xtintreg} likelihood function is calculated by Gauss-Hermite
quadrature, on large problems, the computations can be slow.  Computation time
is roughly proportional to the number of points used for the quadrature.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse nlswork5}{p_end}
{phang2}{cmd:. xtset idcode}{p_end}

{pstd}Fit random-effects (RE) interval-data regression model{p_end}
{phang2}{cmd:. xtintreg ln_wage1 ln_wage2 union age grade south##c.year}
          {cmd:occ_code}{p_end}

{pstd}Same as above, but include likelihood-ratio test comparing RE model with
the pooled model{p_end}
{phang2}{cmd:. xtintreg ln_wage1 ln_wage2 union age grade south##c.year}
          {cmd:occ_code, intreg}{p_end}

{pstd}Fit RE interval-data regression model using nonadaptive Gauss-Hermite
quadrature{p_end}
{phang2}{cmd:. xtintreg ln_wage1 ln_wage2 union age grade south##c.year}
          {cmd:occ_code, intmethod(ghermite)}{p_end}

{pstd}Replay results and report 99.5% confidence intervals{p_end}
{phang2}{cmd:. xtintreg, level(99.5)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:xtintreg} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(N_unc)}}number of uncensored observations{p_end}
{synopt:{cmd:e(N_lc)}}number of left-censored observations{p_end}
{synopt:{cmd:e(N_rc)}}number of right-censored observations{p_end}
{synopt:{cmd:e(N_int)}}number of interval observations{p_end}
{synopt:{cmd:e(N_cd)}}number of completely determined observations{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(chi2_c)}}chi-squared for comparison test{p_end}
{synopt:{cmd:e(rho)}}rho{p_end}
{synopt:{cmd:e(sigma_u)}}panel-level standard deviation{p_end}
{synopt:{cmd:e(sigma_e)}}standard deviation of epsilon_it{p_end}
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
{synopt:{cmd:e(cmd)}}{cmd:xtintreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(offset1)}}offset{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test{p_end}
{synopt:{cmd:e(chi2_ct)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test corresponding to {cmd:e(chi2_c}{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(intmethod)}}integration method{p_end}
{synopt:{cmd:e(distrib)}}{cmd:Gaussian}; the distribution of the random effect{p_end}
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
{p2colreset}{...}

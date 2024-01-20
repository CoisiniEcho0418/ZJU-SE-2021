{smcl}
{* *! version 1.2.23  17may2011}{...}
{viewerdialog heckman_ml "dialog heckman_ml"}{...}
{viewerdialog heckman_2step "dialog heckman_2step"}{...}
{viewerdialog "svy: heckman_ml" "dialog heckman_ml, message(-svy-) name(svy_heckman_ml)"}{...}
{vieweralsosee "[R] heckman" "mansection R heckman"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] heckman postestimation" "help heckman postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] heckprob" "help heckprob"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[R] tobit" "help tobit"}{...}
{vieweralsosee "[R] treatreg" "help treatreg"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy_estimation"}{...}
{viewerjumpto "Syntax" "heckman##syntax"}{...}
{viewerjumpto "Description" "heckman##description"}{...}
{viewerjumpto "Options for Heckman selection model (ML)" "heckman##options_ml"}{...}
{viewerjumpto "Options for Heckman selection model (two-step)" "heckman##options_twostep"}{...}
{viewerjumpto "Remarks" "heckman##remarks"}{...}
{viewerjumpto "Examples" "heckman##examples"}{...}
{viewerjumpto "Saved results" "heckman##saved_results"}{...}
{viewerjumpto "Reference" "heckman##reference"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R heckman} {hline 2}}Heckman selection model{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}Basic syntax

{p 8 16 2}{cmd:heckman} {depvar} [{indepvars}]{cmd:,} 
      {opth sel:ect(varlist:varlist_s)} [{opt two:step}]

      or

{p 8 16 2}{cmd:heckman} {depvar} [{indepvars}]{cmd:,} 
      {cmdab:sel:ect(}{it:{help depvar:depvar_s}} {cmd:=}
                    {it:{help varlist:varlist_s}}{cmd:)} [{opt two:step}]


{phang}Full syntax for maximum likelihood estimates only

{p 8 16 2}{cmd:heckman} {depvar} [{indepvars}] {ifin} {weight} {cmd:,} 
    {opt sel:ect}{cmd:(}[{it:{help depvar:depvar_s}} {cmd:=}]
    {it:{help varlist:varlist_s}} [{cmd:,} 
    {opth off:set(varname)} {opt noc:onstant}]{cmd:)} 
    [{it:{help heckman##heckman_ml_options:heckman_ml_options}}]


{phang}Full syntax for Heckman's two-step consistent estimates only

{p 8 16 2}{cmd:heckman} {depvar} [{indepvars}] {ifin}{opt ,} {opt two:step}
   {opt sel:ect}{cmd:(}[{it:{help depvar:depvar_s}} {cmd:=}]
                        {it:{help varlist:varlist_s}}
   [{cmd:,} {opt noc:onstant}]{cmd:)} 
   [{it:{help heckman##heckman_ts_options:heckman_ts_options}}]


{synoptset 28 tabbed}{...}
{marker heckman_ml_options}{...}
{synopthdr :heckman_ml_options}
{synoptline}
{syntab :Model}
{p2coldent :* {opt sel:ect()}}specify selection equation: dependent and independent variables; whether to have constant term and offset variable{p_end}
{synopt :{opt noc:onstant}}suppress constant term{p_end}
{synopt :{opth off:set(varname)}}include {it:varname} in model with coefficient constrained to 1{p_end}
{synopt :{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints{p_end}
{synopt:{opt col:linear}}keep collinear variables{p_end}

{syntab :SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
{opt r:obust}, {opt cl:uster} {it:clustvar}, {cmd:opg},
{opt boot:strap}, or {opt jack:knife}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt fir:st}}report first-step probit estimates{p_end}
{synopt :{opt noskip}}perform likelihood-ratio test{p_end}
{synopt :{opth ns:hazard(newvar)}}generate nonselection hazard variable{p_end}
{synopt :{opth m:ills(newvar)}}synonym for {opt nshazard()}{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help heckman##ml_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab :Maximization}
{synopt :{it:{help heckman##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt select()} is required. The full specification is{break}
{opt sel:ect}{cmd:(}[{it:depvar_s} {cmd:=}] {it:varlist_s}
[{cmd:,} {opt off:set(varname)} {opt noc:onstant}]{cmd:)}
{p_end}

{synoptset 28 tabbed}{...}
{marker heckman_ts_options}{...}
{synopthdr :heckman_ts_options}
{synoptline}
{syntab :Model}
{p2coldent :* {opt sel:ect()}}specify selection equation: dependent and independent variables; whether to have constant term{p_end}
{p2coldent :* {opt two:step}}produce two-step consistent estimate{p_end}
{synopt :{opt noc:onstant}}suppress constant term{p_end}
{synopt :{opt rhos:igma}}truncate rho to [-1,1] with consistent Sigma{p_end}
{synopt :{opt rhot:runc}}truncate rho to [-1,1]{p_end}
{synopt :{opt rhol:imited}}truncate rho in limited cases{p_end}
{synopt :{opt rhof:orce}}do not truncate rho{p_end}

{syntab :SE}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt conventional},
             {opt boot:strap}, or {opt jack:knife}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt fir:st}}report first-step probit estimates{p_end}
{synopt :{opth ns:hazard(newvar)}}generate nonselection hazard variable{p_end}
{synopt :{opth m:ills(newvar)}}synonym for {opt nshazard()}{p_end}
{synopt :{it:{help heckman##ts_display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt select()} and {opt twostep} are required. The full specification is{p_end}
{p 10 10 2}
{opt sel:ect}{cmd:(}[{it:depvar_s} {cmd:=}] {it:varlist_s}
[{cmd:,} {opt noc:onstant}]{cmd:)}
{p_end}

{p 4 6 2}{it:indepvars} and {it:varlist_s} may contain factor variables; see
{help fvvarlist}.{p_end}
{p 4 6 2}{it:depvar}, {it:indepvars}, {it:varlist_s}, and {it:depvar_s} may
contain time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}{cmd:bootstrap}, {cmd:by}, {cmd:jackknife}, {cmd:rolling},
{cmd:statsby}, and {cmd:svy} are allowed; see {help prefix}.{p_end}
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{cmd:aweight}s are not allowed with the {helpb jackknife} prefix.
{p_end}
{p 4 6 2}
{opt twostep},
{opt vce()},
{opt first},
{opt noskip},
and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}{opt pweight}s, {opt aweight}s, {opt fweight}s, and {opt iweight}s
are allowed with maximum likelihood estimation; see {help weight}.  No weights
are allowed if {opt twostep} is specified.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}See {manhelp heckman_postestimation R:heckman postestimation} for
features available after estimation.  {p_end}


{title:Menu}

    {title:heckman for maximum likelihood estimates}

{phang2}
{bf:Statistics > Sample-selection models > Heckman selection model (ML)}

    {title:heckman for two-step consistent estimates}

{phang2}
{bf:Statistics > Sample-selection models > Heckman selection model (two-step)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:heckman} fits regression models with selection by using either
Heckman's two-step consistent estimator or full maximum likelihood.


{marker options_ml}{...}
{title:Options for Heckman selection model (ML)}

{dlgtab:Model}

{phang}
{opt select(...)} specifies the variables and options for the selection
equation.  It is an integral part of specifying a Heckman model and is
required.  The selection equation should contain at least one variable that is
not in the outcome equation.

{pmore}
If {it:{help depvar:depvar_s}} is specified, it should be coded as 0 or 1, with
0 indicating an observation not selected and 1 indicating a selected
observation.  If {it:depvar_s} is not specified, observations for which
{it:depvar} is not missing are assumed selected, and those for which
{it:depvar} is missing are assumed not selected.

{phang}
{opt noconstant}, {opth offset(varname)}, {opt constraints(constraints)},
{opt collinear}; see 
{helpb estimation options:[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{marker Reporting}{...}
{dlgtab:Reporting}

{phang}
{opt level(#)}; see 
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt first} specifies that the first-step probit estimates of the
selection equation be displayed before estimation.

{phang}
{opt noskip} specifies that a full maximum-likelihood model with only a
constant for the regression equation be fit.  This model is not displayed
but is used as the base model to compute a likelihood-ratio test for the model
test statistic displayed in the estimation header.  By default, the overall
model test statistic is an asymptotically equivalent Wald test that all the
parameters in the regression equation are zero (except the constant).  For
many models, this option can substantially increase estimation time.

{phang}
{opth nshazard(newvar)} and {opt mills(newvar)} are synonyms; either will
create a new variable containing the nonselection hazard -- what 
{help heckman##H1979:Heckman (1979)}
referred to as the inverse of the Mills' ratio -- from the
selection equation.  The nonselection hazard is computed from the estimated
parameters of the selection equation.

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
{it:maximize_options}: {opt dif:ficult},
{opth tech:nique(maximize##algorithm_spec:algorithm_spec)}, 
{opt iter:ate(#)}, [{cmdab:no:}]{opt lo:g}, {opt tr:ace},
{opt grad:ient}, {opt showstep},
{opt hess:ian}, {opt showtol:erance},
{opt tol:erance(#)}, {opt ltol:erance(#)}, 
{opt nrtol:erance(#)}, {opt nonrtol:erance}, and
{opt from(init_specs)}; see {manhelp maximize R}.  These options are seldom
used.

{pmore}
Setting the optimization type to {cmd:technique(bhhh)} resets the default
{it:vcetype} to {cmd:vce(opg)}.

{pstd}
The following option is available with {opt heckman} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker options_twostep}{...}
{title:Options for Heckman selection model (two-step)}

{dlgtab:Model}

{phang}
{opt select(...)} specifies the variables and options for the selection
equation.  It is an integral part of specifying a Heckman model and is
required.  The selection equation should contain at least one variable that is
not in the outcome equation.

{pmore}
If {it:{help depvar:depvar_s}} is specified, it should be coded as 0 or 1,
with 0 indicating an observation not selected and 1 indicating a selected
observation.  If {it:depvar_s} is not specified, observations for which
{it:depvar} is not missing are assumed selected, and those for which
{it:depvar} is missing are assumed not selected.

{phang}
{opt twostep} specifies that Heckman's 
{help heckman##H1979:(1979)} two-step efficient estimates of
the parameters, standard errors, and covariance matrix be produced.

{phang}
{opt noconstant}; see
{helpb estimation options##noconstant:[R] estimation options}.

{phang}
{opt rhosigma}, {opt rhotrunc}, {opt rholimited}, and {opt rhoforce} are
rarely used options to specify how the two-step estimator (option 
{opt twostep}) handles unusual cases in which the two-step estimate of rho is
outside the admissible range for a correlation, [-1,1].  When
rho is outside this range, the two-step estimate of the coefficient
variance-covariance matrix may not be positive definite and thus may be
unusable for testing.  The default is {opt rhosigma}.

{pmore}
{cmd:rhosigma} specifies that rho be truncated, as with the {opt rhotrunc}
option,
and that the estimate of sigma be made consistent with rho_hat, the truncated
estimate of rho.  So, sigma_hat = B_m * rho_hat; see
{it:{mansection R heckmanMethodsandformulas:Methods and formulas}}
in {bf:[R] heckman} for the definition of B_m.  Both the truncated rho
and the new estimate of sigma_hat are used in all computations to estimate the
two-step covariance matrix.

{pmore}
{opt rhotrunc} specifies that rho be truncated to lie in the range [-1,1].  If
the two-step estimate is less than -1, rho is set to -1; if the two-step
estimate is greater than 1, rho is set to 1.  This truncated value of rho is
used in all computations to estimate the two-step covariance matrix.

{pmore}
{opt rholimited} specifies that rho be truncated only in computing the
diagonal matrix D as it enters V_twostep and Q; see 
{it:{mansection R heckmanMethodsandformulas:Methods and formulas}}
in {hi:[R] heckman}.  In all other computations, the
untruncated estimate of rho is used.

{pmore}
{opt rhoforce} specifies that the two-step estimate of rho be retained, even
if it is outside the admissible range for a correlation.  This option may, in
rare cases, lead to a non-positive-definite covariance matrix.

{pmore}
These options have no effect when estimation is by maximum likelihood, the
default.  They also have no effect when the two-step estimate of rho is in the
range [-1,1].

{dlgtab:SE}

INCLUDE help vce_asymptbj

{pmore}
{cmd:vce(conventional)}, the default, uses the two-step variance estimator
derived by Heckman.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt first} specifies that the first-step probit estimates of the
selection equation be displayed before estimation.

{phang}
{opth nshazard(newvar)} and {opt mills(newvar)} are synonyms; either will
create a new variable containing the nonselection hazard -- what
{help heckman##H1979:Heckman (1979)}
referred to as the inverse of the Mills' ratio -- from the
selection equation.  The nonselection hazard is computed from the estimated
parameters of the selection equation.

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
The following option is available with {opt heckman} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker remarks}{...}
{title:Remarks}

{pstd}
Heckman estimates all the parameters in the model:

{pin}(regression equation: y is {it:depvar}, x is {it:varlist}){p_end}
{pin}y = xb + u_1

{pin}(selection equation: Z is {it:varlist_s}){p_end}
{pin}y observed if  Zg + u_2 > 0

	where:
		u_1 ~ N(0, sigma)
		u_2 ~ N(0, 1)
		corr(u_1, u_2) = rho

{pstd}
In the syntax for {cmd:heckman}, {depvar} and {varlist} are the dependent
variable and regressors for the underlying regression model (y = xb), and
{it:varlist_s} are the variables (Z) thought to determine whether {it:depvar}
is selected or observed (selected or not selected).  By default, {cmd:heckman}
assumes that missing values (see {help missing}) of {it:depvar} imply
that the dependent variable is unobserved (not selected).  With some datasets,
it is more convenient to specify a binary variable ({it:depvar_s}) that
identifies the observations for which the dependent is observed/selected
({it:depvar_s}!=0) or not observed ({it:depvar_s}=0); {cmd:heckman} will
accommodate either type of data.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse womenwk}{p_end}

{pstd}Obtain full ML estimates{p_end}
{phang2}{cmd:. heckman wage educ age, select(married children educ age)}

{pstd}Obtain Heckman's two-step consistent estimates{p_end}
{phang2}{cmd:. heckman wage educ age, select(married children educ age) twostep}

{pstd}Define and use each equation separately{p_end}
{phang2}{cmd:. global wage_eqn wage educ age}{p_end}
{phang2}{cmd:. global seleqn married children age}{p_end}
{phang2}{cmd:. heckman $wage_eqn, select($seleqn)}

{pstd}Use a variable to identify selection{p_end}
{phang2}{cmd:. generate wageseen = (wage < .)}{p_end}
{phang2}{cmd:. heckman wage educ age, select(wageseen = married children educ age)}

{pstd}Specify robust variance{p_end}
{phang2}{cmd:. heckman wage educ age, select(married children educ age) vce(robust)}{p_end}

{pstd}Specify clustering on {cmd:county}{p_end}
{phang2}{cmd:. heckman $wage_eqn, select($seleqn) vce(cluster county)}{p_end}

{pstd}Report first-step probit estimates{p_end}
{phang2}{cmd:. heckman wage educ age, select(married children educ age) first}

{pstd}Create {cmd:mymills} containing nonselection hazard{p_end}
{phang2}{cmd:. heckman $wage_eqn, select($seleqn) mills(mymills)}

{pstd}No constant in model{p_end}
{phang2}{cmd:. heckman wage educ age, noconstant select(married children educ age)}{p_end}

{pstd}No constant in selection equation{p_end}
{phang2}{cmd:. heckman wage educ age, select(married children educ age, noconstant)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:heckman} (maximum likelihood) saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_cens)}}number of censored observations{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq_model)}}number of equations in overall model test{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt:{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(lambda)}}lambda{p_end}
{synopt:{cmd:e(selambda)}}standard error of lambda{p_end}
{synopt:{cmd:e(sigma)}}sigma{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(chi2_c)}}chi-squared for comparison test{p_end}
{synopt:{cmd:e(p_c)}}p-value for comparison test{p_end}
{synopt:{cmd:e(p)}}significance of comparison test{p_end}
{synopt:{cmd:e(rho)}}rho{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(rank0)}}rank of {cmd:e(V)} for constant-only model{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:heckman}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}names of dependent variable{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(title2)}}secondary title in estimation output{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(offset1)}}offset for regression equation{p_end}
{synopt:{cmd:e(offset2)}}offset for selection equation{p_end}
{synopt:{cmd:e(mills)}}variable containing nonselection hazard (inverse of
	Mills'){p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test{p_end}
{synopt:{cmd:e(chi2_ct)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared test
	corresponding to {cmd:e(chi2_c)}{p_end}
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
{cmd:heckman} (two-step) saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_cens)}}number of censored observations{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(lambda)}}lambda{p_end}
{synopt:{cmd:e(selambda)}}standard error of lambda{p_end}
{synopt:{cmd:e(sigma)}}sigma{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(p)}}significance of comparison test{p_end}
{synopt:{cmd:e(rho)}}rho{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:heckman}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}names of dependent variable{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(title2)}}secondary title in estimation output{p_end}
{synopt:{cmd:e(mills)}}variable containing nonselection hazard (inverse of
	Mills'){p_end}
{synopt:{cmd:e(chi2type)}}{cmd:Wald} or {cmd:LR}; type of model chi-squared
	test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(rhometh)}}{cmd:rhosigma}, {cmd:rhotrunc}, {cmd:rholimited}, or
          {cmd:rhoforce}{p_end}
{synopt:{cmd:e(method)}}{cmd:twostep}{p_end}
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
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker reference}{...}
{title:Reference}

{marker H1979}{...}
{phang}
Heckman, J. 1979.
Sample selection bias as a specification error.
{it:Econometrica} 47: 153--161.
{p_end}

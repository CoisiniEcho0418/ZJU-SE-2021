{smcl}
{* *! version 1.1.17  16may2011}{...}
{viewerdialog xtdpdsys "dialog xtdpdsys"}{...}
{vieweralsosee "[XT] xtdpdsys" "mansection XT xtdpdsys"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtdpdsys postestimation" "help xtdpdsys postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtset" "help xtset"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtabond" "help xtabond"}{...}
{vieweralsosee "[XT] xtdpd" "help xtdpd"}{...}
{vieweralsosee "[XT] xtivreg" "help xtivreg"}{...}
{vieweralsosee "[XT] xtreg" "help xtreg"}{...}
{vieweralsosee "[XT] xtregar" "help xtregar"}{...}
{viewerjumpto "Syntax" "xtdpdsys##syntax"}{...}
{viewerjumpto "Description" "xtdpdsys##description"}{...}
{viewerjumpto "Options" "xtdpdsys##options"}{...}
{viewerjumpto "Examples" "xtdpdsys##examples"}{...}
{viewerjumpto "Saved results" "xtdpdsys##saved_results"}{...}
{viewerjumpto "References" "xtdpdsys##references"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink XT xtdpdsys} {hline 2}}Arellano-Bover/Blundell-Bond linear dynamic panel-data estimation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}{cmd:xtdpdsys} {depvar} [{indepvars}] {ifin} [{cmd:,} {it:options}]

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{synopt :{opt nocons:tant}}suppress constant term{p_end}
{synopt :{opt la:gs(#)}}use {it:#} lags of dependent variable as covariates; default is {cmd:lags(1)}{p_end}
{synopt :{opt maxld:ep(#)}}maximum lags of dependent variable for use as instruments{p_end}
{synopt :{opt maxlag:s(#)}}maximum lags of predetermined and endogenous variables for use as instruments{p_end}
{synopt :{opt two:step}}compute the two-step estimator instead of the one-step estimator{p_end}

{syntab:Predetermined}
{synopt :{cmd:pre(}{varlist}[{it:...}]{cmd:)}}predetermined variables; can be specified more than once{p_end}

{syntab:Endogenous}
{synopt :{cmdab:end:ogenous(}{varlist}[{it:...}]{cmd:)}}endogenous variables; can be specified more than once{p_end}

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt gmm} or {opt r:obust}{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt ar:tests(#)}}use {it:#} as maximum order for AR tests; default is {cmd:artests(2)}{p_end}
{synopt :{it:{help xtdpdsys##display_options:display_options}}}control spacing
         and line width{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
A panel variable and a time variable must be specified; use {cmd:xtset};
see {manhelp xtset XT}.
{p_end}
{p 4 6 2}
{it:indepvars} and all {it:varlists}, except
{cmd:pre(}{it:varlist}[{it:...}]{cmd:)} and
{cmd:endogenous(}{it:varlist}[{it:...}]{cmd:)}, may contain time-series
operators; see {help tsvarlist}.  The specification of {it:depvar} may not
contain time-series operators.{p_end}
{p 4 6 2} 
{opt by}, {opt statsby}, and {cmd:xi} are allowed; see {help prefix}.
{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {helpb xtdpdsys postestimation:[XT] xtdpdsys postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Longitudinal/panel data > Dynamic panel data (DPD) >}
       {bf:Arellano-Bover/Blundell-Bond estimation}


{marker description}{...}
{title:Description}

{pstd}
Linear dynamic panel-data models include {it:p} lags of the dependent
variable as covariates and contain unobserved panel-level effects, fixed or
random.  By construction, the unobserved panel-level effects are correlated
with the lagged dependent variables, making standard estimators
inconsistent.  {help xtdpdsys##AB1991:Arellano and Bond (1991)}
derived a consistent generalized
method of moments (GMM) estimator for this model.  The Arellano and Bond
estimator can perform poorly if the autoregressive parameters are too large
or the ratio of the variance of the panel-level effect to the variance of
idiosyncratic error is too large.  Building on the work of
{help xtdpdsys##AB1995:Arellano and Bover (1995)},
{help xtdpdsys##BB1998:Blundell and Bond (1998)} developed a system estimator
that uses additional moment conditions; {cmd:xtdpdsys} implements this
estimator.

{pstd}
This estimator is designed for datasets with many panels and few 
periods.  This method assumes that there is no autocorrelation in the
idiosyncratic errors and requires the initial condition that the panel-level
effects be uncorrelated with the first difference of the first observation
of the dependent variable.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant}; see
{helpb estimation options##noconstant:[R] estimation options}.

{phang}
{opt lags(#)} sets p, the number of lags of the dependent variable to be
included in the model.  The default is p=1.

{phang}
{opt maxldep(#)} sets the maximum number of lags of the dependent variable
that can be used as instruments.  The default is to use all T_i-p-2 lags.

{phang}
{opt maxlags(#)} sets the maximum number of lags of the predetermined
variables that can be used as instruments.  The default is to use all T_i-p-2
lags of the dependent variable.  If the predetermined variables are
endogenous, the default is to use all T_i-p-2 lags of these endogenous
variables.  If the predetermined variables are not endogenous, the default is
to use all T_i-p-1 lags of these variables.

{phang}
{opt twostep} specifies that the two-step estimator be calculated.

{dlgtab:Predetermined}

{marker options}{...}
{phang}
{cmd:pre(}{varlist} [{cmd:,} {opt lag:struct(prelags, premaxlags)}]{cmd:)}
specifies that a set of predetermined variables be included in the model.
Optionally, one may specify that {it:prelags} lags of the specified
variables also be included.  The default for {it:prelags} is 0.  Specifying
{it:premaxlags} sets the maximum number of further lags of the predetermined
variables that can be used as instruments.  The default is to include
T_i-p-1 lagged levels as instruments for predetermined variables.  You may
specify as many sets of predetermined variables as you need within the
standard Stata limits on matrix size.  Each set of predetermined variables
may have its own number of {it:prelags} and {it:premaxlags}.

{dlgtab:Endogenous}

{marker options}{...}
{phang}
{cmdab:end:ogenous(}{varlist} [{cmd:,} 
{opt lag:struct(endlags, endmaxlags)}]{cmd:)} specifies that a set of
endogenous variables be included in the model.  Optionally, one may
specify that {it:endlags} lags of the specified variables also be included.
The default for {it:endlags} is 0.  Specifying {it:endmaxlags} sets the
maximum number of further lags of the endogenous variables that can be used
as instruments.  The default is to include T_i-p-2 lagged levels as
instruments for endogenous variables.  You may specify as many sets of
endogenous variables as you need within the standard Stata limits on matrix
size.  Each set of endogenous variables may have its own number of
{it:endlags} and {it:endmaxlags}.

{dlgtab:SE/Robust}

{phang}
{opt vce(vcetype)} specifies the type of standard error reported, which
includes types that are derived from asymptotic theory and that are robust
to some kinds of misspecification; see
{mansection XT xtdpdMethodsandformulas:{it:Methods and formulas}} in
{bf:[XT] xtdpd}. 

{pmore}
{cmd:vce(gmm)}, the default, uses the conventionally derived variance
estimator for generalized method of moments estimation.

{pmore}
{cmd:vce(robust)} uses the robust estimator.  For the one-step estimator,
this is the Arellano-Bond robust VCE estimator.  For the two-step estimator,
this is the {help xtdpdsys##W2005:Windmeijer (2005)} WC-robust estimator.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt artests(#)} specifies the maximum order of the autocorrelation test to
be calculated.  The tests are reported by {cmd:estat} {cmd:abond}; see
{helpb xtdpdsys postestimation:[XT] xtdpdsys postestimation}.  Specifying the
order of the highest test at estimation time is more efficient than
specifying it to {cmd:estat} {cmd:abond}, because {cmd:estat} {cmd:abond}
must refit the model to obtain the test statistics.  The maximum order must
be less than or equal to the number of periods in the longest panel.
The default is {cmd:artests(2)}.

{marker display_options}{...}
{phang}
{it:display_options}:
{opt vsquish} and {opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.

{pstd}
The following option is available with {opt xtdpdsys} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse abdata}{p_end}

{pstd}Basic model with strictly exogenous covariates and two lags of the 
the dependent variable{p_end}
{phang2}{cmd:. xtdpdsys n l(0/1).w l(0/2).(k ys) yr1980-yr1984, lags(2)}{p_end}

{pstd}Same model with a robust VCE{p_end}
{phang2}{cmd:. xtdpdsys n l(0/1).w l(0/2).(k ys) yr1980-yr1984, lags(2)}
              {cmd:vce(robust)}{p_end}

{pstd}Twostep estimator of the same model with a robust VCE{p_end}
{phang2}{cmd:. xtdpdsys n l(0/1).w l(0/2).(k ys) yr1980-yr1984, lags(2) twostep vce(robust)} 
{p_end}

{pstd}Now allow some of the covariates to be predetermined{p_end}
{phang2}{cmd:. xtdpdsys n l(0/1).w l(0/2).(k ys) yr1980-yr1984, lags(2) twostep}
              {cmd:pre(w, lag(1,.)) pre(k,lag(2,.))}{p_end}

{pstd}Now allow some of the covariates to be endogenous{p_end}
{phang2}{cmd:. xtdpdsys n l(0/1).ys yr1980-yr1984, lags(2) twostep}
              {cmd:endogenous(w, lag(1,.)) endogenous(k,lag(2,.))}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:xtdpdsys} saves the following in {cmd:e()}:

{synoptset 19 tabbed}{...}
{p2col 5 19 23 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(g_min)}}smallest group size{p_end}
{synopt:{cmd:e(g_avg)}}average group size{p_end}
{synopt:{cmd:e(g_max)}}largest group size{p_end}
{synopt:{cmd:e(t_min)}}minimum time in sample{p_end}
{synopt:{cmd:e(t_max)}}maximum time in sample{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(arm}{it:#}{cmd:)}}test for autocorrelation of order {it:#}{p_end}
{synopt:{cmd:e(artests)}}number of AR tests computed{p_end}
{synopt:{cmd:e(sig2)}}estimate of sigma_epsilon^2{p_end}
{synopt:{cmd:e(rss)}}sum of squared differenced residuals{p_end}
{synopt:{cmd:e(sargan)}}Sargan test statistic{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(zrank)}}rank of instrument matrix{p_end}

{synoptset 19 tabbed}{...}
{p2col 5 19 23 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtdpd}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(twostep)}}{cmd:twostep}, if specified{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(tvar)}}variable denoting time within groups{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(system)}}{cmd:system}, if system estimator{p_end}
{synopt:{cmd:e(hascons)}}{cmd:hascons}, if specified{p_end}
{synopt:{cmd:e(transform)}}specified transform{p_end}
{synopt:{cmd:e(datasignature)}}checksum from {cmd:datasignature}{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsok)}}predictions allowed by {cmd:margins}{p_end}

{synoptset 19 tabbed}{...}
{p2col 5 19 23 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 19 tabbed}{...}
{p2col 5 19 23 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker AB1991}{...}
{phang}
Arellano, M., and S. Bond. 1991.
Some tests of specification for panel data: Monte Carlo evidence and an
application to employment equations.
{it:Review of Economic Studies} 58: 277-297.

{marker AB1995}{...}
{phang}
Arellano, M., and O. Bover. 1995.
Another look at the instrumental variable estimation of error-components
models. {it:Journal of Econometrics} 68: 29-51.

{marker BB1998}{...}
{phang}
Blundell, R., and S. Bond. 1998.
Initial conditions and moment restrictions in dynamic panel data models.
{it:Journal of Econometrics} 87: 115-143.

{marker W2005}{...}
{phang}
Windmeijer, F. 2005. A finite sample correction for the variance of linear
efficient two-step GMM estimators. {it:Journal of Econometrics} 126: 25-51.
{p_end}

{smcl}
{* *! version 1.2.6  22jun2011}{...}
{viewerdialog ucm "dialog ucm"}{...}
{vieweralsosee "[TS] ucm" "mansection TS ucm"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] ucm postestimation" "help ucm postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] arima" "help arima"}{...}
{vieweralsosee "[TS] sspace" "help sspace"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{vieweralsosee "[TS] tsfilter" "help tsfilter"}{...}
{vieweralsosee "[TS] tssmooth" "help tssmooth"}{...}
{vieweralsosee "[TS] var" "help var"}{...}
{viewerjumpto "Syntax" "ucm##syntax"}{...}
{viewerjumpto "Description" "ucm##description"}{...}
{viewerjumpto "Options" "ucm##options"}{...}
{viewerjumpto "Examples" "ucm##examples"}{...}
{viewerjumpto "Saved results" "ucm##saved_results"}{...}
{viewerjumpto "References" "ucm##references"}{...}
{title:Title}

{p2colset 5 17 25 2}{...}
{p2col :{manlink TS ucm} {hline 2}}Unobserved-components model{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:ucm} {depvar} [{indepvars}]
{ifin}
[{cmd:,} {it:options}]

{synoptset 28 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{synopt :{opth mod:el(ucm##model:model)}}specify trend and idiosyncratic
        components{p_end}
{synopt :{cmdab:sea:sonal(}{it:#}{cmd:)}}include a seasonal component
	with a period of {it:#} time units{p_end}
{synopt :{cmdab:cyc:le(}{it:#} [{cmd:,} {opt f:requency(#f)}]{cmd:)}}include a
        cycle component of order {it:#} and optionally set initial frequency
        to {it:#f}, {bind:0 < {it:#f} < pi}; {opt cycle()} may be specified up
        to three times{p_end}
{synopt :{cmdab:const:raints(}{it:{help estimation options##constraints():constraints}}{cmd:)}}apply specified linear constraints{p_end}
{synopt :{opt col:linear}}keep collinear variables

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim}
	or {opt r:obust}{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help ucm##display_options:display_options}}}control
INCLUDE help shortdes-displayopt

{syntab:Maximization}
{synopt :{it:{help ucm##maximize_options:maximize_options}}}control the
           maximization process{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}

{marker model}{...}
{synoptset 23}{...}
{synopthdr:model}
{synoptline}
{synopt:{opt rwalk}}random-walk model; the default{p_end}
{synopt:{opt none}}no trend or idiosyncratic component{p_end}
{synopt:{opt ntrend}}no trend component but include idiosyncratic component
{p_end}
{synopt:{opt dconstant}}deterministic constant with idiosyncratic component
{p_end}
{synopt:{opt llevel}}local-level model{p_end}
{synopt:{opt dtrend}}deterministic-trend model with idiosyncratic component
{p_end}
{synopt:{opt lldtrend}}local-level model with deterministic trend{p_end}
{synopt:{opt rwdrift}}random-walk-with-drift model{p_end}
{synopt:{opt lltrend}}local-linear-trend model{p_end}
{synopt:{opt strend}}smooth-trend model{p_end}
{synopt:{opt rtrend}}random-trend model{p_end}
{synoptline}

{p 4 6 2}You must {opt tsset} your data before using {opt ucm}; see
{manhelp tsset TS}.{p_end}
{p 4 6 2}{it:indepvars} may contain factor variables; see {help fvvarlist}.
{p_end}
{p 4 6 2}{it:indepvars} and {it:depvar} may contain time-series operators;
      see {help tsvarlist}.{p_end}
{p 4 6 2}{cmd:by}, {cmd:statsby}, and {cmd:rolling} are allowed; see
      {help prefix}.{p_end}
{p 4 6 2}{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}See {manhelp ucm_postestimation TS:ucm postestimation} for
      features available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Time series > Unobserved-components model}


{marker description}{...}
{title:Description}

{pstd}
Unobserved-components models (UCMs) decompose a time series into trend, 
seasonal, cyclical, and idiosyncratic components and allow for exogenous 
variables. {cmd:ucm} estimates the parameters of UCMs by maximum likelihood.

{pstd}
All the components are optional.  The trend component may be first-order
deterministic or it may be first-order or second-order stochastic.  The
seasonal component is stochastic; the seasonal effects at each time period sum
to a zero-mean finite-variance random variable.  The cyclical component is
modeled by the stochastic-cycle model derived by
{help ucm##H1989:Harvey (1989)}.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{cmd:model(}{it:model}{cmd:)} specifies the trend and idiosyncratic components.
The default is {cmd:model(rwalk)}.  The available {it:model}s are listed in
{help ucm##model:{it:Syntax}} above and discussed in detail in
{mansection TS ucmRemarksModelsforthetrendandidiosyncraticcomponents:{it:Models for the trend and idiosyncratic components}}
in {bf:[TS] ucm}.

{phang}
{cmd:seasonal(}{it:#}{cmd:)} adds a stochastic-seasonal component to the model.
{it:#} is the period of the season, that is, the number of time-series
observations required for the period to complete.  

{phang}
{cmd:cycle(}{it:#}{cmd:)} adds a stochastic-cycle component of order {it:#}
to the model.  The order {it:#} must be 1, 2, or 3.  Multiple cycles are added
by repeating the {cmd:cycle(}{it:#}{cmd:)} option with up to three cycles
allowed.

{pmore}
{cmd:cycle(}{it:#}{cmd:,} {cmd:frequency(}{it:#f}{cmd:))} specifies
{it:#f} as the initial value for the central-frequency parameter in the
stochastic-cycle component of order {it:#}.  {it:#f} must be in the interval
(0, pi).

{phang}
{opt constraints(constraints)}, {opt collinear}; see 
{helpb estimation options##constraints():[R] estimation options}.

{dlgtab:SE/Robust}

{phang}
{opt vce(vcetype)} specifies the estimator for the
variance-covariance matrix of the estimator.  

{phang2}
{cmd:vce(oim)}, the default, causes {cmd:ucm} to use the observed
information matrix estimator.

{phang2}
{cmd:vce(robust)} causes {cmd:ucm} to use the Huber/White/sandwich
estimator.

{dlgtab:Reporting}

{phang}
{opt level(#)}, {opt nocnsreport}; see
{helpb estimation options##level():[R] estimation options}.

{marker display_options}{...}
{phang}
{it:display_options}:
{opt noomit:ted},
{opt vsquish},
{opt noempty:cells},
{opt base:levels},
{opt allbase:levels},
{opth cformat(%fmt)},
{opt pformat(%fmt)}, and
{opt sformat(%fmt)};
see {helpb estimation options##display_options:[R] estimation options}.

{marker maximize_options}{...}
{dlgtab:Maximization}

{phang}
{it:maximize_options}:
{opt dif:ficult}, 
{opth tech:nique(maximize##algorithm_spec:algorithm_spec)},
{opt iter:ate(#)},
[{cmd:{ul:no}}]{opt lo:g},
{opt tr:ace}, 
{opt grad:ient},
{opt showstep},
{opt hess:ian}, 
{opt showtol:erance},
{opt tol:erance(#)},
{opt ltol:erance(#)},
{opt nrtol:erance(#)}, and
{opt from(matname)}; 
see {manhelp maximize R} for all options except {opt from()}, and see
below for information on {opt from()}.

{phang2}
{opt from(matname)} specifies initial values for the maximization
process.  {cmd:from(b0)} causes {cmd:ucm} to begin the maximization
algorithm with the values in {cmd:b0}.  {cmd:b0} must be a row vector; the
number of columns must equal the number of parameters in the model; and the
values in {cmd:b0} must be in the same order as the parameters in {cmd:e(b)}.

{pmore}
If you model fails to converge, try using the {cmd:difficult} option.
Also see the
{mansection TS ucmRemarkstechnote:technical note} below example 5 in
{bf:[TS] ucm}.

{pstd}
The following option is available with {cmd:ucm} but is not shown in
the dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse unrate}{p_end}

{pstd}Fit a random-walk model on the civilian unemployment rate{p_end}
{phang2}{cmd:. ucm unrate}{p_end}

{pstd}Add a cycle to the previous model{p_end}
{phang2}{cmd:. ucm unrate, cycle(1)}{p_end}

{pstd}Add a second cycle and provide starting values for the cycle
frequencies{p_end}
{phang2}{cmd:. ucm unrate, cycle(1,frequency(2.9)) cycle(2,frequency(0.9))}
	{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse icsa1}{p_end}

{pstd}Fit a local-level model to the weekly series of new claims for 
job-loss insurance in the United States{p_end}
{phang2}{cmd:. ucm icsa, model(llevel)}{p_end}

    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
Because {cmd:ucm} is estimated using {cmd:sspace}, most of the {cmd:sspace}
saved results appear after {cmd:ucm}.  Not all these results are relevant for
{cmd:ucm}; programmers wishing to treat {cmd:ucm} results as {cmd:sspace}
results should see
{it:{help sspace##saved_results:Saved results}} of {helpb sspace:[TS] sspace}.
See {mansection TS ucmMethodsandformulas:{it:Methods and formulas}} of
{bf:[TS] ucm} for the state-space representation of UCMs, and see
{manlink TS sspace} for more documentation that relates to all the saved
results.

{pstd}
{cmd:ucm} saves the following in {cmd:e()}:

{synoptset 23 tabbed}{...}
{p2col 5 23 27 2: Scalars}{p_end}
{synopt :{cmd:e(N)}}number of observations{p_end}
{synopt :{cmd:e(k)}}number of parameters{p_end}
{synopt :{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt :{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt :{cmd:e(k_dv)}}number of dependent variables{p_end}
{synopt :{cmd:e(k_cycles)}}number of stochastic cycles{p_end}
{synopt :{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt :{cmd:e(ll)}}log likelihood{p_end}
{synopt :{cmd:e(chi2)}}chi-squared{p_end}
{synopt :{cmd:e(p)}}significance{p_end}
{synopt :{cmd:e(tmin)}}minimum time in sample{p_end}
{synopt :{cmd:e(tmax)}}maximum time in sample{p_end}
{synopt :{cmd:e(stationary)}}{cmd:1} if the estimated parameters indicate a stationary model, {cmd:0} otherwise{p_end}
{synopt :{cmd:e(rank)}}rank of VCE{p_end}
{synopt :{cmd:e(ic)}}number of iterations{p_end}
{synopt :{cmd:e(rc)}}return code{p_end}
{synopt :{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{p2col 5 23 27 2:Macros}{p_end}
{synopt :{cmd:e(cmd)}}{opt ucm}{p_end}
{synopt :{cmd:e(cmdline)}}command as typed{p_end}
{synopt :{cmd:e(depvar)}}unoperated names of dependent variables in observation equations{p_end}
{synopt :{cmd:e(covariates)}}list of covariates{p_end}
{synopt :{cmd:e(indeps)}}independent variables{p_end}
{synopt :{cmd:e(tvar)}}variable denoting time within groups{p_end}
{synopt :{cmd:e(eqnames)}}names of equations{p_end}
{synopt:{cmd:e(model)}}type of model{p_end}
{synopt :{cmd:e(title)}}title in estimation output{p_end}
{synopt :{cmd:e(tmins)}}formatted minimum time{p_end}
{synopt :{cmd:e(tmaxs)}}formatted maximum time{p_end}
{synopt :{cmd:e(chi2type)}}{opt Wald}; type of model chi-squared test{p_end}
{synopt :{cmd:e(vce)}}{it:vcetype} specified in {opt vce()}{p_end}
{synopt :{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt :{cmd:e(opt)}}type of optimization{p_end}
{synopt :{cmd:e(initial_values)}}type of initial values{p_end}
{synopt :{cmd:e(technique)}}maximization technique{p_end}
{synopt :{cmd:e(tech_steps)}}iterations taken in maximization technique{p_end}
{synopt :{cmd:e(properties)}}{opt b V}{p_end}
{synopt :{cmd:e(estat_cmd)}}program used to implement {opt estat}{p_end}
{synopt :{cmd:e(predict)}}program used to implement {opt predict}{p_end}
{synopt :{cmd:e(marginsok)}}predictions allowed by {opt margins}{p_end}
{synopt :{cmd:e(marginsnotok)}}predictions disallowed by {opt margins}{p_end}

{p2col 5 23 27 2:Matrices}{p_end}
{synopt :{cmd:e(b)}}parameter vector{p_end}
{synopt :{cmd:e(Cns)}}constraints matrix{p_end}
{synopt :{cmd:e(ilog)}}iteration log (up to 20 iterations){p_end}
{synopt :{cmd:e(gradient)}}gradient vector{p_end}
{synopt :{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt :{cmd:e(V_modelbased)}}model-based variance{p_end}

{p2col 5 23 27 2:Functions}{p_end}
{synopt :{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker D1988}{...}
{phang}
De Jong, P.  1988.  The likelihood for a state space model.
{it:Biometrika} 75: 165-169.

{marker D1991}{...}
{phang}
------.  1991.  The diffuse Kalman filter.
{it:Annals of Statistics} 19: 1073-1083.

{marker H1989}{...}
{phang}
Harvey, A. C. 1989.
{it:Forecasting, Structural Time Series Models and the Kalman Filter}.
Cambridge: Cambridge University Press.
{p_end}

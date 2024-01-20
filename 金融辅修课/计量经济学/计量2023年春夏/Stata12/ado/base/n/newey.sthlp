{smcl}
{* *! version 1.1.11  03may2011}{...}
{viewerdialog newey "dialog newey"}{...}
{vieweralsosee "[TS] newey" "mansection TS newey"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] newey postestimation" "help newey postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] arima" "help arima"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[TS] tsset" "help tsset"}{...}
{viewerjumpto "Syntax" "newey##syntax"}{...}
{viewerjumpto "Description" "newey##description"}{...}
{viewerjumpto "Options" "newey##options"}{...}
{viewerjumpto "Examples" "newey##examples"}{...}
{viewerjumpto "Saved results" "newey##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col:{manlink TS newey} {hline 2}}Regression with Newey-West standard errors
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:newey}
{depvar}
[{indepvars}]
{ifin}
{weight}
{cmd:,}
{opt lag(#)}
[{it:options}]

{synoptset 18 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{p2coldent:* {opt lag(#)}}set maximum lag order of autocorrelation{p_end}
{synopt:{opt nocon:stant}}suppress constant term{p_end}

{syntab:Reporting}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{it:{help newey##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt lag(#)} is required.
{p_end}
{p 4 6 2}
You must {cmd:tsset} your data before using {opt newey}; see
{helpb tsset:[TS] tsset}.{p_end}
INCLUDE help fvvarlist
{p 4 6 2}
{it:depvar} and {it:indepvars} may contain time-series operators; see
{help tsvarlist}.{p_end}
{p 4 6 2}
{opt by}, {opt rolling}, and {opt statsby} are allowed; see
{help prefix}.
{p_end}
{p 4 6 2}{opt aweight}s are allowed; see {help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp newey_postestimation TS:newey postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Time series > Regression with Newey-West std. errors}


{marker description}{...}
{title:Description}

{pstd}
{opt newey} produces Newey-West standard errors for coefficients estimated
by OLS regression.  The error structure is assumed to be heteroskedastic and
possibly autocorrelated up to some lag.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt lag(#)} specifies the maximum lag to be considered in the autocorrelation
   structure.  If you specify {cmd:lag(0)}, the output is the same as
   {cmd:regress}{cmd:, vce(robust)}.  {opt lag()} is required.

{phang}
{opt noconstant}; see
{bf:{help estimation options##noconstant:[R] estimation options}}.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see 
{bf:{help estimation options##level():[R] estimation options}}.

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

{pstd}
The following option is available with {opt newey} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse idle2}{p_end}
{phang2}{cmd:. tsset time}

{pstd}Regression with Newey-West standard errors with 3 as maximum lag order
of autocorrelation{p_end}
{phang2}{cmd:. newey usr idle, lag(3)}

{pstd}Replay results with 99% confidence interval{p_end}
{phang2}{cmd:. newey, level(99)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:newey} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(F)}}F statistic{p_end}
{synopt:{cmd:e(lag)}}maximum lag{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:newey}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(estat_cmd)}}program used to implement {cmd:estat}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(Cns)}}constraints matrix{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

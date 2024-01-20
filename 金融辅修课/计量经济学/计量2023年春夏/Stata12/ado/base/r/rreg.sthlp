{smcl}
{* *! version 1.1.13  03may2011}{...}
{viewerdialog rreg "dialog rreg"}{...}
{vieweralsosee "[R] rreg" "mansection R rreg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] rreg postestimation" "help rreg postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] qreg" "help qreg"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{viewerjumpto "Syntax" "rreg##syntax"}{...}
{viewerjumpto "Description" "rreg##description"}{...}
{viewerjumpto "Options" "rreg##options"}{...}
{viewerjumpto "Examples" "rreg##examples"}{...}
{viewerjumpto "Saved results" "rreg##saved_results"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink R rreg} {hline 2}}Robust regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:rreg} {depvar} [{indepvars}] {ifin} 
[{cmd:,} {it:options}] 

{synoptset 22 tabbed}{...}
{synopthdr:options}
{synoptline}
{syntab:Model}
{synopt :{opt tu:ne(#)}}use {it:#} as the biweight tuning constant; default is
{cmd:tune(7)}{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}
{p_end}
{synopt :{opth g:enwt(newvar)}}create {it:newvar} containing the weights assigned
to each observation{p_end}
{synopt :{it:{help rreg##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Optimization}
{synopt :{it:{help rreg##optimize_options:optimization_options}}}control the optimization process; seldom used{p_end}
{synopt :{opt g:raph}}graph weights during convergence{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}{it:depvar} and {it:indepvars} may contain time-series operators; see 
{help tsvarlist}.{p_end}
{p 4 6 2}{cmd:by}, {opt fracpoly}, {opt mfp}, {cmd:mi estimate}, {cmd:rolling},
and {cmd:statsby} are allowed; see {help prefix}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}See {manhelp rreg_postestimation R:rreg postestimation} for features
available after estimation.


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Other > Robust regression}


{marker description}{...}
{title:Description}

{pstd}
{opt rreg} performs one version of robust regression of {depvar} on
{indepvars}.

{pstd}
Also see {it:{mansection R regressRemarksRobuststandarderrors:Robust standard errors}} in {bf:[R] regress} for standard regression with robust variance
estimates and {manlink R qreg} for quantile (including median or
least-absolute-residual) regression.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt tune(#)} is the biweight tuning constant.  The default is 7, meaning 
seven times the median absolute deviation from the median residual; see
{mansection R rregMethodsandformulas:{it:Methods and formulas}} in 
{bf:[R] rreg}.  Lower tuning constants downweight outliers rapidly but may lead
to unstable estimates (less than 6 is not recommended).  Higher tuning
constants produce milder downweighting.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}. 

{phang}
{opth genwt(newvar)} creates the new variable {it:newvar} containing the
weights assigned to each observation.

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

{marker optimize_options}{...}
{dlgtab:Optimization}

{phang}
{it:optimization_options}: 
{opt iter:ate(#)}, {opt tol:erance(#)}, [{cmd:{ul:no}}]{cmd:{ul:lo}}{cmd:g}.
{opt iterate()} specifies the maximum number of iterations; iterations stop
when the maximum change in weights drops below {opt tolerance()}; and
{opt log}/{opt nolog} specifies whether to show the iteration log.
These options are seldom used.

{phang}
{opt graph} allows you to graphically watch the convergence of the
iterative technique.  The weights obtained from the most recent round of
estimation are graphed against weights obtained from the previous round.

{pstd}
The following option is available with {opt rreg} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Robust regression{p_end}
{phang2}{cmd:. rreg mpg foreign#c.weight foreign}

{pstd}Same as above, but save estimated weights in {cmd:genwt(w)}{p_end}
{phang2}{cmd:. rreg mpg foreign#c.weight foreign, genwt(w)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:rreg} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(mss)}}model sum of squares{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(rss)}}residual sum of squares{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(r2)}}R-squared{p_end}
{synopt:{cmd:e(r2_a)}}adjusted R-squared{p_end}
{synopt:{cmd:e(F)}}F statistic{p_end}
{synopt:{cmd:e(rmse)}}root mean squared error{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:rreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(genwt)}}variable containing the weights{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(model)}}{cmd:ols}{p_end}
{synopt:{cmd:e(vce)}}{cmd:ols}{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsok)}}predictions allowed by {cmd:margins}{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

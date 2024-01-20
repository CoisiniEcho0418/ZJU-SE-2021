{smcl}
{* *! version 1.1.12  03may2011}{...}
{viewerdialog eivreg "dialog eivreg"}{...}
{vieweralsosee "[R] eivreg" "mansection R eivreg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] eivreg postestimation" "help eivreg_postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[SEM] sem" "help sem"}{...}
{viewerjumpto "Syntax" "eivreg##syntax"}{...}
{viewerjumpto "Description" "eivreg##description"}{...}
{viewerjumpto "Options" "eivreg##options"}{...}
{viewerjumpto "Example" "eivreg##example"}{...}
{viewerjumpto "Saved results" "eivreg##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink R eivreg} {hline 2}}Errors-in-variables regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:eivreg}
{depvar}
[{indepvars}]
{ifin}
{weight}
[{cmd:,} {it:options}]

{synoptset 22 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{synopt:{cmdab:r:eliab(}{it:{help varlist:indepvar}} {it:#} [{it:indepvar # }[...]]{cmd:)}}{p_end}
{synopt: }specify measurement reliability for each {it:indepvar} measured with error{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt:{it:{help eivreg##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
INCLUDE help fvvarlist
{p 4 6 2}
{opt bootstrap}, {opt by}, {opt jackknife}, {opt rolling}, and {opt statsby}
are allowed; see {help prefix}.{p_end}
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{cmd:aweight}s are not allowed with the {helpb jackknife} prefix.
{p_end}
{p 4 6 2}
{cmd:aweight}s and {cmd:fweight}s are allowed; see {help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp eivreg_postestimation R:eivreg postestimation} for features
available after estimation.


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Errors-in-variables regression}


{marker description}{...}
{title:Description}

{pstd}
{cmd:eivreg} fits errors-in-variables regression models.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{cmd:reliab(}{it:{help varlist:indepvar}} {it:#} [{it:indepvar # }[...]]{cmd:)}
specifies the measurement reliability for each independent variable
measured with error.  
Reliabilities are specified as pairs consisting of an independent
variable name (a name that appears in {it:indepvars})
and the corresponding reliability r, 0 < r {ul:<} 1.
Independent variables for
which no reliability is specified are assumed to have reliability 1.
If the option is not specified, all variables are assumed to have reliability
1, and the result is thus the same as that produced by {cmd:regress}
(the ordinary least-squares results).

{dlgtab:Reporting}

{phang}
{opt level(#)}; see 
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
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.

{pstd}
The following option is available with {opt eivreg} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Fit regression in which {cmd:weight} and {cmd:mpg} are measured with
reliabilities 0.85 and 0.9, respectively{p_end}
{phang2}{cmd:. eivreg price weight foreign mpg, r(weight .85 mpg .9)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:eivreg} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(r2)}}R-squared{p_end}
{synopt:{cmd:e(F)}}F statistic{p_end}
{synopt:{cmd:e(rmse)}}root mean squared error{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:eivreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(rellist)}}{it:indepvars} and associated reliabilities{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
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

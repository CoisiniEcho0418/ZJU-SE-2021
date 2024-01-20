{smcl}
{* *! version 1.1.16  18may2011}{...}
{viewerdialog tobit "dialog tobit"}{...}
{viewerdialog "svy: tobit" "dialog tobit, message(-svy-) name(svy_tobit)"}{...}
{vieweralsosee "[R] tobit" "mansection R tobit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] tobit postestimation" "help tobit postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] heckman" "help heckman"}{...}
{vieweralsosee "[R] intreg" "help intreg"}{...}
{vieweralsosee "[R] ivtobit" "help ivtobit"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[SVY] svy estimation" "help svy estimation"}{...}
{vieweralsosee "[R] truncreg" "help truncreg"}{...}
{vieweralsosee "[XT] xtintreg" "help xtintreg"}{...}
{vieweralsosee "[XT] xttobit" "help xttobit"}{...}
{viewerjumpto "Syntax" "tobit##syntax"}{...}
{viewerjumpto "Description" "tobit##description"}{...}
{viewerjumpto "Options" "tobit##options"}{...}
{viewerjumpto "Examples" "tobit##examples"}{...}
{viewerjumpto "Saved results" "tobit##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{manlink R tobit} {hline 2}}Tobit regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmdab:tob:it}
{depvar} [{indepvars}]
{ifin}
{weight}
{cmd:,}
{opt ll}[{opt (#)}]
{opt ul}[{opt (#)}]
[{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{synopt :{opt nocon:stant}}suppress constant term{p_end}
{p2coldent:* {opt ll}[{opt (#)}]}left-censoring limit{p_end}
{p2coldent:* {opt ul}[{opt (#)}]}right-censoring limit{p_end}
{synopt:{opth off:set(varname)}}include {it:varname} in model with coefficient
constrained to 1{p_end}

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim},
  {opt r:obust}, {opt cl:uster} {it:clustvar}, {opt boot:strap}, or
  {opt jack:knife}{p_end}

{syntab:Reporting}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{it:{help tobit##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Maximization}
{synopt:{it:{help tobit##maximize_options:maximize_options}}}control the
maximization process; seldom used{p_end}

INCLUDE help shortdes-coeflegend
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* You must specify at least one of {opt ll}[{opt (#)}] or {opt ul}[{opt (#)}].
{p_end}
INCLUDE help fvvarlist
{p 4 6 2}{it:depvar} and {it:indepvars} may
contain time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}
{opt bootstrap}, {opt by}, {opt jackknife}, {opt nestreg},
{opt rolling}, {opt statsby}, {opt stepwise}, and {opt svy}
are allowed; see {help prefix}.
{p_end}
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{cmd:aweight}s are not allowed with the {helpb jackknife} prefix.
{p_end}
{p 4 6 2}
{opt vce()} and weights are not allowed with the {helpb svy} prefix.
{p_end}
{p 4 6 2}
{opt aweight}s, {opt fweight}s, {opt pweight}s, and {opt iweight}s
are allowed; see {help weight}.{p_end}
{p 4 6 2}
{opt coeflegend} does not appear in the dialog box.{p_end}
{p 4 6 2}
See {manhelp tobit_postestimation R:tobit postestimation} for features
available after estimation.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Censored regression >}
      {bf:Tobit regression}


{marker description}{...}
{title:Description}

{pstd}
{opt tobit} fits a model of {depvar} on {indepvars} where the censoring values
are fixed.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant}; see
{helpb estimation options##noconstant:[R] estimation options}. 

{phang}
{opt ll}[{opt (#)}] and {opt ul}[{opt (#)}]
   indicate the lower and upper limits for censoring, respectively.
   You may specify one or both.  Observations with
   {depvar} <= {opt ll()} are left-censored; observations with {it:depvar}
   >= {opt ul()} are right-censored; and remaining observations are not censored.
   You do not have to specify the censoring value at all.  It is enough to
   type {opt ll}, {opt ul}, or both.  When you do not specify a censoring
   value, {opt tobit} assumes that the lower limit is the minimum observed in
   the data (if {opt ll} is specified) and the upper limit is the maximum (if
   {opt ul} is specified) .

{phang}
{opth offset(varname)}; see
{helpb estimation options##offset():[R] estimation options}.

{dlgtab:SE/Robust}

INCLUDE help vce_asymptall

{dlgtab:Reporting}

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}.

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
{opt iter:ate(#)},
[{cmdab:no:}]{opt lo:g},
{opt tr:ace},
{opt tol:erance(#)},
{opt ltol:erance(#)},
{opt nrtol:erance(#)}, and
{opt nonrtol:erance};
see {manhelp maximize R}.  These options are seldom used.

{pmore}
   Unlike most maximum likelihood commands, {opt tobit} defaults to
   {opt nolog} -- it suppresses the iteration log.

{pstd}
The following option is available with {opt tobit} but is not shown in the
dialog box:

{phang}
{opt coeflegend}; see
     {helpb estimation options##coeflegend:[R] estimation options}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. generate wgt=weight/1000}{p_end}

{pstd}Censored from below{p_end}
{phang2}{cmd:. tobit mpg wgt, ll(17)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto, clear}{p_end}
{phang2}{cmd:. generate wgt=weight/100}{p_end}

{pstd}Censored from above{p_end}
{phang2}{cmd:. tobit mpg wgt, ul(24)}

{pstd}Clustered on foreign{p_end}
{phang2}{cmd:. tobit mpg wgt, ul(24) vce(cluster foreign)}

{pstd}Two-limit tobit{p_end}
{phang2}{cmd:. tobit mpg wgt, ll(17) ul(24)}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:tobit} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_unc)}}number of uncensored observations{p_end}
{synopt:{cmd:e(N_lc)}}number of left-censored observations{p_end}
{synopt:{cmd:e(N_rc)}}number of right-censored observations{p_end}
{synopt:{cmd:e(llopt)}}contents of {cmd:ll()}, if specified{p_end}
{synopt:{cmd:e(ulopt)}}contents of {cmd:ul()}, if specified{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(r2_p)}}pseudo-R-squared{p_end}
{synopt:{cmd:e(chi2)}}chi-squared{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}

{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(F)}}F statistic{p_end}
{synopt:{cmd:e(p)}}significance{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:tobit}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(clustvar)}}name of cluster variable{p_end}
{synopt:{cmd:e(offset)}}linear offset variable{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:LR}; type of model chi-squared test{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(footnote)}}program and arguments to display footnote{p_end}
{synopt:{cmd:e(asbalanced)}}factor variables {cmd:fvset} as {cmd:asbalanced}{p_end}
{synopt:{cmd:e(asobserved)}}factor variables {cmd:fvset} as {cmd:asobserved}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

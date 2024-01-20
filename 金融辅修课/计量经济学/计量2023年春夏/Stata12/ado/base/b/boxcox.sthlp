{smcl}
{* *! version 1.1.7  11feb2011}{...}
{viewerdialog boxcox "dialog boxcox"}{...}
{vieweralsosee "[R] boxcox" "mansection R boxcox"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] boxcox postestimation" "help boxcox postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] lnskew0" "help lnskew0"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{viewerjumpto "Syntax" "boxcox##syntax"}{...}
{viewerjumpto "Description" "boxcox##description"}{...}
{viewerjumpto "Options" "boxcox##options"}{...}
{viewerjumpto "Examples" "boxcox##examples"}{...}
{viewerjumpto "Saved results" "boxcox##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink R boxcox} {hline 2}}Box-Cox regression models{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:boxcox} {depvar} [{indepvars}] {ifin} {weight} [{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Model}
{synopt :{opt noc:onstant}}suppress constant term{p_end}
{synopt :{opt model}{cmd:(}{opt lhs:only}{cmd:)}}left-hand-side Box-Cox model; the default{p_end}
{synopt :{opt model}{cmd:(}{opt rhs:only}{cmd:)}}right-hand-side Box-Cox model{p_end}
{synopt :{opt model}{cmd:(}{opt lam:bda}{cmd:)}}both sides Box-Cox model with same parameter{p_end}
{synopt :{opt model}{cmd:(}{opt theta}{cmd:)}}both sides Box-Cox model with different parameters{p_end}
{synopt :{opth notr:ans(varlist)}}nontransformed independent variables{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt lrtest}}perform likelihood-ratio test{p_end}

{syntab:Maximization}
{synopt :{opt nolo:g}}suppress full-model iteration log{p_end}
{synopt :{opt nologlr}}suppress restricted-model {opt lrtest} iteration
log{p_end}
{synopt :{it:{help boxcox##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{it:depvar} and {it:indepvars} may contain time-series operators; see
{help tsvarlist}.{p_end}
{p 4 6 2}{cmd:bootstrap}, {cmd:by}, {cmd:jackknife}, {cmd:rolling}, 
{cmd:statsby}, and {cmd:xi} are allowed; see {help prefix}.{p_end}
{p 4 6 2}Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}{opt fweight}s and {opt iweight}s are allowed; see {help weight}.{p_end}
{p 4 6 2}See {manhelp boxcox_postestimation R:boxcox postestimation} for
features available after estimation.


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > Box-Cox regression}


{marker description}{...}
{title:Description}

{pstd}
{cmd:boxcox} finds the maximum likelihood estimates of the parameters of the
Box-Cox transform, the coefficients on the independent variables, and the
standard deviation of the normally distributed errors for a model in which
{depvar} is regressed on {indepvars}.  Any variable to be transformed must be
strictly positive.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{opt noconstant}; see
{helpb estimation options##noconstant:[R] estimation options}.

{phang}
{opt model}{cmd:(}{opt lhsonly}|{opt rhsonly}|{opt lambda}|{opt theta}{cmd:)}
specifies which of the four models to fit.

{pmore}
{cmd:model(lhsonly)} applies the Box-Cox transform to {depvar} only.
{cmd:model(lhsonly)} is the default.

{pmore}
{cmd:model(rhsonly)} applies the transform to the {indepvars} only.

{pmore}
{cmd:model(lambda)} applies the transform to both {it:depvar} and
{it:indepvars}, and they are transformed by the same parameter.

{pmore}
{cmd:model(theta)} applies the transform to both {it:depvar} and
{it:indepvars}, but this time, each side is transformed by a separate
parameter.

{marker notrans()}{...}
{phang}
{opth notrans(varlist)} specifies that the variables in {it:varlist} be
included as nontransformed independent variables.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt lrtest} specifies that a likelihood-ratio test of significance be
performed and reported for each independent variable.

{marker maximize_options}{...}
{dlgtab:Maximization}

{phang}
{opt nolog} suppresses the iteration log when fitting the full model.

{phang}
{opt nologlr} suppresses the iteration log when fitting the restricted models
required by the {opt lrtest} option.

{phang}
{it: maximize_options}: {opt iter:ate(#)} and {opt from(init_specs)};
see {manhelp maximize R}.

            Model{col 25}Initial value specification
            {hline 39}
            {opt lhsonly}{col 25}{cmd:from(}{it:#_t}{cmd:, copy)}
            {opt rhsonly}{col 25}{cmd:from(}{it:#_l}{cmd:, copy)}
            {opt lambda}{col 25}{cmd:from(}{it:#_l}{cmd:, copy)}
            {opt theta}{col 25}{cmd:from(}{it:#_l #_t}{cmd:, copy)}
            {hline 39}


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Apply Box-Cox transform to {cmd:mpg}{p_end}
{phang2}{cmd:. boxcox mpg weight price}{p_end}

{pstd}Same as above, but include {cmd:foreign} as a nontransformed independent
variable{p_end}
{phang2}{cmd:. boxcox mpg weight price, notrans(foreign)}{p_end}

{pstd}Apply Box-Cox transform to {cmd:weight} and {cmd:price}{p_end}
{phang2}{cmd:. boxcox mpg weight price, model(rhsonly)}{p_end}

{pstd}Use the same parameter to transform {cmd:mpg}, {cmd:weight}, and
{cmd:price}{p_end}
{phang2}{cmd:. boxcox mpg weight price, model(lambda)}

{pstd}Use a different parameter to transform {cmd:mpg} than that used to
transform {cmd:weight} and {cmd:price}{p_end}
{phang2}{cmd:. boxcox mpg weight price, model(theta)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:boxcox} saves the following in {cmd:e()}:

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(chi2)}}LR statistic of full vs. comparison{p_end}
{synopt:{cmd:e(df_m)}}full model degrees of freedom{p_end}
{synopt:{cmd:e(ll0)}}log likelihood of the restricted model{p_end}
{synopt:{cmd:e(df_r)}}restricted model degrees of freedom{p_end}
{synopt:{cmd:e(ll_t1)}}log likelihood of model lambda = theta = 1{p_end}
{synopt:{cmd:e(chi2_t1)}}LR of lambda = theta = 1 vs. full model{p_end}
{synopt:{cmd:e(p_t1)}}p-value of lambda = theta = 1 vs. full model{p_end}
{synopt:{cmd:e(ll_tm1)}}log likelihood of model lambda = theta = -1{p_end}
{synopt:{cmd:e(chi2_tm1)}}LR of lambda = theta = -1 vs. full model{p_end}
{synopt:{cmd:e(p_tm1)}}p-value of lambda = theta = -1 vs. full model{p_end}
{synopt:{cmd:e(ll_t0)}}log likelihood of model lambda = theta = 0{p_end}
{synopt:{cmd:e(chi2_t0)}}LR of lambda = theta = 0 vs. full model{p_end}
{synopt:{cmd:e(p_t0)}}p-value of lambda = theta = 0 vs. full model{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(rc)}}return code{p_end}

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:boxcox}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(model)}}{cmd:lhsonly}, {cmd:rhsonly}, {cmd:lambda}, or
{cmd:theta}{p_end}
{synopt:{cmd:e(wtype)}}weight type{p_end}
{synopt:{cmd:e(wexp)}}weight expression{p_end}
{synopt:{cmd:e(ntrans)}}yes if nontransformed {it:indepvars}{p_end}
{synopt:{cmd:e(chi2type)}}{cmd:LR}; type of model chi-squared test{p_end}
{synopt:{cmd:e(lrtest)}}{cmd:lrtest}, if requested{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators (see note
below){p_end}
{synopt:{cmd:e(pm)}}p-values for LR tests on {it:indepvars}{p_end}
{synopt:{cmd:e(df)}}degrees of freedom of LR tests on {it:indepvars}{p_end}
{synopt:{cmd:e(chi2m)}}LR statistics for tests on {it:indepvars}{p_end}

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}

{pstd}
{cmd:e(V)} contains all zeros, except for the elements that
correspond to the parameters of the Box-Cox transform.{p_end}
{p2colreset}{...}

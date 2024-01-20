{smcl}
{* *! version 1.1.11  03may2011}{...}
{viewerdialog qreg "dialog qreg"}{...}
{viewerdialog iqreg "dialog iqreg"}{...}
{viewerdialog sqreg "dialog sqreg"}{...}
{viewerdialog bsqreg "dialog bsqreg"}{...}
{vieweralsosee "[R] qreg" "mansection R qreg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] qreg postestimation" "help qreg postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bootstrap" "help bootstrap"}{...}
{vieweralsosee "[MI] estimation" "help mi estimation"}{...}
{vieweralsosee "[R] regress" "help regress"}{...}
{vieweralsosee "[R] rreg" "help rreg"}{...}
{viewerjumpto "Syntax" "qreg##syntax"}{...}
{viewerjumpto "Description" "qreg##description"}{...}
{viewerjumpto "Options for qreg" "qreg##options_qreg"}{...}
{viewerjumpto "Options for iqreg" "qreg##options_iqreg"}{...}
{viewerjumpto "Options for sqreg" "qreg##options_sqreg"}{...}
{viewerjumpto "Options for bsqreg" "qreg##options_bsqreg"}{...}
{viewerjumpto "Options for _qreg" "qreg##options__qreg"}{...}
{viewerjumpto "Examples" "qreg##examples"}{...}
{viewerjumpto "Saved results" "qreg##saved_results"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink R qreg} {hline 2}}Quantile regression{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Quantile regression

{p 8 13 2}
{cmd:qreg} {depvar} [{indepvars}] {ifin} {weight}
	[{cmd:,} {it:{help qreg##qreg_options:qreg_options}}]


{phang}
Interquantile range regression

{p 8 14 2}
{cmd:iqreg} {depvar} [{indepvars}] {ifin}
	[{cmd:,} {it:{help qreg##iqreg_options:iqreg_options}}]


{phang}
Simultaneous-quantile regression

{p 8 14 2}
{cmd:sqreg} {depvar} [{indepvars}] {ifin}
	[{cmd:,} {it:{help qreg##sqreg_options:sqreg_options}}]


{phang}
Bootstrapped quantile regression

{p 8 15 2}
{cmd:bsqreg} {depvar} [{indepvars}] {ifin}
	[{cmd:,} {it:{help qreg##bsqreg_options:bsqreg_options}}]


{phang}
Internal estimation command for quantile regression

{p 8 14 2}{cmd:_qreg} [{depvar} [{indepvars}] {ifin} {weight}]
	[{cmd:,} {it:{help qreg##_qreg_options:_qreg_options}}]


{synoptset 25 tabbed}{...}
{marker qreg_options}{...}
{synopthdr :qreg_options}
{synoptline}
{syntab :Model}
{synopt :{opt q:uantile(#)}}estimate {it:#} quantile; default is {cmd:quantile(.5)}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{it:{help qreg##qreg_display_options:display_options}}}control column
        formats and line width{p_end}

{syntab :Optimization}
{synopt :{it:{help qreg##qreg_optimize:optimization_options}}}control the
optimization process; seldom used{p_end}
{synopt :{opt wls:iter(#)}}attempt {it:#} weighted least-squares iterations before doing linear programming iterations{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 25 tabbed}{...}
{marker iqreg_options}{...}
{synopthdr :iqreg_options}
{synoptline}
{syntab :Model}
{synopt :{opt q:uantiles(# #)}}interquantile range; default is {bind:{cmd:quantiles(.25 .75)}}{p_end}
{synopt :{opt r:eps(#)}}perform {it:#} bootstrap replications; default is {cmd:reps(20)}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt nod:ots}}suppress display of the replication dots{p_end}
{synopt :{it:{help qreg##iqreg_display_options:display_options}}}control column
        formats and line width{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 25 tabbed}{...}
{marker sqreg_options}{...}
{synopthdr :sqreg_options}
{synoptline}
{syntab :Model}
{synopt :{cmdab:q:uantiles(}{it:#}[{it:#}[{it:# ...}]]{cmd:)}}estimate {it:#} quantiles; default is {cmd:quantiles(.5)}{p_end}
{synopt :{opt r:eps(#)}}perform {it:#} bootstrap replications; default is {cmd:reps(20)}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt nod:ots}}suppress display of the replication dots{p_end}
{synopt :{it:{help qreg##sqreg_display_options:display_options}}}control column
        formats and line width{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 25 tabbed}{...}
{marker bsqreg_options}{...}
{synopthdr :bsqreg_options}
{synoptline}
{syntab :Model}
{synopt :{opt q:uantile(#)}}estimate {it:#} quantile; default is {cmd:quantile(.5)}{p_end}
{synopt :{opt r:eps(#)}}perform {it:#} bootstrap replications; default is {cmd:reps(20)}{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{it:{help qreg##bsqreg_display_options:display_options}}}control column
        formats and line width{p_end}
{synoptline}
{p2colreset}{...}

{synoptset 25}{...}
{marker _qreg_options}{...}
{synopthdr :_qreg_options}
{synoptline}
{synopt :{opt qu:antile(#)}}estimate {it:#} quantile; default is {cmd:quantile(.5)}{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt ac:curacy(#)}}relative accuracy required for linear programming algorithm; should not be specified{p_end}
{synopt :{it:{help qreg##_qreg_optimize:optimization_options}}}control the optimization process; seldom used{p_end}
{synoptline}
{p2colreset}{...}

{phang}{cmd:by}, {cmd:mi estimate}, {cmd:rolling}, {cmd:statsby}, and {cmd:xi}
are allowed with {cmd:qreg}, {cmd:iqreg}, {cmd:sqreg}, and {cmd:bsqreg};
{opt fracpoly}, {opt mfp}, {cmd:nestreg}, and
{cmd:stepwise} are allowed with {cmd:qreg}; see {help prefix}.{p_end}
{phang}{cmd:qreg} and {cmd:_qreg} allow {cmd:aweight}s and {cmd:fweight}s; see {help weight}.{p_end}
{phang}See {manhelp qreg_postestimation R:qreg postestimation} for features
available after estimation.


{title:Menu}

    {title:qreg}

{phang2}
{bf:Statistics > Nonparametric analysis > Quantile regression}

    {title:iqreg}

{phang2}
{bf:Statistics > Nonparametric analysis > Interquantile regression}

    {title:sqreg}

{phang2}
{bf:Statistics > Nonparametric analysis > Simultaneous-quantile regression}

    {title:bsqreg}

{phang2}
{bf:Statistics > Nonparametric analysis > Bootstrapped quantile regression}


{marker description}{...}
{title:Description}

{pstd}
{cmd:qreg} fits quantile (including median) regression models, also known as
least-absolute-value models (LAV or MAD) and minimum L1-norm models.

{pstd}
{cmd:iqreg} estimates interquantile range regressions, regressions of the
difference in quantiles.  The estimated variance-covariance matrix of the
estimators (VCE) is obtained via bootstrapping.

{pstd}
{cmd:sqreg} estimates simultaneous-quantile regression.  It produces the same
coefficients as {cmd:qreg} for each quantile.  Reported standard errors will
be similar, but {cmd:sqreg} obtains an estimate of the VCE via bootstrapping,
and the VCE includes between-quantile blocks.  Thus you can test and construct
confidence intervals comparing coefficients describing different quantiles.

{pstd}
{cmd:bsqreg} is equivalent to {cmd:sqreg} with one quantile.

{pstd}
{cmd:_qreg} is the internal estimation command for quantile regression.
{cmd:_qreg} is not intended to be used directly; see 
{mansection R qregMethodsandformulas:{it:Methods and formulas}} in
{bind:{bf:[R] qreg}}.


{marker options_qreg}{...}
{title:Options for qreg}

{dlgtab:Model}

{phang}{opt quantile(#)} specifies the quantile to be estimated and should be
a number between 0 and 1, exclusive.  Numbers larger than 1 are interpreted as
percentages.  The default value of 0.5 corresponds to the median.

{dlgtab:Reporting}

{phang}{opt level(#)}; see 
{helpb estimation options##level():[R] estimation options}.

{marker qreg_display_options}{...}
{phang}
{it:display_options}:
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.

{marker qreg_optimize}{...}
{dlgtab:Optimization}

{phang}{it:optimization_options}: {opt iter:ate(#)}, [{cmdab:no:}]{opt lo:g}, 
{opt tr:ace}.  {opt iterate()} specifies the maximum number of iterations;
{opt log}/{opt nolog} specifies whether to show the iteration log; and
{opt trace} specifies that the iteration log should include the current
parameter vector.  These options are seldom used.

{phang}{opt wlsiter(#)} specifies the number of weighted least-squares
iterations that will be attempted before the linear programming iterations are
started.  The default value is 1.  If there are convergence 
problems, increasing this number should help.


{marker options_iqreg}{...}
{title:Options for iqreg}

{dlgtab:Model}

{phang}{opt quantiles(# #)} specifies the quantiles to be compared.  The first
number must be less than the second, and both should be between 0 and 1,
exclusive.  Numbers larger than 1 are interpreted as percentages.  Not
specifying this option is equivalent to specifying 
{bind:{cmd:quantiles(.25 .75)}}, meaning the interquartile range.

{phang}{opt reps(#)} specifies the number of bootstrap replications to be used
to obtain an estimate of the variance-covariance matrix of the estimators
(standard errors).  {cmd:reps(20)} is the default and is arguably too small.
{cmd:reps(100)} would perform 100 bootstrap replications.  {cmd:reps(1000)}
would perform 1,000 replications.

{dlgtab:Reporting}

{phang}{opt level(#)}; see 
{helpb estimation options##level():[R] estimation options}.

{phang}{opt nodots} suppresses display of the replication dots.

{marker iqreg_display_options}{...}
{phang}
{it:display_options}:
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.


{marker options_sqreg}{...}
{title:Options for sqreg}

{dlgtab:Model}

{phang}{cmd:quantiles(}{it:#} [{it:#} [{it:#} {it:...}]]{cmd:)} specifies the
quantiles to be estimated and should contain numbers between 0 and 1,
exclusive.  Numbers larger than 1 are interpreted as percentages.  The default
value of 0.5 corresponds to the median.

{phang}{opt reps(#)} specifies the number of bootstrap replications to be used
to obtain an estimate of the variance-covariance matrix of the estimators
(standard errors).  {cmd:reps(20)} is the default and is arguably too small.
{cmd:reps(100)} would perform 100 bootstrap replications.  {cmd:reps(1000)}
would perform 1,000 replications.

{dlgtab:Reporting}

{phang}{opt level(#)}; see 
{helpb estimation options##level():[R] estimation options}.

{phang}{opt nodots} suppresses display of the replication dots.

{marker sqreg_display_options}{...}
{phang}
{it:display_options}:
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.


{marker options_bsqreg}{...}
{title:Options for bsqreg}

{dlgtab:Model}

{phang}{opt quantile(#)} specifies the quantile to be estimated and should be
a number between 0 and 1, exclusive.  Numbers larger than 1 are interpreted as
percentages.  The default value of 0.5 corresponds to the median.

{phang}{opt reps(#)} specifies the number of bootstrap replications to be used
to obtain an estimate of the variance-covariance matrix of the estimators
(standard errors).  {cmd:reps(20)} is the default and is arguably too small.
{cmd:reps(100)} would perform 100 bootstrap replications.  {cmd:reps(1000)}
would perform 1,000 replications.

{dlgtab:Reporting}

{phang}{opt level(#)}; 
{helpb estimation options##level():[R] estimation options}.

{marker bsqreg_display_options}{...}
{phang}
{it:display_options}:
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.


{marker options__qreg}{...}
{marker _qreg_optimize}{...}
{title:Options for} {bf:_qreg}

{phang}{opt quantile(#)} specifies the quantile to be estimated and should be
a number between 0 and 1, exclusive.
The default value of 0.5 corresponds to the median.

{phang}{opt level(#)}; see 
{helpb estimation options##level():[R] estimation options}.

{phang}{opt accuracy(#)} should not be specified; it specifies the relative
accuracy required for the linear programming algorithm.  If the potential for
improving the sum of weighted deviations by deleting an observation from the
basis is less than this on a percentage basis, the algorithm will be said to
have converged.  The default value is 10^-10.

{phang}{it:optimization_options}: {opt iter:ate(#)}, [{cmdab:no:}]{opt lo:g}, 
{opt tr:ace}.  {opt iterate()} specifies the maximum number of iterations;
{opt log}/{opt nolog} specifies whether to show the iteration log; and
{opt trace} specifies that the iteration log should include the current
parameter vector.  These options are seldom used.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse twogrp}{p_end}

{pstd}Median regression{p_end}
{phang2}{cmd:. qreg y x}

{pstd}Estimate .75 quantile{p_end}
{phang2}{cmd:. qreg y x, quantile(.75)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Median regression{p_end}
{phang2}{cmd:. qreg price weight length foreign}{p_end}

{pstd}Replay results{p_end}
{phang2}{cmd:. qreg}

{pstd}Estimate .25 quantile{p_end}
{phang2}{cmd:. qreg price weight length foreign, quantile(.25)}{p_end}

{pstd}Estimate .75 quantile{p_end}
{phang2}{cmd:. qreg price weight length foreign, quantile(.75)}{p_end}

{pstd}Estimate [.25, .75] interquantile range, performing 100 bootstrap
replications{p_end}
{phang2}{cmd:. iqreg price weight length foreign, quantile(.25 .75) reps(100)}
{p_end}

{pstd}Same as above{p_end}
{phang2}{cmd:. iqreg price weight length foreign, reps(100)}

{pstd}Estimate .25, .5, and .75 quantiles simultaneously, performing 100
bootstrap replications{p_end}
{phang2}{cmd:. sqreg price weight length foreign, quantile(.25 .5 .75) reps(100)}
{p_end}

{pstd}Median regression with bootstrap standard errors{p_end}
{phang2}{cmd:. bsqreg price weight length foreign}{p_end}

{pstd}Estimate .75 quantile with bootstrap standard errors{p_end}
{phang2}{cmd:. bsqreg price weight length foreign, quantile(.75)}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:qreg} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(q)}}quantile requested{p_end}
{synopt:{cmd:e(q_v)}}value of the quantile{p_end}
{synopt:{cmd:e(sum_adev)}}sum of absolute deviations{p_end}
{synopt:{cmd:e(sum_rdev)}}sum of raw deviations{p_end}
{synopt:{cmd:e(f_r)}}residual density estimate{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(convcode)}}{cmd:0} if converged; otherwise, return code for why
nonconvergence{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:qreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}

{pstd}
{cmd:iqreg} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(q0)}}lower quantile requested{p_end}
{synopt:{cmd:e(q1)}}upper quantile requested{p_end}
{synopt:{cmd:e(reps)}}number of replications{p_end}
{synopt:{cmd:e(sumrdev0)}}lower quantile sum of raw deviations{p_end}
{synopt:{cmd:e(sumrdev1)}}upper quantile sum of raw deviations{p_end}
{synopt:{cmd:e(sumadev0)}}lower quantile sum of absolute deviations{p_end}
{synopt:{cmd:e(sumadev1)}}upper quantile sum of absolute deviations{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(convcode)}}{cmd:0} if converged; otherwise, return code for why
nonconvergence{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:iqreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}

{pstd}
{cmd:sqreg} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(n_q)}}number of quantiles requested{p_end}
{synopt:{cmd:e(q}{it:#}{cmd:)}}the quantiles requested{p_end}
{synopt:{cmd:e(reps)}}number of replications{p_end}
{synopt:{cmd:e(sumrdv}{it:#}{cmd:)}}sum of raw deviations for q{it:#}{p_end}
{synopt:{cmd:e(sumadv}{it:#}{cmd:)}}sum of absolute deviations for q{it:#}{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(convcode)}}{cmd:0} if converged; otherwise, return code for why
nonconvergence{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:sqreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(eqnames)}}names of equations{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}

{pstd}
{cmd:bsqreg} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom{p_end}
{synopt:{cmd:e(q)}}quantile requested{p_end}
{synopt:{cmd:e(q_v)}}value of the quantile{p_end}
{synopt:{cmd:e(reps)}}number of replications{p_end}
{synopt:{cmd:e(sum_adev)}}sum of absolute deviations{p_end}
{synopt:{cmd:e(sum_rdev)}}sum of raw deviations{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}
{synopt:{cmd:e(convcode)}}{cmd:0} if converged; otherwise, return code for why
nonconvergence{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:bsqreg}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(marginsnotok)}}predictions disallowed by {cmd:margins}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}

{pstd}
{cmd:_qreg} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:r(q)}}quantile requested{p_end}
{synopt:{cmd:r(q_v)}}value of the quantile{p_end}
{synopt:{cmd:r(sum_w)}}sum of the weights{p_end}
{synopt:{cmd:r(sum_adev)}}sum of absolute deviations{p_end}
{synopt:{cmd:r(sum_rdev)}}sum of raw deviations{p_end}
{synopt:{cmd:r(f_r)}}residual density estimate{p_end}
{synopt:{cmd:r(ic)}}number of iterations{p_end}
{synopt:{cmd:r(convcode)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}
{p2colreset}{...}

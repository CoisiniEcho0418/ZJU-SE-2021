{smcl}
{* *! version 1.1.11  24may2011}{...}
{viewerdialog bstat "dialog bstat"}{...}
{vieweralsosee "[R] bstat" "mansection R bstat"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bootstrap postestimation" "help bootstrap postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bootstrap" "help bootstrap"}{...}
{vieweralsosee "[R] bsample" "help bsample"}{...}
{viewerjumpto "Syntax" "bstat##syntax"}{...}
{viewerjumpto "Description" "bstat##description"}{...}
{viewerjumpto "Options" "bstat##options"}{...}
{viewerjumpto "Example" "bstat##example"}{...}
{viewerjumpto "Saved results" "bstat##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink R bstat} {hline 2}}Report bootstrap results{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Bootstrap statistics from variables

{p 8 14 2}
{cmd:bstat}
	[{varlist}] {ifin} [{cmd:,} {it:options}]

{phang}
Bootstrap statistics from file

{p 8 14 2}
{cmd:bstat}
	[{it:namelist}] [{opt using} {it:{help filename}}] {ifin} [{cmd:,} 
	{it:options}]

{synoptset 17 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt :{opt s:tat(vector)}}observed values for each statistic{p_end}
{synopt :{opt accel(vector)}}acceleration values for each statistic{p_end}
{synopt :{opt mse}}use MSE formula for variance estimation{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt n(#)}}{it:#} of observations from which bootstrap samples
were taken{p_end}
{synopt :{opt notable}}suppress table of results{p_end}
{synopt :{opt noh:eader}}suppress table header{p_end}
{synopt :{opt nol:egend}}suppress table legend{p_end}
{synopt :{opt v:erbose}}display the full table legend{p_end}
{synopt :{opt ti:tle(text)}}use {it:text} as title for bootstrap results{p_end}
{synopt :{it:{help bstat##display_options:display_options}}}control
     column formats and line width{p_end}
{synoptline}
{p 4 6 2}See {manhelp bootstrap_postestimation R:bootstrap postestimation} for
features available after estimation.


{title:Menu}

{phang}
{bf:Statistics > Resampling > Report bootstrap results}


{marker description}{...}
{title:Description}

{pstd}
{cmd:bstat} is a programmer's command that computes and displays estimation
results from bootstrap statistics.

{pstd}
For each variable in {varlist} (the default is all variables), then
{cmd:bstat} computes a covariance matrix, estimates bias, and constructs
several different confidence intervals (CIs).  The following CIs are
constructed by {cmd:bstat}:

{pmore}
1. Normal CIs (using the normal approximation){break}
2. Percentile CIs{break}
3. Bias-corrected (BC) CIs{break}
4. Bias-corrected and accelerated (BCa) CIs (optional)
{p_end}

{pstd}
{cmd:estat bootstrap} displays a table of one or more of the above
confidence intervals; see
{manhelp bootstrap_postestimation R:bootstrap postestimation}.

{pstd}
If there are bootstrap estimation results in {cmd:e()}, {cmd:bstat} replays
them.  If given the {opt using} modifier, {cmd:bstat} uses the data in
{it:{help filename}} to compute the bootstrap statistics while preserving the
data currently in memory.  Otherwise, {cmd:bstat} uses the data in memory to
compute the bootstrap statistics. 

{pstd}
The following options may be used to replay estimation results from
{cmd:bstat}:

{pmore}
	{opt l:evel(#)}
	{opt notable}
	{opt noh:eader}
	{opt nol:egend}
	{opt v:erbose}
	{opt ti:tle(text)}

{pstd}
For all other options and the qualifiers {opt using}, {opt if}, and {opt in},
{cmd:bstat} requires a bootstrap dataset.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt stat(vector)} specifies the observed value of each statistic (that is, the
value of the statistic using the original dataset).

{phang}
{opt accel(vector)} specifies the acceleration of each statistic, which is
used to construct BCa CIs.

{phang}
{opt mse} specifies that {opt bstat} compute the variance by using deviations
of the replicates from the observed value of the statistics.  By default,
{opt bstat} computes the variance by using deviations from the average of the
replicates.

{dlgtab:Reporting}

{phang}
{opt level(#)}; see
{helpb estimation options##level():[R] estimation options}.

{phang}
{opt n(#)} specifies the number of observations from which bootstrap samples
were taken.  This value is used in no calculations but improves the
table header when this information is not saved in the bootstrap dataset.

{phang}
{opt notable} suppresses the display of the output table.

{phang}
{opt noheader} suppresses the display of the table header.  This option
implies {opt nolegend}.

{phang}
{opt nolegend} suppresses the display of the table legend.  

{phang}
{opt verbose} specifies that the full table legend be displayed.  By default,
coefficients and standard errors are not displayed.

{phang}
{opt title(text)} specifies a title to be displayed above the
table of bootstrap results; the default title is {opt Bootstrap results}.

{marker display_options}{...}
{phang}
{it:display_options}:
{opth cformat(%fmt)},
{opt pformat(%fmt)},
{opt sformat(%fmt)}, and
{opt nolstretch};
    see {helpb estimation options##display_options:[R] estimation options}.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. bootstrap _b, saving(bstat) reps(200) bca: }
          {cmd:regress mpg weight length}{p_end}

{pstd}Save the acceleration statistic vector{p_end}
{phang2}{cmd:. matrix a = e(accel)}{p_end}

{pstd}Save the estimated coefficients from the full sample{p_end}
{phang2}{cmd:. matrix b = e(b)}{p_end}

{pstd}Replay the bootstrap results by using the saved full sample estimate
vector and the saved acceleration vector{p_end}
{phang2}{cmd:. bstat using bstat, stat(b) accel(a)}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:bstat} saves the following in {cmd:e()}:

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}sample size{p_end}
{synopt:{cmd:e(N_reps)}}number of complete replications{p_end}
{synopt:{cmd:e(N_misreps)}}number of incomplete replications{p_end}
{synopt:{cmd:e(N_strata)}}number of strata{p_end}
{synopt:{cmd:e(N_clust)}}number of clusters{p_end}
{synopt:{cmd:e(k_aux)}}number of auxiliary parameters{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_exp)}}number of standard expressions{p_end}
{synopt:{cmd:e(k_eexp)}}number of extended expressions (i.e., {cmd:_b}){p_end}
{synopt:{cmd:e(k_extra)}}number of extra equations beyond the original ones from {cmd:e(b)}){p_end}
{synopt:{cmd:e(level)}}confidence level for bootstrap CIs{p_end}
{synopt:{cmd:e(bs_version)}}version for {cmd:bootstrap} results{p_end}
{synopt:{cmd:e(rank)}}rank of {cmd:e(V)}{p_end}

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:bstat}{p_end}
{synopt:{cmd:e(command)}}from {cmd:_dta[command]}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(title)}}title in estimation output{p_end}
{synopt:{cmd:e(exp}{it:#}{cmd:)}}expression for the {it:#}th statistic{p_end}
{synopt:{cmd:e(prefix)}}{cmd:bootstrap}{p_end}
{synopt:{cmd:e(mse)}}{cmd:mse} if specified{p_end}
{synopt:{cmd:e(vce)}}{cmd:bootstrap}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}

{synoptset 25 tabbed}{...}
{p2col 5 25 29 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}observed statistics{p_end}
{synopt:{cmd:e(b_bs)}}bootstrap estimates{p_end}
{synopt:{cmd:e(reps)}}number of nonmissing results{p_end}
{synopt:{cmd:e(bias)}}estimated biases{p_end}
{synopt:{cmd:e(se)}}estimated standard errors{p_end}
{synopt:{cmd:e(z0)}}median biases{p_end}
{synopt:{cmd:e(accel)}}estimated accelerations{p_end}
{synopt:{cmd:e(ci_normal)}}normal-approximation CIs{p_end}
{synopt:{cmd:e(ci_percentile)}}percentile CIs{p_end}
{synopt:{cmd:e(ci_bc)}}bias-corrected CIs{p_end}
{synopt:{cmd:e(ci_bca)}}bias-corrected and accelerated CIs{p_end}
{synopt:{cmd:e(V)}}bootstrap variance-covariance matrix{p_end}
{p2colreset}{...}

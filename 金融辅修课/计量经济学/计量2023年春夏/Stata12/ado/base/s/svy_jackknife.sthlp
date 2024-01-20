{smcl}
{* *! version 1.1.17  26may2011}{...}
{viewerdialog "svy jackknife" "dialog svy_jackknife"}{...}
{vieweralsosee "[SVY] svy jackknife" "mansection SVY svyjackknife"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] svy postestimation" "help svy_postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] jackknife" "help jackknife"}{...}
{vieweralsosee "[SVY] svy bootstrap" "help svy_bootstrap"}{...}
{vieweralsosee "[SVY] svy brr" "help svy_brr"}{...}
{vieweralsosee "[SVY] svy sdr" "help svy_sdr"}{...}
{viewerjumpto "Syntax" "svy_jackknife##syntax"}{...}
{viewerjumpto "Description" "svy_jackknife##description"}{...}
{viewerjumpto "Options" "svy_jackknife##options"}{...}
{viewerjumpto "Examples" "svy_jackknife##examples"}{...}
{viewerjumpto "Saved results" "svy_jackknife##saved_results"}{...}
{title:Title}

{pstd}
{manlink SVY svy jackknife} {hline 2} Jackknife estimation for survey data


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:svy} {cmdab:jack:knife}
	{it:{help exp_list}}
	[{cmd:,}
		{help svy jackknife##svy_options:{it:svy_options}}
		{help svy jackknife##jackknife_options:{it:jackknife_options}}
		{it:{help eform_option}}]
	{cmd::} {it:command}

{marker svy_options}{...}
{synoptset 25 tabbed}{...}
{synopthdr:svy_options}
{synoptline}
{syntab:if/in}
{synopt :{opt sub:pop}{cmd:(}[{varname}] [{it:{help if}}]{cmd:)}}identify a
	   subpopulation{p_end}

{syntab:Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt noh:eader}}suppress table header{p_end}
{synopt :{opt nol:egend}}suppress table legend{p_end}
{synopt :{opt noadj:ust}}do not adjust model Wald statistic{p_end}
{synopt :{opt nocnsr:eport}}do not display constraints{p_end}
{synopt :{it:{help svy##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

INCLUDE help shortdes-coeflegend
{synoptline}
{p 4 6 2}
{opt coeflegend} is not shown in the dialog boxes for estimation commands.
{p_end}

{marker jackknife_options}{...}
{synopthdr:jackknife_options}
{synoptline}
{syntab:Main}
{synopt :{opt e:class}}number of observations is in {cmd:e(N)}{p_end}
{synopt :{opt r:class}}number of observations is in {cmd:r(N)}{p_end}
{synopt :{opt n(exp)}}specify {it:exp} that evaluates to number of observations
used{p_end}

{syntab:Options}
{synopt :{help prefix_saving_option:{bf:saving(}{it:filename}{bf:[, ...])}}}save
	results to {it:filename}; save statistics in double precision; save
	results to {it:filename} every {it:#} replications{p_end}
{synopt :{opt keep}}keep pseudovalues{p_end}
{synopt :{opt mse}}use MSE formula for variance{p_end}

{syntab:Reporting}
{synopt :{opt v:erbose}}display the full table legend{p_end}
{synopt :{opt nodots}}suppress replication dots{p_end}
{synopt :{opt noi:sily}}display any output from {it:command}{p_end}
{synopt :{opt tr:ace}}trace {it:command}{p_end}
{synopt :{opt ti:tle(text)}}use {it:text} as title for jackknife results{p_end}

{syntab:Advanced}
{synopt :{opt nodrop}}do not drop observations{p_end}
{synopt :{opth reject(exp)}}identify invalid results{p_end}
{synopt :{opt dof(#)}}design degrees of freedom{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help svy_notes_common


{title:Menu}

{phang}
{bf:Statistics > Survey data analysis > Resampling > Jackknife estimation}


{marker description}{...}
{title:Description}

{pstd}
{cmd:svy} {cmd:jackknife} performs jackknife variance estimation for complex
survey data.  Typing

{pin}
{cmd:. svy jackknife} {it:exp_list} {cmd::} {it:command}

{pstd}
executes {it:command} once for each primary sampling unit (PSU) in the
dataset, leaving the associated PSU out of the calculations that
make up {it:exp_list}.

{pstd}
{it:command} defines the statistical command to be executed.
Most Stata commands and user-written programs can be used with
{cmd:svy} {cmd:jackknife}
as long as they follow standard Stata syntax,
allow the {cmd:if} qualifier,
and allow {cmd:pweight}s and {cmd:iweight}s; see {findalias frsyntax}.
The {cmd:by} prefix may not be part of {it:command}.

{pstd}
{it:exp_list} specifies the statistics to be collected from the
execution of {it:command}.
{it:exp_list} is required unless {it:command} has the {cmd:svyj} program
property, in which case {it:exp_list} defaults to {cmd:_b}; see
{manhelp program_properties P:program properties}.


{marker options}{...}
{title:Options}

{phang}
{it:svy_options}; see {manhelp svy SVY}.

{dlgtab:Main}

{phang}
{opt eclass}, {opt rclass}, and {opt n(exp)} specify where
{it:command} saves the number of observations on which it based the calculated
results.  We strongly advise you to specify one of these options.

{pin}
{opt eclass} specifies that {it:command} save the number of observations
in {hi:e(N)}.

{pin}
{opt rclass} specifies that {it:command} save the number of observations
in {hi:r(N)}.

{pin}
{opt n(exp)} allows you to specify an expression
that evaluates to the number of observations used.  Specifying
{cmd:n(r(N))} is the same as specifying the {opt rclass} option; specifying
{cmd:n(e(N))} is the same as specifying the {opt eclass} option.  If
{it:command} saves the number of observations in {cmd:r(N1)},
specify {cmd:n(r(N1))}.

{pin}
If you specify none of these options, {cmd:svy} {cmd:jackknife} will
assume {opt eclass} or {opt rclass} depending upon which of {hi:e(N)} and
{hi:r(N)} is not missing (in that order).  If both {hi:e(N)} and {hi:r(N)} are
missing, {cmd:svy} {cmd:jackknife} assumes that all observations in the
dataset contribute to the calculated result.  If that assumption is incorrect,
then the reported standard errors will be incorrect.  See
{mansection SVY svyjackknifeOptionseclass:{bf:[SVY] svy jackknife}} for further
details.

{dlgtab:Options}

INCLUDE help prefix_saving_option

{pmore}
See {it:{help prefix_saving_option}}, for details about {it:suboptions}.

{phang}
{opt keep} specifies that new variables be added to the dataset
containing the pseudovalues of the requested statistics.
See {mansection SVY svyjackknifeOptionskeep:{bf:[SVY] svy jackknife}} for
details.  {opt keep} implies the {opt nodrop} option.

{phang}
{opt mse} specifies that {cmd:svy} {cmd:jackknife} compute the variance by using
deviations of the replicates from the observed value of the statistics based
on the entire dataset.  By default, {cmd:svy} {cmd:jackknife} computes the
variance by using deviations of the pseudovalues from their mean.

{dlgtab:Reporting}

{phang}
{opt verbose} requests that the full table legend be displayed.

{phang}
{opt nodots} suppresses display of the replication dots.  By
default, one dot character is printed for each successful replication.
A red `x' is printed if {it:command} returns with an error, `e' is printed if
one of the values in {it:{help exp_list}} is missing, `n' is printed if the sample
size is not correct, and a yellow `s' is printed if the dropped sampling unit
is outside the subpopulation sample.

{phang}
{opt noisily} requests that any output from {it:command} be displayed.
This option implies the {opt nodots} option.

{phang}
{opt trace} causes a trace of the execution of {it:command} to be displayed.
This option implies the {opt noisily} option.

{phang}
{opt title(text)} specifies a title to be displayed above the
table of jackknife results; the default title is "Jackknife results".

{phang}
{it:eform_option}; see {manhelpi eform_option R}.
This option is ignored if {it:{help exp_list}} is not {cmd:_b}.

{dlgtab:Advanced}

{phang}
{opt nodrop} prevents observations outside {cmd:e(sample)} and the
{cmd:if} and {cmd:in} qualifiers from being dropped before the data are
resampled.

{phang}
{opth reject(exp)} identifies an expression that indicates when results should
be rejected.  When {it:exp} is true, the resulting values are reset to missing
values.

{phang}
{opt dof(#)} specifies the design degrees of freedom, overriding the default
calculation, df = N_psu - N_strata.


{marker examples}{...}
{title:Examples}

{phang}
{cmd:. webuse nhanes2}
{p_end}
{phang}
{cmd:. svy jackknife slope = _b[height] constant=_b[_cons]:}
           {cmd:regress weight height}
{p_end}

{phang}
{cmd:. webuse nhanes2jknife}
{p_end}
{phang}
{cmd:. svyset _n}
{p_end}
{phang}
{cmd:. svy jackknife slope = _b[height] : regress weight height}
{p_end}
{phang}
{cmd:. svy jackknife slope = _b[height], mse : regress weight height}
{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
In addition to the results documented in {manhelp svy SVY},
{cmd:svy jackknife} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N_reps)}}number of replications{p_end}
{synopt:{cmd:e(N_misreps)}}number of replications with missing values{p_end}
{synopt:{cmd:e(k_exp)}}number of standard expressions{p_end}
{synopt:{cmd:e(k_eexp)}}number of {cmd:_b}/{cmd:_se} expressions{p_end}
{synopt:{cmd:e(k_extra)}}number of extra estimates added to {cmd:_b}{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmdname)}}command name from {it:command}{p_end}
{synopt:{cmd:e(cmd)}}same as {cmd:e(cmdname)} or {cmd:jackknife}{p_end}
{synopt:{cmd:e(vce)}}{cmd:jackknife}{p_end}
{synopt:{cmd:e(exp}{it:#}{cmd:)}}{it:#}th expression{p_end}
{synopt:{cmd:e(jkrweight)}}{cmd:jkrweight()} variable list{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b_jk)}}jackknife means{p_end}
{synopt:{cmd:e(V)}}jackknife variance estimates{p_end}

{pstd}
When {it:exp_list} is {cmd:_b}, {cmd:svy jackknife} will also carry forward
most of the results already in {cmd:e()} from {it:command}.{p_end}
{p2colreset}{...}

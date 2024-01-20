{smcl}
{* *! version 1.0.14  26may2011}{...}
{viewerdialog "svy sdr" "dialog svy_sdr"}{...}
{vieweralsosee "[SVY] svy sdr" "mansection SVY svysdr"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] svy postestimation" "help svy_postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] svy bootstrap" "help svy_bootstrap"}{...}
{vieweralsosee "[SVY] svy brr" "help svy_brr"}{...}
{vieweralsosee "[SVY] svy jackknife" "help svy_jackknife"}{...}
{viewerjumpto "Syntax" "svy_sdr##syntax"}{...}
{viewerjumpto "Description" "svy_sdr##description"}{...}
{viewerjumpto "Options" "svy_sdr##options"}{...}
{viewerjumpto "Example" "svy_sdr##example"}{...}
{viewerjumpto "Saved results" "svy_sdr##saved_results"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink SVY svy sdr} {hline 2}}Successive
difference replication for survey data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
[{cmd:svy}] {cmd:sdr}
	{it:{help exp_list}}
	[{cmd:,}
		{help svy sdr##svy_options:{it:svy_options}}
		{help svy sdr##sdr_options:{it:sdr_options}}
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

{marker sdr_options}{...}
{synopthdr:sdr_options}
{synoptline}
{syntab:Options}
{synopt :{help prefix_saving_option:{bf:saving(}{it:filename}{bf:[, ...])}}}save
	results to {it:filename}; save statistics in double precision; save
	results to {it:filename} every {it:#} replications{p_end}
{synopt :{opt mse}}use MSE formula for variance{p_end}

{syntab:Reporting}
{synopt :{opt v:erbose}}display the full table legend{p_end}
{synopt :{opt nodots}}suppress replication dots{p_end}
{synopt :{opt noi:sily}}display any output from {it:command}{p_end}
{synopt :{opt tr:ace}}trace {it:command}{p_end}
{synopt :{opt ti:tle(text)}}use {it:text} as title for SDR results{p_end}

{syntab:Advanced}
{synopt :{opt nodrop}}do not drop observations{p_end}
{synopt :{opth reject(exp)}}identify invalid results{p_end}
{synopt :{opt dof(#)}}design degrees of freedom{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help svy_notes_common
{phang}
{cmd:svy} {cmd:sdr} requires that the successive difference replicate weights
be identified using {helpb svyset}.
{p_end}


{title:Menu}

{phang}
{bf:Statistics > Survey data analysis > Resampling >}
      {bf:Successive difference replications estimation}


{marker description}{...}
{title:Description}

{pstd}
{cmd:svy} {cmd:sdr} performs successive difference replication (SDR) for
complex survey data.  Typing

{pin}
{cmd:. svy sdr} {it:exp_list} {cmd::} {it:command}

{pstd}
executes {it:command} once for each replicate, using sampling weights that are
adjusted according to the SDR methodology.

{pstd}
{it:command} defines the statistical command to be executed.
Most Stata commands and user-written programs can be used with
{cmd:svy} {cmd:sdr}
as long as they follow standard Stata syntax,
allow the {cmd:if} qualifier,
and allow {cmd:pweight}s and {cmd:iweight}s; see {findalias frsyntax}.
The {cmd:by} prefix may not be part of {it:command}.

{pstd}
{it:exp_list} specifies the statistics to be collected from the
execution of {it:command}.
{it:exp_list} is required unless {it:command} has the {cmd:svyb} program
property, in which case {it:exp_list} defaults to {cmd:_b}; see
{manhelp program_properties P:program properties}.


{marker options}{...}
{title:Options}

{phang}
{it:svy_options}; see {manhelp svy SVY}.

{dlgtab:Options}

INCLUDE help prefix_saving_option

{pmore}
See {it:{help prefix_saving_option}}, for details about {it:suboptions}.

{phang}
{opt mse} specifies that {cmd:svy} {cmd:sdr} compute the variance by using
deviations of the replicates from the observed value of the statistics based
on the entire dataset.  By default, {cmd:svy} {cmd:sdr} computes the variance
by using deviations of the replicates from their mean.

{dlgtab:Reporting}

{phang}
{opt verbose} requests that the full table legend be displayed.

{phang}
{opt nodots} suppresses display of the replication dots.  By
default, one dot character is printed for each successful replication.
A red `x' is printed if {it:command} returns with an error, and
`e' is printed if one of the values in {it:{help exp_list}} is missing.

{phang}
{opt noisily} requests that any output from {it:command} be displayed.
This option implies the {opt nodots} option.

{phang}
{opt trace} causes a trace of the execution of {it:command} to be displayed.
This option implies the {opt noisily} option.

{phang}
{opt title(text)} specifies a title to be displayed above the
table of SDR results; the default title is "SDR results".

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


{marker example}{...}
{title:Example}

{phang}
{cmd:. webuse ss07ptx}
{p_end}
{phang}
{cmd:. svyset}
{p_end}
{phang}
{cmd:. svy: mean agep, over(sex)}
{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
In addition to the results documented in {manhelp svy SVY},
{cmd:svy sdr} saves the following in {cmd:e()}:

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
{synopt:{cmd:e(cmd)}}same as {cmd:e(cmdname)} or {cmd:sdr}{p_end}
{synopt:{cmd:e(vce)}}{cmd:sdr}{p_end}
{synopt:{cmd:e(exp}{it:#}{cmd:)}}{it:#}th expression{p_end}
{synopt:{cmd:e(sdrweight)}}{cmd:sdrweight()} variable list{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b_sdr)}}SDR means{p_end}
{synopt:{cmd:e(V)}}SDR variance estimates{p_end}

{pstd}
When {it:exp_list} is {cmd:_b}, {cmd:svy sdr} will also carry forward
most of the results already in {cmd:e()} from {it:command}.{p_end}
{p2colreset}{...}

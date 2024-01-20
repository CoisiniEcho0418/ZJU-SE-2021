{smcl}
{* *! version 1.0.15  26may2011}{...}
{viewerdialog "svy bootstrap" "dialog svy_bootstrap"}{...}
{vieweralsosee "[SVY] svy bootstrap" "mansection SVY svybootstrap"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] svy postestimation" "help svy_postestimation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bootstrap" "help bootstrap"}{...}
{vieweralsosee "[SVY] svy brr" "help svy_brr"}{...}
{vieweralsosee "[SVY] svy jackknife" "help svy_jackknife"}{...}
{vieweralsosee "[SVY] svy sdr" "help svy_sdr"}{...}
{viewerjumpto "Syntax" "svy_bootstrap##syntax"}{...}
{viewerjumpto "Description" "svy_bootstrap##description"}{...}
{viewerjumpto "Options" "svy_bootstrap##options"}{...}
{viewerjumpto "Examples" "svy_bootstrap##examples"}{...}
{viewerjumpto "Saved results" "svy_bootstrap##saved_results"}{...}
{title:Title}

{p2colset 5 28 30 2}{...}
{p2col:{manlink SVY svy bootstrap} {hline 2}}Bootstrap for survey data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:svy} {cmd:bootstrap}
	{it:{help exp_list}}
	[{cmd:,}
		{help svy bootstrap##svy_options:{it:svy_options}}
		{help svy bootstrap##bootstrap_options:{it:bootstrap_options}}
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

{marker bootstrap_options}{...}
{synopthdr:bootstrap_options}
{synoptline}
{syntab:Main}
{synopt :{opt bsn(#)}}bootstrap mean-weight adjustment{p_end}

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
{synopt :{opt ti:tle(text)}}use {it:text} as title for bootstrap results{p_end}

{syntab:Advanced}
{synopt :{opt nodrop}}do not drop observations{p_end}
{synopt :{opth reject(exp)}}identify invalid results{p_end}
{synopt :{opt dof(#)}}design degrees of freedom{p_end}
{synoptline}
{p2colreset}{...}
INCLUDE help svy_notes_common
{phang}
{cmd:svy} {cmd:bootstrap} requires that the bootstrap replicate weights be
identified using {helpb svyset}.
{p_end}


{title:Menu}

{phang}
{bf:Statistics > Survey data analysis > Resampling > Bootstrap estimation}


{marker description}{...}
{title:Description}

{pstd}
{cmd:svy} {cmd:bootstrap} performs bootstrap replication for complex
survey data.  Typing

{pin}
{cmd:. svy bootstrap} {it:exp_list} {cmd::} {it:command}

{pstd}
executes {it:command} once for each replicate, using sampling weights that are
adjusted according to the bootstrap methodology.

{pstd}
{it:command} defines the statistical command to be executed.
Most Stata commands and user-written programs can be used with
{cmd:svy} {cmd:bootstrap}
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

{dlgtab:Main}

{phang}
{opt bsn(#)} specifies that {it:#} bootstrap replicate-weight variables were
used to generate each bootstrap mean-weight variable specified in the
{opt bsrweight()} option of {helpb svyset}.  The default is {cmd:bsn(1)}.
The {opt bsn()} option of {cmd:svy bootstrap} overrides the {opt bsn(#)} option
of {helpb svyset}.

{dlgtab:Options}

INCLUDE help prefix_saving_option

{pmore}
See {it:{help prefix_saving_option}}, for details about {it:suboptions}.

{phang}
{opt mse} specifies that {cmd:svy} {cmd:bootstrap} compute the variance by using
deviations of the replicates from the observed value of the statistics based
on the entire dataset.  By default, {cmd:svy} {cmd:bootstrap} computes the
variance by using deviations of the replicates from their mean.

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
table of bootstrap results; the default title is "Bootstrap results".

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
{cmd:. webuse nmihs_bs}
{p_end}
{phang}
{cmd:. svyset}
{p_end}
{phang}
{cmd:. svy, nodots: mean birthwgt}
{p_end}

{phang}
{cmd:. webuse nmihs_mbs}
{p_end}
{phang}
{cmd:. svyset}
{p_end}
{phang}
{cmd:. svy, nodots: mean birthwgt}
{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
In addition to the results documented in {manhelp svy SVY}, {cmd:svy bootstrap} saves the following in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N_reps)}}number of replications{p_end}
{synopt:{cmd:e(N_misreps)}}number of replications with missing values{p_end}
{synopt:{cmd:e(k_exp)}}number of standard expressions{p_end}
{synopt:{cmd:e(k_eexp)}}number of {cmd:_b}/{cmd:_se} expressions{p_end}
{synopt:{cmd:e(k_extra)}}number of extra estimates added to {cmd:_b}{p_end}
{synopt:{cmd:e(bsn)}}bootstrap mean-weight adjustment{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:e(cmdname)}}command name from {it:command}{p_end}
{synopt:{cmd:e(cmd)}}same as {cmd:e(cmdname)} or {cmd:bootstrap}{p_end}
{synopt:{cmd:e(vce)}}{cmd:bootstrap}{p_end}
{synopt:{cmd:e(exp}{it:#}{cmd:)}}{it:#}th expression{p_end}
{synopt:{cmd:e(bsrweight)}}{cmd:bsrweight()} variable list{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b_bs)}}bootstrap means{p_end}
{synopt:{cmd:e(V)}}bootstrap variance estimates{p_end}

{pstd}
When {it:exp_list} is {cmd:_b}, {cmd:svy bootstrap} will also carry forward
most of the results already in {cmd:e()} from {it:command}.{p_end}
{p2colreset}{...}

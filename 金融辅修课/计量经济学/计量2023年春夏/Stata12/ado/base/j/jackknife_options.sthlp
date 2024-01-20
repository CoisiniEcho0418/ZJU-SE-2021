{smcl}
{* *! version 1.1.8  14apr2011}{...}
{vieweralsosee "[SVY] jackknife_options" "mansection SVY jackknife_options"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] svy" "help svy"}{...}
{vieweralsosee "[SVY] svy jackknife" "help svy_jackknife"}{...}
{viewerjumpto "Syntax" "jackknife_options##syntax"}{...}
{viewerjumpto "Description" "jackknife_options##description"}{...}
{viewerjumpto "Options" "jackknife_options##options"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col :{manlinki SVY jackknife_options} {hline 2}}More options for jackknife
variance estimation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 25 tabbed}{...}
{synopthdr:jackknife_options}
{synoptline}
{syntab:SE}
{synopt :{opt mse}}use MSE formula for variance{p_end}
{synopt :{opt nodots}}suppress replication dots{p_end}

{synopt:{help prefix_saving_option:{bf:saving(}{it:filename}{bf:, ...)}}}save
	results to {it:filename}{p_end}
{synopt:{opt keep}}keep pseudovalues{p_end}
{synopt:{opt v:erbose}}display the full table legend{p_end}
{synopt:{opt noi:sily}}display any output from {it:command}{p_end}
{synopt:{opt tr:ace}}trace {it:command}{p_end}
{synopt:{opt ti:tle(text)}}use {it:text} as the title for results{p_end}
{synopt:{opt nodrop}}do not drop observations{p_end}
{synopt:{opth reject(exp)}}identify invalid results{p_end}
{synoptline}
{p2colreset}{...}
{phang}
{cmd:saving()}, {cmd:keep}, {cmd:verbose}, {cmd:noisily}, {cmd:trace}, 
{cmd:title()}, {cmd:nodrop}, and {cmd:reject()} are not shown in the dialog
boxes for estimation commands.


{marker description}{...}
{title:Description}

{pstd}
{cmd:svy} accepts more options when performing jackknife variance
estimation.


{marker options}{...}
{title:Options}

{dlgtab:SE}

{phang}
{opt mse} specifies that {cmd:svy} compute the variance by using deviations of
the replicates from the observed value of the statistics based on the entire
dataset.  By default, {cmd:svy} computes the variance by using the deviations
of the replicates from their mean.

{phang}
{opt nodots} suppresses display of the replication dots.  By
default, one dot character is printed for each successful replication.
A red `x' is displayed if {it:command} returns with an error, `e' is
displayed if at least one of the values in the {it:exp_list} is missing,
`n' is displayed if the sample size is not correct, and a yellow `s' is
displayed if the dropped sampling unit is outside the subpopulation sample.

{phang}
{opt saving()}, {opt keep}, {opt verbose}, {opt noisily}, {opt trace},
{opt title()}, {opt nodrop}, {opt reject()}; see
{manhelp svy_jackknife SVY:svy jackknife}.
{p_end}

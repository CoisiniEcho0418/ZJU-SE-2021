{smcl}
{* *! version 1.0.7  14apr2011}{...}
{vieweralsosee "[SVY] sdr_options" "mansection SVY sdr_options"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[SVY] svy" "help svy"}{...}
{vieweralsosee "[SVY] svy sdr" "help svy_sdr"}{...}
{viewerjumpto "Syntax" "sdr_options##syntax"}{...}
{viewerjumpto "Description" "sdr_options##description"}{...}
{viewerjumpto "Options" "sdr_options##options"}{...}
{title:Title}

{p2colset 5 26 28 2}{...}
{p2col :{manlinki SVY sdr_options} {hline 2}}More options for SDR variance estimation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 25 tabbed}{...}
{synopthdr:sdr_options}
{synoptline}
{syntab:SE}
{synopt :{opt mse}}use MSE formula for variance{p_end}
{synopt :{opt nodots}}suppress replication dots{p_end}

{synopt :{help prefix_saving_option:{bf:saving(}{it:filename}{bf:, ...)}}}save
	results to {it:filename}{p_end}
{synopt :{opt v:erbose}}display the full table legend{p_end}
{synopt :{opt noi:sily}}display any output from {it:command}{p_end}
{synopt :{opt tr:ace}}trace {it:command}{p_end}
{synopt :{opt ti:tle(text)}}use {it:text} as the title for results{p_end}
{synopt :{opt nodrop}}do not drop observations{p_end}
{synopt :{opth reject(exp)}}identify invalid results{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:saving()}, {cmd:verbose}, {cmd:noisily}, {cmd:trace}, {cmd:title()},
{cmd:nodrop}, and {cmd:reject()} are not shown in the dialog boxes for
estimation commands.


{marker description}{...}
{title:Description}

{pstd}
{cmd:svy} accepts more options when performing successive difference
replication (SDR) variance estimation.  See {manhelp svy_sdr SVY:svy sdr} for a
complete discussion.


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
A red `x' is displayed if {it:command} returns with an error, and `e' is
displayed if at least one of the values in {it:exp_list} is missing.

{phang}
{opt saving()}, {opt verbose}, {opt noisily}, {opt trace}, {opt title()},
{opt nodrop}, and {opt reject()}; see {manhelp svy_sdr SVY:svy sdr}.
{p_end}

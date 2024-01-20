{smcl}
{* *! version 1.1.4  14apr2011}{...}
{vieweralsosee "[R] simulate" "mansection R simulate"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bootstrap" "help bootstrap"}{...}
{vieweralsosee "[R] jackknife" "help jackknife"}{...}
{vieweralsosee "[R] permute" "help permute"}{...}
{viewerjumpto "Syntax" "simulate##syntax"}{...}
{viewerjumpto "Description" "simulate##description"}{...}
{viewerjumpto "Options" "simulate##options"}{...}
{viewerjumpto "Examples" "simulate##examples"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink R simulate} {hline 2}}Monte Carlo simulations{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:simulate}
	[{it:{help exp_list}}]
	{cmd:,} {opt r:eps(#)} [{it:options}]
	{cmd::} {it:command}

{synoptset 21}{...}
{synopt:{it:options}}Description{p_end}
{synoptline}
{synopt:{opt nodots}}suppress replication dots{p_end}
{synopt:{opt noi:sily}}display any output from {it:command}{p_end}
{synopt:{opt tr:ace}}trace {it:command}{p_end}
{synopt:{help prefix_saving_option:{bf:{ul:sa}ving(}{it:filename}{bf:, ...)}}}save
	results to {it:filename}{p_end}
{synopt:{opt nol:egend}}suppress table legend{p_end}
{synopt:{opt v:erbose}}display the full table legend{p_end}
{synopt:{opt seed(#)}}set random-number seed to {it:#}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
All weight types supported by {it:command} are allowed; see {help weight}.
{p_end}


{marker description}{...}
{title:Description}

{pstd}
{opt simulate} eases the programming task of performing Monte Carlo-type
simulations.  Typing

{pin}
{cmd:. simulate} {it:{help exp_list}} {cmd:, reps(}{it:#}{cmd:)} {cmd::} {it:command}

{pstd}
runs {it:command} for {it:#} replications and collects the results in
{it:exp_list}.

{pstd}
{it:command} defines the command that performs one simulation.
Most Stata commands and user-written programs can be used with {opt simulate},
as long as they follow {help language:standard Stata syntax}.
The {opt by} prefix may not be part of {it:command}.

{pstd}
{it:{help exp_list}} specifies the expression to be calculated from the
execution of {it:command}.
If no expressions are given, {it:exp_list} assumes a default, depending upon
whether {it:command} changes results in {opt e()} and {opt r()}.  If
{it:command} changes results in {opt e()}, the default is {opt _b}.  If
{it:command} changes results in {opt r()} (but not {opt e()}), the default is
all the scalars posted to {opt r()}.  It is an error not to specify an
expression in {it:exp_list} otherwise.


{marker options}{...}
{title:Options}

{phang}
{opt reps(#)} is required -- it specifies the number of replications to
    be performed.

{phang}
{opt nodots} suppresses display of the replication dots.  By
default, one dot character is displayed for each successful replication.
A red `x' is displayed if {it:command} returns an error or
if one of the values in {it:{help exp_list}} is missing.

{phang}
{opt noisily} requests that any output from {it:command} be displayed.
This option implies the {opt nodots} option.

{phang}
{opt trace} causes a trace of the execution of {it:command} to be displayed.
This option implies the {opt noisily} option.

INCLUDE help prefix_saving_option

{pmore}
See {it:{help prefix_saving_option}}, for details about {it:suboptions}.

{phang}
{opt nolegend} suppresses display of the table legend.  The table
legend identifies the rows of the table with the expressions they represent.

{phang}
{opt verbose} requests that the full table legend be displayed.  By default,
coefficients and standard errors are not displayed.

{phang}
{opt seed(#)} sets the random-number seed.  Specifying this option is
equivalent to typing the following command before calling {opt simulate}:

{pmore}
{cmd:. set seed} {it:#}


{marker examples}{...}
{title:Examples}

{pstd}
Make a dataset containing means and variances of 100-observation samples
from a lognormal distribution.  Perform the experiment 10,000 times:

    {cmd:program define lnsim, rclass}
        {cmd:version {ccl stata_version}}
        {cmd:syntax [, obs(integer 1) mu(real 0) sigma(real 1) ]}
        {cmd:drop _all}
        {cmd:set obs `obs'}
        {cmd:tempvar z}
        {cmd:gen `z' = exp(rnormal(`mu',`sigma'))}
        {cmd:summarize `z'}
        {cmd:return scalar mean = r(mean)}
        {cmd:return scalar Var  = r(Var)}
    {cmd:end}

{phang}
{cmd:. simulate mean=r(mean) var=r(Var), reps(10000): lnsim, obs(100)}

{pstd}
Make a dataset containing means and variances of 50-observation samples
from a lognormal distribution with a normal mean of -3 and standard
deviation of 7.  Perform the experiment 10,000 times:

{phang}
{cmd:. simulate mean=r(mean) var=r(Var), reps(10000): lnsim, obs(50) mu(-3) sigma(7)}
{p_end}

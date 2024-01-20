{smcl}
{* *! version 1.1.7  03apr2011}{...}
{viewerdialog permute "dialog permute"}{...}
{vieweralsosee "[R] permute" "mansection R permute"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bootstrap" "help bootstrap"}{...}
{vieweralsosee "[R] jackknife" "help jackknife"}{...}
{vieweralsosee "[R] simulate" "help simulate"}{...}
{viewerjumpto "Syntax" "permute##syntax"}{...}
{viewerjumpto "Description" "permute##description"}{...}
{viewerjumpto "Options" "permute##options"}{...}
{viewerjumpto "Examples" "permute##examples"}{...}
{viewerjumpto "Saved results" "permute##saved_results"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R permute} {hline 2}}Monte Carlo permutation tests{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
Compute permutation test

{p 8 16 2}
{cmd:permute}
	{it:permvar}
	{it:{help exp_list}}
	[{cmd:,} {it:{help permute##options_table:options}}]
	{cmd::} {it:command}


{pstd}
Report saved results

{p 8 16 2}
{cmd:permute}
	[{varlist}]
	[{cmd:using} {it:{help filename}}]
	[{cmd:,} {it:{help permute##display_options:display_options}}]


{synoptset 23 tabbed}{...}
{marker options_table}{...}
{synopthdr}
{synoptline}
{syntab :Main}
{synopt :{opt r:eps(#)}}perform {it:#} random permutations, default is {cmd:reps(100)}{p_end}
{synopt :{opt le:ft}|{opt ri:ght}}compute one-sided p-values; default is two-sided{p_end}

{syntab :Options}
{synopt :{opth str:ata(varlist)}}permute within strata{p_end}
{synopt :{help prefix_saving_option:{bf:{ul:sa}ving(}{it:filename}{bf:, ...)}}}save
	results to {it:filename}; save statistics in double precision; save results to {it:filename} every {it:#} replications{p_end}

{syntab :Reporting}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt noh:eader}}suppress table header{p_end}
{synopt :{opt nol:egend}}suppress table legend{p_end}
{synopt :{opt v:erbose}}display full table legend{p_end}
{synopt :{opt nodrop}}do not drop observations{p_end}
{synopt :{opt nodots}}suppress replication dots{p_end}
{synopt :{opt noi:sily}}display any output from {it:command}{p_end}
{synopt :{opt tr:ace}}trace {it:command}{p_end}
{synopt :{opt ti:tle(text)}}use {it:text} as title for permutation results{p_end}

{syntab :Advanced}
{synopt :{opt eps(#)}}numerical tolerance; seldom used{p_end}
{synopt :{opt nowarn}}do not warn when {cmd:e(sample)} is not set{p_end}
{synopt :{opt force}}do not check for {it:weights} or {cmd:svy} commands; seldom used{p_end}
{synopt :{opth reject(exp)}}identify invalid results{p_end}
{synopt :{opt seed(#)}}set random-number seed to {it:#}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{it:weights} are not allowed in {it:command}.

{synoptset 23}{...}
{marker display_options}{...}
{synopthdr :display_options}
{synoptline}
{synopt :{opt le:ft}|{opt ri:ght}}compute one-sided p-values;
	default is two-sided{p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt :{opt noh:eader}}suppress table header{p_end}
{synopt :{opt nol:egend}}suppress table legend{p_end}
{synopt :{opt v:erbose}}display full table legend{p_end}
{synopt :{opt ti:tle(text)}}use {it:text} as title for results{p_end}
{synopt :{opt eps(#)}}numerical tolerance; seldom used{p_end}
{synoptline}
{p2colreset}


{title:Menu}

{phang}
{bf:Statistics > Resampling > Permutation tests}


{marker description}{...}
{title:Description}

{pstd}
{cmd:permute} estimates p-values for permutation tests on the basis of Monte
Carlo simulations.  Typing

{pin}
{cmd:. permute} {it:permvar} {it:exp_list}{cmd:,} {opt reps(#)}{cmd::} {it:command}

{pstd}
randomly permutes the values in {it:permvar} {it:#} times, each time executing
{it:command} and collecting the associated values from the expressions in
{it:exp_list}.

{pstd}
These p-value estimates can be one-sided:  Pr(T* {ul:<} T) or Pr(T* {ul:>} T).
The default is two-sided:  Pr(|T*| {ul:>} |T|).  Here T* denotes the value of
the statistic from a randomly permuted dataset, and T denotes the statistic
as computed on the original data.

{pstd}
{it:permvar} identifies the variable whose observed values will be randomly
permuted.

{pstd}
{it:command} defines the statistical command to be executed.
Most Stata commands and user-written programs can be used with {cmd:permute},
as long as they follow {help language:standard Stata syntax}.
The {cmd:by} prefix may not be part of {it:command}.

{pstd}
{it:exp_list} specifies the statistics to be collected from the execution of
{it:command}.  

{pstd}
{cmd:permute} may be used for replaying results, but this feature is 
appropriate only when a dataset generated by {cmd:permute} is currently in
memory or is identified by the {opt using} option.  The variables specified
in {varlist} in this context must be present in the respective dataset.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt reps(#)} specifies the number of random permutations to perform.  The
default is 100.

{phang}
{opt left} or {opt right} requests that one-sided p-values be computed.
If {opt left} is specified, an estimate of Pr(T* {ul:<} T) is produced, where
T* is the test statistic and T is its observed value.  If {opt right} is
specified, an estimate of Pr(T* {ul:>} T) is produced.  By default, two-sided
p-values are computed; that is, Pr(|T*| {ul:>} |T|) is estimated.

{dlgtab:Options}

{phang}
{opth strata(varlist)} specifies that the permutations be
performed within each stratum defined by the values of {it:varlist}.

INCLUDE help prefix_saving_option

{pmore}
See {it:{help prefix_saving_option}} for details about {it:suboptions}.

{dlgtab:Reporting}

{phang}
{opt level(#)} specifies the confidence level, as a percentage,
for confidence intervals. The default is {cmd:level(95)} or as set by 
{helpb level:set level}.

{phang}
{opt noheader} suppresses display of the table header.  This option
implies the {opt nolegend} option.

{phang}
{opt nolegend} suppresses display of the table legend.  The table
legend identifies the rows of the table with the expressions they represent.

{phang}
{opt verbose} requests that the full table legend be displayed.  By default,
coefficients and standard errors are not displayed.

{phang}
{cmd:nodrop} prevents {cmd:permute} from dropping observations outside the
{cmd:if} and {cmd:in} qualifiers.  {cmd:nodrop} will also cause {cmd:permute}
to ignore the contents of {hi:e(sample)} if it exists as a result of running
{it:command}.  By default, {cmd:permute} temporarily drops out-of-sample
observations.

{phang}
{opt nodots} suppresses display of the replication dots.  By default, one 
dot character is displayed for each successful replication.  A red 'x'
is displayed if {it:command} returns an error or if one of the values in
{it:exp_list} is missing.

{phang}
{opt noisily} requests that any output from {it:command} be displayed.  This
option implies the {opt nodots} option.

{phang}
{opt trace} causes a trace of the execution of {it:command} to be displayed.
This option implies the {opt noisily} option.

{phang}
{opt title(text)} specifies a title to be displayed above the table of
results; the default title is {cmd:Monte Carlo permutation results}.

{dlgtab:Advanced}

{phang}
{opt eps(#)} specifies the numerical tolerance for testing |T*| {ul:>} |T|,
T* {ul:<} T, or T* {ul:>} T.  These are considered true if, respectively,
|T*| {ul:>} |T| - {it:#}, T* {ul:<} T + {it:#}, or T* {ul:>} T - {it:#}.  The 
default is {cmd:1e-7}.  You will not have to specify {cmd:eps()} under normal circumstances.

{phang}
{opt nowarn} suppresses the printing of a warning message when {it:command}
does not set {cmd:e(sample)}.

{phang}
{opt force} suppresses the restriction that {it:command} may not specify
weights or be a {cmd:svy} command. {cmd:permute} is not suited for weighted
estimation, thus {cmd:permute} should not be used with weights or {cmd:svy}.
{cmd:permute} reports an error when it encounters weights or {cmd:svy} in
{it:command} if the {cmd:force} option is not specified.  This is a seldom 
used option, so use it only if you know what you are doing!

{phang}
{opth reject(exp)} identifies an expression that indicates when results should
be rejected.  When {it:exp} is true, the resulting values are reset to missing
values.

{phang}
{opt seed(#)} sets the random-number seed.  Specifying this option is
equivalent to typing the following command prior to calling {cmd:permute}:

{pin2}
{cmd:. set seed} {it:#}


{marker examples}{...}
{title:Examples}

    {hline}
    Setup
{phang2}{cmd:. webuse permutexmpl}{p_end}

{pstd}Test whether a drug treatment increases the development of cells
relative to a placebo{p_end}
{phang2}{cmd:. permute y sum=r(sum), saving(permdish) right nodrop nowarn:}
               {cmd:summarize y if treatment}

{pstd}Replay results, requesting 80% confidence intervals{p_end}
{phang2}{cmd:. permute using permdish, level(80)}

    {hline}
    Setup
{phang2}{cmd:. webuse permute2}{p_end}

{pstd}Use the Wilcoxon rank-sum test to determine if two independent samples
are from populations with the same distribution{p_end}
{phang2}{cmd:. permute y z=r(z), reps(10000) nowarn nodots: ranksum y,}
                {cmd:by(group)}{p_end}

    {hline}
    Setup
{phang2}{cmd:. webuse lbw}

{pstd}Use logistic regression to test for an association between smoking and
low birthweight{p_end}
{phang2}{cmd:. permute smoke x2=e(chi2), reps(10000) nodots: logit low smoke}

    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:permute} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}sample size{p_end}
{synopt:{cmd:r(N_reps)}}number of requested replications{p_end}
{synopt:{cmd:r(level)}}confidence level{p_end}
{synopt:{cmd:r(k_exp)}}number of standard expressions{p_end}
{synopt:{cmd:r(k_eexp)}}number of {cmd:_b}/{cmd:_se} expressions{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(cmd)}}{cmd:permute}{p_end}
{synopt:{cmd:r(command)}}{it:command} following colon{p_end}
{synopt:{cmd:r(permvar)}}permutation variable{p_end}
{synopt:{cmd:r(title)}}title in output{p_end}
{synopt:{cmd:r(exp}{it:#}{cmd:)}}{it:#}th expression{p_end}
{synopt:{cmd:r(left)}}{cmd:left} or empty{p_end}
{synopt:{cmd:r(right)}}{cmd:right} or empty{p_end}
{synopt:{cmd:r(seed)}}initial random-number seed{p_end}
{synopt:{cmd:r(event)}}T <= T(obs), T >= T(obs), or |T| <= |T(obs)|{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(b)}}observed statistics{p_end}
{synopt:{cmd:r(c)}}count when {cmd:r(event)} is true{p_end}
{synopt:{cmd:r(reps)}}number of nonmissing results{p_end}
{synopt:{cmd:r(p)}}observed proportions{p_end}
{synopt:{cmd:r(se)}}standard errors of observed proportions{p_end}
{synopt:{cmd:r(ci)}}confidence intervals of observed proportions{p_end}
{p2colreset}{...}

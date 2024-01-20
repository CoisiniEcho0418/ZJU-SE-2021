{smcl}
{* *! version 1.1.11  05may2011}{...}
{viewerdialog "one-sample" "dialog ttest1"}{...}
{viewerdialog "two-sample, unpaired" "dialog ttest2"}{...}
{viewerdialog "two-sample, paired" "dialog ttestpair"}{...}
{viewerdialog "two-sample, by()" "dialog ttestby"}{...}
{viewerdialog "" "--"}{...}
{viewerdialog "one-sample immediate" "dialog ttesti1"}{...}
{viewerdialog "two-sample immediate" "dialog ttesti2"}{...}
{vieweralsosee "[R] ttest" "mansection R ttest"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bitest" "help bitest"}{...}
{vieweralsosee "[R] ci" "help ci"}{...}
{vieweralsosee "[MV] hotelling" "help hotelling"}{...}
{vieweralsosee "[R] mean" "help mean"}{...}
{vieweralsosee "[R] oneway" "help oneway"}{...}
{vieweralsosee "[R] prtest" "help prtest"}{...}
{vieweralsosee "[R] sdtest" "help sdtest"}{...}
{viewerjumpto "Syntax" "ttest##syntax"}{...}
{viewerjumpto "Description" "ttest##description"}{...}
{viewerjumpto "Options" "ttest##options"}{...}
{viewerjumpto "Examples" "ttest##examples"}{...}
{viewerjumpto "Saved results" "ttest##saved_results"}{...}
{viewerjumpto "References" "ttest##references"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{manlink R ttest} {hline 2}}Mean-comparison tests{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
One-sample mean-comparison test

{p 8 14 2}
{cmd:ttest}
{varname}
{cmd:==}
{it:#}
{ifin}
[{cmd:,} {opt l:evel(#)}]


{pstd}
Two-sample mean-comparison test (unpaired)

{p 8 14 2}
{cmd:ttest}
{varname:1}
{cmd:==}
{varname:2}
{ifin}{cmd:,}
{opt unp:aired}
[{opt une:qual}
{opt w:elch}
{opt l:evel(#)}]


{pstd}
Two-sample mean-comparison test (paired)

{p 8 14 2}
{cmd:ttest}
{varname:1}
{cmd:==}
{varname:2}
{ifin}
[{cmd:,} {opt l:evel(#)}]


{pstd}
Two-group mean-comparison test

{p 8 14 2}
{cmd:ttest}
{varname}
{ifin}
{cmd:,}
{opth by:(varlist:groupvar)}
[{it:{help ttest##options1:options1}}]


{pstd}
Immediate form of one-sample mean-comparison test

{p 8 14 2}
{cmd:ttesti}
{it:#obs}
{it:#mean}
{it:#sd}
{it:#val}
[{cmd:,}
{opt l:evel(#)}]


{pstd}
Immediate form of two-sample mean-comparison test

{p 8 14 2}
{cmd:ttesti}
{it:#obs1}
{it:#mean1}
{it:#sd1}
{it:#obs2}
{it:#mean2}
{it:#sd2}
[{cmd:,}
{it:{help ttest##options2:options2}}]


{synoptset 16 tabbed}{...}
{marker options1}{...}
{synopthdr:options1}
{synoptline}
{syntab:Main}
{p2coldent:* {opth by:(varlist:groupvar)}}variable defining the groups{p_end}
{synopt:{opt une:qual}}unpaired data have unequal variances{p_end}
{synopt:{opt w:elch}}use Welch's approximation{p_end}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synoptline}
{p 4 6 2}* {opt by(groupvar)} is required.{p_end}

{marker options2}{...}
{synopthdr:options2}
{synoptline}
{syntab:Main}
{synopt:{opt une:qual}}unpaired data have unequal variances{p_end}
{synopt:{opt w:elch}}use Welch's approximation{p_end}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

    {title:one-sample}

{phang2}
{bf:Statistics > Summaries, tables, and tests > Classical tests of hypotheses}
       {bf:> One-sample mean-comparison test}

    {title:two-sample, unpaired}

{phang2}
{bf:Statistics > Summaries, tables, and tests > Classical tests of hypotheses}
        {bf:> Two-sample mean-comparison test}

    {title:two-sample, paired}

{phang2}
{bf:Statistics > Summaries, tables, and tests > Classical tests of hypotheses}
        {bf:> Mean-comparison test, paired data}

    {title:two-group}

{phang2}
{bf:Statistics > Summaries, tables, and tests > Classical tests of hypotheses}
         {bf:> Two-group mean-comparison test}

    {title:immediate command: one-sample}

{phang2}
{bf:Statistics > Summaries, tables, and tests > Classical tests of hypotheses}
       {bf:> One-sample mean-comparison calculator}

    {title:immediate command: two-sample}

{phang2}
{bf:Statistics > Summaries, tables, and tests > Classical tests of hypotheses}
        {bf:> Two-sample mean-comparison calculator}


{marker description}{...}
{title:Description}

{pstd}
{opt ttest} performs t tests on the equality of means.  In the first form,
{opt ttest} tests that {varname} has a mean of {it:#}.
In the second form, {opt ttest} tests that {it:varname1} and {it:varname2}
have the same mean, assuming unpaired data.
In the third form, {opt ttest} tests that {it:varname1} and {it:varname2}
have the same mean, assuming paired data.
In the fourth form, {opt ttest} tests that {it:varname} has the same mean
within the two groups defined by {it:{help varlist:groupvar}}.

{pstd}
{opt ttesti} is the immediate form of {opt ttest}; see {help immed}.

{pstd}
For the equivalent of a two-sample t test with sampling weights
({opt pweight}s), use the {cmd:svy:} {helpb mean} command with the {opt over()}
option, and then use {helpb lincom}; also see
{manhelp svy_postestimation SVY:svy postestimation}.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opth by:(varlist:groupvar)} specifies the {it:groupvar} that defines the two
groups that {opt ttest} will use to test the hypothesis that their means are
equal.  Specifying {opt by(groupvar)} implies an unpaired (two sample) t test.
Do not confuse the {opt by()} option with the {cmd:by} prefix; you can specify
both.

{phang}
{opt unpaired} specifies that the data be treated as unpaired.  The
   {opt unpaired} option is used when the two set of values to be compared are
   in different variables.

{phang}
{opt unequal} specifies that the unpaired data not be assumed to have equal
   variances.

{phang}
{opt welch} specifies that the approximate degrees of freedom for the test
   be obtained from Welch's formula
   ({help ttest##W1947:1947}) rather than Satterthwaite's approximation
   formula ({help ttest##S1946:1946}), which is the default when {opt unequal}
   is specified.  Specifying {opt welch} implies {opt unequal}.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for confidence
   intervals.  The default is {cmd:level(95)} or as set by {helpb set level}.


{marker examples}{...}
{title:Examples}

    {cmd:. sysuse auto}             (setup)
    {cmd:. ttest mpg==20}           (one-sample mean-comparison test)

    {cmd:. webuse fuel}             (setup)
    {cmd:. ttest mpg1==mpg2}        (two-sample mean-comparison test)

    {cmd:. webuse fuel3}            (setup)
    {cmd:. ttest mpg, by(treated)}  (two-group mean-comparison test)

                              (no setup required)
    {cmd:. ttesti 24 62.6 15.8 75}  (immediate form; n=24, m=62.6, sd=15.8;
                                    test m=75)


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:ttest} and {cmd:ttesti} save the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N_1)}}sample size n_1{p_end}
{synopt:{cmd:r(N_2)}}sample size n_2{p_end}
{synopt:{cmd:r(p_l)}}lower one-sided p-value{p_end}
{synopt:{cmd:r(p_u)}}upper one-sided p-value{p_end}
{synopt:{cmd:r(p)}}two-sided p-value{p_end}
{synopt:{cmd:r(se)}}estimate of standard error{p_end}
{synopt:{cmd:r(t)}}t statistic{p_end}
{synopt:{cmd:r(sd_1)}}standard deviation for first variable{p_end}
{synopt:{cmd:r(sd_2)}}standard deviation for second variable{p_end}
{synopt:{cmd:r(sd)}}combined standard deviation{p_end}
{synopt:{cmd:r(mu_1)}}x_1 bar, mean for population 1{p_end}
{synopt:{cmd:r(mu_2)}}x_2 bar, mean for population 2{p_end}
{synopt:{cmd:r(df_t)}}degrees of freedom{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker S1946}{...}
{phang}
Satterthwaite, F. E. 1946.
An approximate distribution of estimates of variance components.
{it:Biometrics Bulletin} 2: 110-114.

{marker W1947}{...}
{phang}
Welch, B. L. 1947.
The generalization of `student's' problem when several different population
variances are involved. {it:Biometrika} 34: 28-35.
{p_end}

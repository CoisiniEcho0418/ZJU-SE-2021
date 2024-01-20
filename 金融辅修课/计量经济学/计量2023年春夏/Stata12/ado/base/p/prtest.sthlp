{smcl}
{* *! version 1.1.6  05may2011}{...}
{viewerdialog "one-sample" "dialog prtest1"}{...}
{viewerdialog "two-sample" "dialog prtest2"}{...}
{viewerdialog "two-sample, by()" "dialog prtestby"}{...}
{viewerdialog "" "--"}{...}
{viewerdialog "one-sample immediate" "dialog prtesti1"}{...}
{viewerdialog "two-sample immediate" "dialog prtesti2"}{...}
{vieweralsosee "[R] prtest" "mansection R prtest"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] bitest" "help bitest"}{...}
{vieweralsosee "[MV] hotelling" "help hotelling"}{...}
{vieweralsosee "[R] proportion" "help proportion"}{...}
{vieweralsosee "[R] ttest" "help ttest"}{...}
{viewerjumpto "Syntax" "prtest##syntax"}{...}
{viewerjumpto "Description" "prtest##description"}{...}
{viewerjumpto "Options" "prtest##options"}{...}
{viewerjumpto "Examples" "prtest##examples"}{...}
{viewerjumpto "Saved results" "prtest##saved_results"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink R prtest} {hline 2}}One- and two-sample tests of proportions{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
One-sample test of proportion

{p 8 15 2}
{cmd:prtest} {varname} {cmd:==} {it:#p} {ifin} [{cmd:,} {opt l:evel(#)}]


{phang}
Two-sample test of proportions

{p 8 15 2}
{cmd:prtest} {it:{help varname:varname1}} {cmd:==} {it:{help varname:varname2}}
    {ifin} [{cmd:,} {opt l:evel(#)}]


{phang}
Two-group test of proportions

{p 8 15 2}
{cmd:prtest} {varname} {ifin} {cmd:,} {opth "by(varlist:groupvar)"} [{opt l:evel(#)}]


{phang}
Immediate form of one-sample test of proportion

{p 8 16 2}
{cmd:prtesti} {it:#obs1} {it:#p1} {it:#p2} 
[{cmd:,} {opt l:evel(#)} {opt c:ount}]


{phang}
Immediate form of two-sample test of proportions

{p 8 16 2}{cmd:prtesti} {it:#obs1} {it:#p1} {it:#obs2} {it:#p2} 
[{cmd:,} {opt l:evel(#)} {opt c:ount}]


{phang}
{cmd:by} is allowed with {cmd:prtest}; see {manhelp by D}.


{title:Menu}

    {title:one-sample}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
    {bf:Classical tests of hypotheses > One-sample proportion test}

    {title:two-sample}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
     {bf:Classical tests of hypotheses > Two-sample proportion test}

    {title:two-group}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
     {bf:Classical tests of hypotheses > Two-group proportion test}

    {title:immediate command: one-sample}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
     {bf:Classical tests of hypotheses > One-sample proportion calculator}

    {title:immediate command: two-sample}

{phang2}
{bf:Statistics > Summaries, tables, and tests >}
     {bf:Classical tests of hypotheses > Two-sample proportion calculator}


{marker description}{...}
{title:Description}

{pstd}
{cmd:prtest} performs tests on the equality of proportions using
large-sample statistics.

{pstd}
In the first form, {cmd:prtest} tests that {varname} has a proportion of
{it:#p}.  In the second form, {cmd:prtest} tests that {it:varname1} and 
{it:varname2} have the same proportion.  In the third form, {cmd:prtest} tests
that {it:varname} has the same proportion within the two groups defined by
{it:{help varlist:groupvar}}.

{pstd}
{cmd:prtesti} is the immediate form of {cmd:prtest}; see {help immed}.

{pstd}
The {cmd:bitest} command is a better version of the first form of
{cmd:prtest} in that it gives exact p-values.  Researchers should use
{cmd:bitest} when possible, especially for small samples; see
{manhelp bitest R}.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opth "by(varlist:groupvar)"} specifies a numeric variable that contains the
group information for a given observation.  This variable must have only two
values.  Do not confuse the {opt by()} option with the {cmd:by} prefix; both
may be specified.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for
confidence intervals.  The default is {cmd:level(95)} or as set by 
{helpb set level}.

{phang}
{opt count} specifies that integer counts instead of proportions be used in
the immediate forms of {cmd:prtest}.  In the first syntax, {cmd:prtesti}
expects that {it:#obs1} and {it:#p1} are counts -- {it:#p1} {ul:<}
{it:#obs1} -- and {it:#p2} is a proportion.  In the second syntax,
{cmd:prtesti} expects that all four numbers are integer counts, that
{it:#obs1} {ul:>} {it:#p1}, and that {it:#obs2} {ul:>} {it:#p2}.


{marker examples}{...}
{title:Examples}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto}{p_end}

{phang}One-sample test of proportion{p_end}
{phang2}{cmd:. prtest foreign==.4}

    {hline}
    Setup
{phang2}{cmd:. webuse cure}{p_end}

{phang}Two-sample test of proportions{p_end}
{phang2}{cmd:. prtest cure1==cure2}

    {hline}
    Setup
{phang2}{cmd:. webuse cure2}{p_end}

{phang}{cmd:cure} has same proportion for males and females{p_end}
{phang2}{cmd:. prtest cure, by(sex)}

{phang}Immediate form of one-sample test of proportion{p_end}
{phang2}{cmd:. prtesti 50 .52 .70}{p_end}

{phang}First two numbers are counts{p_end}
{phang2}{cmd:. prtesti 30 4  .7, count}{p_end}

{phang}Immediate form of two-sample test of proportions{p_end}
{phang2}{cmd:. prtesti 30 .4  45 .67}{p_end}

{phang}All numbers are counts{p_end}
{phang2}{cmd:. prtesti 30 4  45 17, count}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:prtest} and {cmd:prtesti} save the following in {cmd:r()}:

{synoptset 10 tabbed}{...}
{p2col 4 10 14 2: Scalars}{p_end}
{synopt:{cmd:r(z)}}z statistic{p_end}
{synopt:{cmd:r(P_}{it:#}{cmd:)}}proportion for variable {it:#}{p_end}
{synopt:{cmd:r(N_}{it:#}{cmd:)}}number of observations for variable {it:#}{p_end}
{p2colreset}{...}

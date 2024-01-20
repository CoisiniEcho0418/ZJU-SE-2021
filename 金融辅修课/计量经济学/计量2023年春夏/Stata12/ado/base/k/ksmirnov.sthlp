{smcl}
{* *! version 1.1.1  11feb2011}{...}
{viewerdialog "one-sample" "dialog ksmirnov1"}{...}
{viewerdialog "two-sample" "dialog ksmirnov2"}{...}
{vieweralsosee "[R] ksmirnov" "mansection R ksmirnov"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] runtest" "help runtest"}{...}
{vieweralsosee "[R] sktest" "help sktest"}{...}
{vieweralsosee "[R] swilk" "help swilk"}{...}
{viewerjumpto "Syntax" "ksmirnov##syntax"}{...}
{viewerjumpto "Description" "ksmirnov##description"}{...}
{viewerjumpto "Options" "ksmirnov##options"}{...}
{viewerjumpto "Examples" "ksmirnov##examples"}{...}
{viewerjumpto "Saved results" "ksmirnov##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink R ksmirnov} {hline 2}}Kolmogorov-Smirnov equality-of-distributions test{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
One-sample Kolmogorov-Smirnov test

{p 8 17 2}
{cmd:ksmirnov} {varname} {cmd:=} {it:{help exp}} {ifin}


{phang}
Two-sample Kolmogorov-Smirnov test

{p 8 17 2}
{cmd:ksmirnov} {varname} {ifin} {cmd:,} {opth "by(varlist:groupvar)"}
 [{opt e:xact}]


{title:Menu}

    {title:one-sample}

{phang2}
{bf:Statistics > Nonparametric analysis > Tests of hypotheses >}
      {bf:One-sample Kolmogorov-Smirnov test}

    {title:two-sample}

{phang2}
{bf:Statistics > Nonparametric analysis > Tests of hypotheses >}
       {bf:Two-sample Kolmogorov-Smirnov test}


{marker description}{...}
{title:Description}

{pstd}
{cmd:ksmirnov} performs one- and two-sample Kolmogorov-Smirnov tests of the
equality of distributions.  In the first syntax, {varname} is the variable
whose distribution is being tested, and {it:{help exp}} must evaluate to the
corresponding (theoretical) cumulative.  In the second syntax, 
{it:{help varlist:groupvar}} must take on two distinct values.  The
distribution of {it:varname} for the first value of {it:groupvar} is compared
with that of the second value.

{pstd}
When testing for normality, please see {manhelp sktest R} and
{manhelp swilk R}.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opth "by(varlist:groupvar)"} is required.  It specifies a binary variable
that identifies the two groups.

{phang}
{opt exact} specifies that the exact p-value be computed.  This may take a
long time if n > 50.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse ksxmpl}{p_end}
{phang2}{cmd:. summarize x}{p_end}

{pstd}One-sample test{p_end}
{phang2}{cmd:. ksmirnov x = normal((x-r(mean))/r(sd))}{p_end}

{pstd}Two-sample test{p_end}
{phang2}{cmd:. ksmirnov x, by(group)}

{pstd}Two-sample test, exact value{p_end}
{phang2}{cmd:. ksmirnov x, by(group) exact}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:ksmirnov} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(D_1)}}D from line 1{p_end}
{synopt:{cmd:r(p_1)}}p-value from line 1{p_end}
{synopt:{cmd:r(D_2)}}D from line 2{p_end}
{synopt:{cmd:r(p_2)}}p-value from line 2{p_end}
{synopt:{cmd:r(D)}}combined D{p_end}
{synopt:{cmd:r(p)}}combined p-value{p_end}
{synopt:{cmd:r(p_cor)}}corrected combined p-value{p_end}
{synopt:{cmd:r(p_exact)}}exact combined p-value{p_end}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(group1)}}name of group from line 1{p_end}
{synopt:{cmd:r(group2)}}name of group from line 2{p_end}
{p2colreset}{...}

{smcl}
{* *! version 1.1.12  05may2011}{...}
{viewerdialog mvtest "dialog mvtest"}{...}
{vieweralsosee "[MV] mvtest correlations" "mansection MV mvtestcorrelations"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MV] canon" "help canon"}{...}
{vieweralsosee "[R] correlate" "help correlate"}{...}
{viewerjumpto "Syntax" "mvtest_correlations##syntax"}{...}
{viewerjumpto "Description" "mvtest_correlations##description"}{...}
{viewerjumpto "Options for multiple-sample tests" "mvtest_correlations##options_multi"}{...}
{viewerjumpto "Options for one-sample tests" "mvtest_correlations##options_one"}{...}
{viewerjumpto "Examples" "mvtest_correlations##examples"}{...}
{viewerjumpto "Saved results" "mvtest_correlations##saved_results"}{...}
{viewerjumpto "References" "mvtest_correlations##references"}{...}
{title:Title}

{p2colset 5 33 22 2}{...}
{p2col :{manlink MV mvtest correlations} {hline 2}}Multivariate tests of correlations{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
Multiple-sample tests

{p 8 15 2}
{cmd:mvtest} {cmdab:corr:elations} {varlist} {ifin} {weight}{cmd:,}
{opth by:(varlist:groupvars)}
[{help mvtest correlations##multisample_options:{it:multisample_options}}]


{pstd}
One-sample tests

{p 8 15 2}
{cmd:mvtest} {cmdab:corr:elations} {varlist} {ifin} {weight}{cmd:,}
[{help mvtest correlations##one-sample_options:{it:one-sample_options}}]


{synoptset 22 tabbed}{...}
{marker multisample_options}{...}
{synopthdr:multisample_options}
{synoptline}
{syntab:Model}
{p2coldent:* {opth by:(varlist:groupvars)}}compare subsamples with same
values in {it:groupvars}{p_end}
{synopt:{opt miss:ing}}treat missing values in {it:groupvars} as ordinary
values{p_end}
{synoptline}
{p 4 6 2}* {opt by(groupvars)} is required.

{synoptset 22 tabbed}{...}
{marker one-sample_options}{...}
{synopthdr:one-sample_options}
{synoptline}
{syntab:Options}
{synopt:{opt comp:ound}}test that correlation matrix is compound symmetric
	(equal correlations); the default{p_end}
{synopt:{opt e:quals(C)}}test that correlation matrix equals matrix {it:C}{p_end}
{synoptline}

{p 4 6 2}
{cmd:bootstrap}, {cmd:by}, {cmd:jackknife}, {cmd:rolling}, and {cmd:statsby}
are allowed; see {help prefix}.{p_end}
{p 4 6 2}
Weights are not allowed with the {helpb bootstrap} prefix.{p_end}
{p 4 6 2}
{cmd:aweight}s are not allowed with the {helpb jackknife} prefix.{p_end}
{p 4 6 2}
{cmd:aweight}s and {cmd:fweight}s are allowed; see {help weight}.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Multivariate analysis > MANOVA, multivariate regression,}
           {bf:and related > Multivariate test of means, covariances, and}
           {bf:normality}


{marker description}{...}
{title:Description}

{pstd}
{cmd:mvtest correlations} performs one-sample and multiple-sample tests on
correlations.  These tests assume multivariate normality.

{pstd}
See {manhelp mvtest MV} for more multivariate tests.


{marker options_multi}{...}
{title:Options for multiple-sample tests}

{dlgtab:Model}

{phang}
{opth by:(varlist:groupvars)} is required with the multiple-sample version of
the test.  Observations with the same values in {it:groupvars} form each
sample.  Observations with missing values in {it:groupvars} are ignored, unless
the {cmd:missing} option is specified.  A Wald test due to
{help mvtest correlations##J1970:Jennrich (1970)} is displayed.

{phang}
{opt missing} specifies that missing values in {it:groupvars} are treated like
ordinary values.


{marker options_one}{...}
{title:Options for one-sample tests}

{dlgtab:Options}

{phang}
{opt compound}, the default, tests the hypothesis that the correlation matrix
of the variables is compound symmetric, that is, that the correlations of all
variables in {it:varlist} are the same.  Lawley's
({help mvtest correlations##L1963:1963}) chi-squared test is displayed.

{phang}
{cmd:equals(}{it:C}{cmd:)} tests the hypothesis that the correlation
matrix of {it:varlist} is {it:C}.  The matrix {it:C}
should be k x k, symmetric, and positive definite.  {it:C} is converted to a
correlation matrix if needed.  The row and column names of {it:C} are
immaterial.  A Wald test due to 
{help mvtest correlations##J1970:Jennrich (1970)} is displayed.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse milktruck}{p_end}

{pstd}Test that the correlation matrix is compound symmetric (that is, that all
correlations are equal){p_end}
{phang2}{cmd:. mvtest correlations fuel repair capital, compound}{p_end}

{pstd}Test that the correlation matrix equals a given matrix{p_end}
{phang2}{cmd:. matrix C = (1, 0.75,0 \ 0.75, 1, 0 \ 0, 0, 1)}{p_end}
{phang2}{cmd:. mvtest correlations fuel repair capital, equals(C)}{p_end}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse genderpsych}{p_end}

{pstd}Test that the correlation matrices are equal for the groups{p_end}
{phang2}{cmd:. mvtest correlations y1 y2 y3 y4, by(gender)}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:mvtest correlations} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(chi2)}}chi-squared{p_end}
{synopt:{cmd:r(df)}}degrees of freedom for chi-squared test{p_end}
{synopt:{cmd:r(p_chi2)}}significance{p_end}

{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(chi2type)}}type of model chi-squared test{p_end}


{marker references}{...}
{title:References}

{marker J1970}{...}
{phang}
Jennrich, R. I. 1970. An asymptotic chi-squared test for the equality of two
correlation matrices.  {it:Journal of the American Statistical Association}
65: 904-912.

{marker L1963}{...}
{phang}
Lawley, D. N. 1963. On testing a set of correlation coefficients for equality.
{it:Annals of Mathematical Statistics} 34: 149-151.
{p_end}

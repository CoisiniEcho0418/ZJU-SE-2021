{smcl}
{* *! version 1.1.7  05may2011}{...}
{viewerdialog nptrend "dialog nptrend"}{...}
{vieweralsosee "[R] nptrend" "mansection R nptrend"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] epitab" "help epitab"}{...}
{vieweralsosee "[R] kwallis" "help kwallis"}{...}
{vieweralsosee "[R] signrank" "help signrank"}{...}
{vieweralsosee "[R] spearman" "help spearman"}{...}
{vieweralsosee "[ST] strate" "help strate"}{...}
{vieweralsosee "[R] symmetry" "help symmetry"}{...}
{viewerjumpto "Syntax" "nptrend##syntax"}{...}
{viewerjumpto "Description" "nptrend##description"}{...}
{viewerjumpto "Options" "nptrend##options"}{...}
{viewerjumpto "Example" "nptrend##example"}{...}
{viewerjumpto "Saved results" "nptrend##saved_results"}{...}
{viewerjumpto "References" "nptrend##references"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R nptrend} {hline 2}}Test for trend across ordered groups{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:nptrend} {varname} {ifin} {cmd:,} {opth by:(varlist:groupvar)}
[{opt nod:etail} {opt s:core(scorevar)}]


{title:Menu}

{phang}
{bf:Statistics > Nonparametric analysis > Tests of hypotheses >}
     {bf:Trend test across ordered groups}


{marker description}{...}
{title:Description}

{pstd}
{opt nptrend} performs the nonparametric test for trend across ordered groups
developed by {help nptrend##C1985:Cuzick (1985)}, which is an extension of the
Wilcoxon rank-sum test (see {helpb ranksum:[R] ranksum}).  A correction for
ties is incorporated into the test.  {opt nptrend} is a useful adjunct to the
Kruskal-Wallis test; see {helpb kwallis:[R] kwallis}.

{pstd}
If your data are not grouped, you can test for trend with the {cmd:signtest}
and {cmd:spearman} commands; see {manhelp signrank R} and
{manhelp spearman R}.  With
{cmd:signtest}, you can perform the Cox and Stuart test, a sign test applied to
differences between equally spaced observations of {it:varname}.
With {cmd:spearman}, you can perform the Daniels test, a test of zero Spearman
correlation between {it:varname} and a time index.  See
{help nptrend##C1999:Conover (1999, 169-175)} for a discussion of these tests
and their asymptotic relative efficiency.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opth by:(varlist:groupvar)} is required; it specifies the group on which the
data are to be ordered.

{phang}
{opt nodetail} suppresses the listing of group rank sums. 

{phang}
{opt score(scorevar)} defines scores for groups.  When it is not specified,
the values of {it:{help varlist:groupvar}} are used for the scores.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse sg}{p_end}

{pstd}Test for trend of increasing exposure across the 3 groups defined by
group{p_end}
{phang2}{cmd:. nptrend exposure, by(group)}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:nptrend} saves the following in {cmd:r()}:

{synoptset 10 tabbed}{...}
{p2col 5 10 14 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(p)}}two-sided p-value{p_end}
{synopt:{cmd:r(z)}}z statistic{p_end}
{synopt:{cmd:r(T)}}test statistic{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker C1999}{...}
{phang}
Conover, W. J. 1999.
{it:Practical Nonparametric Statistics}, 3rd ed.
New York: Wiley.

{marker C1985}{...}
{phang}
Cuzick, J. 1985. A Wilcoxon-type test for trend.
{it:Statistics in Medicine} 4: 87-90.
{p_end}

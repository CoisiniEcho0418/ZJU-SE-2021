{smcl}
{* *! version 1.2.5  11feb2011}{...}
{viewerdialog sktest "dialog sktest"}{...}
{vieweralsosee "[R] sktest" "mansection R sktest"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] diagnostic plots" "help diagnostic_plots"}{...}
{vieweralsosee "[R] ladder" "help ladder"}{...}
{vieweralsosee "[R] lv" "help lv"}{...}
{vieweralsosee "[MV] mvtest normality" "help mvtest_normality"}{...}
{vieweralsosee "[R] swilk" "help swilk"}{...}
{viewerjumpto "Syntax" "sktest##syntax"}{...}
{viewerjumpto "Description" "sktest##description"}{...}
{viewerjumpto "Option" "sktest##option"}{...}
{viewerjumpto "Example" "sktest##example"}{...}
{viewerjumpto "Saved results" "sktest##saved_results"}{...}
{viewerjumpto "References" "sktest##references"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col:{manlink R sktest} {hline 2}}Skewness and kurtosis test for
normality{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmd:sktest}
{varlist}
{ifin}
{weight}
[{cmd:,} {opt noa:djust}]

{p 4 6 2}
{opt aweight}s and {opt fweight}s are allowed; see {help weight}.


{title:Menu}

{phang}
{bf:Statistics > Summaries, tables, and tests >}
     {bf:Distributional plots and tests > Skewness and kurtosis normality test}


{marker description}{...}
{title:Description}

{pstd}
For each variable in {varlist}, {opt sktest} presents a test for
normality based on skewness and another based on kurtosis and then combines
the two tests into an overall test statistic.  {opt sktest} requires a minimum
of 8 observations to make its calculations.  See
{manhelp mvtest_normality MV:mvtest normality} for multivariate tests of
normality.


{marker option}{...}
{title:Option}

{dlgtab:Main}

{phang}
{opt noadjust} suppresses the empirical adjustment made by 
{help sktest##R1991:Royston (1991)}
to the overall chi-squared and its significance level and presents the
unaltered test as described by
{help sktest##DBD1990:D'Agostino, Balanger, and D'Agostino (1990)}.


{marker example}{...}
{title:Example}

{phang}{cmd:. sysuse auto}{p_end}
{phang}{cmd:. sktest mpg trunk}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:sktest} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(chi2)}}chi-squared{p_end}
{synopt:{cmd:r(P_skew)}}Pr(skewness){p_end}
{synopt:{cmd:r(P_kurt)}}Pr(kurtosis){p_end}
{synopt:{cmd:r(P_chi2)}}Prob > chi2{p_end}
{p2colreset}{...}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:r(N)}}matrix of observations{p_end}
{synopt:{cmd:r(Utest)}}matrix of test results, one row per variable{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker DBD1990}{...}
{phang}
D'Agostino, R. B., A. J. Belanger, and R. B. D'Agostino Jr. 1990.
A suggestion for using powerful and informative tests of normality.
{it:American Statistician} 44: 316-321.

{marker R1991}{...}
{phang}
Royston, P. 1991. sg3.5: Comment on sg3.4 and an improved D'Agostino test.
{browse "http://www.stata.com/products/stb/journals/stb3.pdf":{it:Stata Technical Bulletin} 3}: 23-24.
Reprinted in {it:Stata Technical Bulletin Reprints}, vol. 1, pp. 110-112.
College Station, TX: Stata Press.
{p_end}

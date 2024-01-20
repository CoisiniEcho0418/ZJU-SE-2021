{smcl}
{* *! version 1.1.5  11feb2011}{...}
{viewerdialog signrank "dialog signrank"}{...}
{viewerdialog signtest "dialog signtest"}{...}
{vieweralsosee "[R] signrank" "mansection R signrank"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] ranksum" "help ranksum"}{...}
{vieweralsosee "[R] ttest" "help ttest"}{...}
{viewerjumpto "Syntax" "signrank##syntax"}{...}
{viewerjumpto "Description" "signrank##description"}{...}
{viewerjumpto "Examples" "signrank##examples"}{...}
{viewerjumpto "Saved results" "signrank##saved_results"}{...}
{viewerjumpto "References" "signrank##references"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink R signrank} {hline 2}}Equality tests on matched data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Wilcoxon matched-pairs signed-ranks test

{p 8 20 2} 
{cmd:signrank} {varname} {cmd:=} {it:{help exp}} {ifin} 


{phang}
Sign test of matched pairs

{p 8 20 2}
{cmd:signtest} {varname} {cmd:=} {it:{help exp}} {ifin} 


{phang}
{cmd:by} is allowed with {cmd:signrank} and {cmd:signtest}; see
{manhelp by D}. 


{title:Menu}

    {title:signrank}

{phang2}
{bf:Statistics > Nonparametric analysis > Tests of hypotheses >}
     {bf:Wilcoxon matched-pairs signed-rank test}

     {title:signtest}

{phang2}
{bf:Statistics > Nonparametric analysis > Tests of hypotheses >}
       {bf:Test equality of matched pairs}


{marker description}{...}
{title:Description}

{pstd}
{cmd:signrank} tests the equality of matched pairs of observations by using the
Wilcoxon matched-pairs signed-ranks test
({help signrank##W1945:Wilcoxon 1945}).  The null hypothesis
is that both distributions are the same.

{pstd}
{cmd:signtest} also tests the equality of matched pairs of observations
({help signrank##A1710:Arbuthnott [1710]}, but better explained by
{help signrank##SC1989:Snedecor and Cochran [1989]}) by
calculating the difference between {varname} and the expression.  The null
hypothesis is that the median of the differences is zero; no further
assumptions are made about the distributions.  This, in turn, is equivalent to
the hypothesis that the true proportion of positive (negative) signs is
one-half.

{pstd}
For equality tests on unmatched data, see {manhelp ranksum R}.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. webuse fuel}{p_end}
{phang}{cmd:. signrank mpg1 = mpg2}{p_end}
{phang}{cmd:. signtest mpg1 = mpg2}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:signrank} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N_neg)}}number of negative comparisons{p_end}
{synopt:{cmd:r(N_pos)}}number of positive comparisons{p_end}
{synopt:{cmd:r(N_tie)}}number of tied comparisons{p_end}
{synopt:{cmd:r(sum_pos)}}sum of the positive ranks{p_end}
{synopt:{cmd:r(sum_neg)}}sum of the negative ranks{p_end}
{synopt:{cmd:r(z)}}z statistic{p_end}
{synopt:{cmd:r(Var_a)}}adjusted variance{p_end}

{pstd}
{cmd:signtest} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N_neg)}}number of negative comparisons{p_end}
{synopt:{cmd:r(N_pos)}}number of positive comparisons{p_end}
{synopt:{cmd:r(N_tie)}}number of tied comparisons{p_end}
{synopt:{cmd:r(p_2)}}two-sided probability{p_end}
{synopt:{cmd:r(p_neg)}}one-sided probability of negative comparison{p_end}
{synopt:{cmd:r(p_pos)}}one-sided probability of positive comparison{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker A1710}{...}
{phang}
Arbuthnott, J. 1710. An argument for divine providence, taken from the
constant regularity observed in the births of both sexes.
{it:Philosophical Transaction of the Royal Society of London} 27: 186-190.

{marker SC1989}{...}
{phang}
Snedecor, G. W., and W. G. Cochran. 1989. {it:Statistical Methods}. 8th ed.
Ames, IA: Iowa State University Press.

{marker W1945}{...}
{phang}
Wilcoxon, F. 1945. Individual comparisons by ranking methods.
{it:Biometrics} 1: 80-83.
{p_end}

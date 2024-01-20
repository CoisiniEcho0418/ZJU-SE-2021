{smcl}
{* *! version 1.1.8  05may2011}{...}
{viewerdialog ranksum "dialog ranksum"}{...}
{viewerdialog median "dialog median"}{...}
{vieweralsosee "[R] ranksum" "mansection R ranksum"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] signrank" "help signrank"}{...}
{vieweralsosee "[R] ttest" "help ttest"}{...}
{viewerjumpto "Syntax" "ranksum##syntax"}{...}
{viewerjumpto "Description" "ranksum##description"}{...}
{viewerjumpto "Options for ranksum" "ranksum##options_ranksum"}{...}
{viewerjumpto "Options for median" "ranksum##options_median"}{...}
{viewerjumpto "Examples" "ranksum##examples"}{...}
{viewerjumpto "Saved results" "ranksum##saved_results"}{...}
{viewerjumpto "References" "ranksum##references"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R ranksum} {hline 2}}Equality tests on unmatched data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Wilcoxon rank-sum test

{p 8 19 2}
{cmd:ranksum} {varname} {ifin}{cmd:,}
    {cmd:by(}{it:{help varlist:groupvar}}{cmd:)} [{cmd:porder}]


{phang}
Nonparametric equality-of-medians test

{p 8 18 2}
{cmd:median} {varname} {ifin} {weight}{cmd:,}
     {cmd:by(}{it:{help varlist:groupvar}}{cmd:)}
[{it:{help ranksum##median_options:median_options}}]


{synoptset 21 tabbed}{...}
{synopthdr:ranksum_options}
{synoptline}
{syntab:Main}
{p2coldent:* {opth by:(varlist:groupvar)}}grouping variable{p_end}
{synopt :{opt porder}}probability that variable for first group is larger than
variable for second group{p_end}
{synoptline}

{marker median_options}{...}
{synopthdr:median_options}
{synoptline}
{syntab:Main}
{p2coldent:* {opth by:(varlist:groupvar)}}grouping variable{p_end}
{synopt :{opt e:xact}}performs Fisher's exact test{p_end}
{synopt :{cmdab:med:ianties(below)}}assign values equal to the median to below
group{p_end}
{synopt :{cmdab:med:ianties(above)}}assign values equal to the median to above
group{p_end}
{synopt :{cmdab:med:ianties(drop)}}drop values equal to the median from the
analysis{p_end}
{synopt :{cmdab:med:ianties(split)}}split values equal to the median equally
between the two groups{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}* {opt by(groupvar)} is required.{p_end}
{p 4 6 2}{opt by} is allowed with {cmd:ranksum} and {cmd:median};
see {manhelp by D}.{p_end}
{p 4 6 2}{opt fweight}s are allowed with {cmd:median}; see 
{help weight}.{p_end}


{title:Menu}

    {title:ranksum}

{phang2}
{bf:Statistics > Nonparametric analysis > Tests of hypotheses >}
        {bf:Wilcoxon rank-sum test}

    {title:median}

{phang2}
{bf:Statistics > Nonparametric analysis > Tests of hypotheses >}
        {bf:K-sample equality-of-medians test}


{marker description}{...}
{title:Description}

{pstd}
{cmd:ranksum} tests the hypothesis that two independent samples (that is,
unmatched data) are from populations with the same distribution by using the
Wilcoxon rank-sum test, which is also known as the Mann-Whitney two-sample
statistic
({help ranksum##W1945:Wilcoxon 1945};
 {help ranksum##MW1947:Mann and Whitney 1947}).

{pstd}
{cmd:median} performs a nonparametric K-sample test on the equality of
medians.  It tests the null hypothesis that the K samples were drawn from
populations with the same median.  For two samples, the
chi-squared test statistic is computed both with and without a continuity
correction.

{pstd}
{cmd:ranksum} and {cmd:median} are for use with unmatched data.  For
equality tests on matched data, see {manhelp signrank R}.


{marker options_ranksum}{...}
{title:Options for ranksum}

{dlgtab:Main}

{phang}
{cmd:by(}{it:{help varlist:groupvar}}{cmd:)} is required.  It specifies the
name of the grouping variable.

{phang}
{opt porder} displays an estimate of the probability that a random draw from
the first population is larger than a random draw from the second 
population.


{marker options_median}{...}
{title:Options for median}

{dlgtab:Main}

{phang}
{cmd:by(}{it:{help varlist:groupvar}}{cmd:)} is required.  It specifies the
name of the grouping variable.

{phang}
{opt exact} displays the significance calculated by Fisher's exact test.  For
two samples, both one- and two-sided probabilities are displayed.

{phang}
{cmd:medianties(below}|{opt above}|{opt drop}|{opt split)} specifies how
values equal to the overall median are to be handled.  The {cmd:median} test
computes the median for {varname} by using all observations and then divides
the observations into those falling above the median and those falling below
the median.  When values for an observation are equal to the sample median,
they can be dropped from the analysis by specifying {cmd:medianties(drop)};
added to the group above or below the median by specifying
{cmd:medianties(above)} or {cmd:medianties(below)}, respectively; or if there
is more than 1 observation with values equal to the median, they can be
equally divided into the two groups by specifying {cmd:medianties(split)}.  If
this option is not specified, {cmd:medianties(below)} is assumed.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse fuel2}{p_end}

{pstd}Perform rank-sum test on {cmd:mpg} by using the two groups defined by
{cmd:treat}{p_end}
{phang2}{cmd:. ranksum mpg, by(treat)}{p_end}

{pstd}Same as above, but include estimate of probability that the value of
{cmd:mpg} for an observation with {cmd:treat} = 0 is greater than the value of
{cmd:mpg} for an observation with {cmd:treat} = 1{p_end}
{phang2}{cmd:. ranksum mpg, by(treat) porder}{p_end}

{pstd}Perform Pearson chi-squared test of the equality of the medians of
{cmd:mpg} between the two groups defined by {cmd:treat}{p_end}
{phang2}{cmd:. median mpg, by(treat)}{p_end}

{pstd}Perform Fisher's exact test of the equality of the medians of {cmd:mpg}
between the two groups defined by {cmd:treat}{p_end}
{phang2}{cmd:. median mpg, by(treat) exact}{p_end}

    {hline}
    Setup
{phang2}{cmd:. webuse medianxmpl}{p_end}

{pstd}Perform Pearson chi-squared test of the equality of the medians of
{cmd:age} between the two groups defined by {cmd:gender}{p_end}
{phang2}{cmd:. median age, by(gender)}{p_end}

{pstd}Same as above command{p_end}
{phang2}{cmd:. median age, by(gender) medianties(below)}{p_end}

{pstd}Same as above command, but for observations with values of {cmd:age}
equal to the median, put them in the group above the median{p_end}
{phang2}{cmd:. median age, by(gender) medianties(above)}{p_end}

{pstd}Same as above command, but drop observations with values of {cmd:age}
equal to the median{p_end}
{phang2}{cmd:. median age, by(gender) medianties(drop)}{p_end}

{pstd}Same as above command, but for observations with values of {cmd:age}
equal to the median, divide them equally between the two groups{p_end}
{phang2}{cmd:. median age, by(gender) medianties(split)}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:ranksum} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N_1)}}sample size n_1{p_end}
{synopt:{cmd:r(N_2)}}sample size n_2{p_end}
{synopt:{cmd:r(z)}}z statistic{p_end}
{synopt:{cmd:r(Var_a)}}adjusted variance{p_end}
{synopt:{cmd:r(group1)}}value of variable for first group{p_end}
{synopt:{cmd:r(sum_obs)}}actual sum of ranks for first group{p_end}
{synopt:{cmd:r(sum_exp)}}expected sum of ranks for first group{p_end}
{synopt:{cmd:r(porder)}}probability that draw from first population is larger
              than draw from second population{p_end}

{pstd}
{cmd:median} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}sample size{p_end}
{synopt:{cmd:r(chi2)}}Pearson's chi-squared{p_end}
{synopt:{cmd:r(p)}}significance of Pearson's chi-squared{p_end}
{synopt:{cmd:r(p_exact)}}Fisher's exact p{p_end}
{synopt:{cmd:r(groups)}}number of groups compared{p_end}
{synopt:{cmd:r(chi2_cc)}}continuity-corrected Pearson's chi-squared{p_end}
{synopt:{cmd:r(p_cc)}}continuity-corrected significance{p_end}
{synopt:{cmd:r(p1_exact)}}one-sided Fisher's exact p{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker MW1947}{...}
{phang}
Mann, H. B., and D. R. Whitney. 1947. On a test whether one of two random
variables is stochastically larger than the other.
{it:Annals of Mathematical Statistics} 18: 50-60.

{marker W1945}{...}
{phang}
Wilcoxon, F. 1945. Individual comparisons by ranking methods.
{it:Biometrics} 1: 80-83.
{p_end}

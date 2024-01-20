{smcl}
{* *! version 1.1.4  14mar2011}{...}
{viewerdialog loneway "dialog loneway"}{...}
{vieweralsosee "[R] loneway" "mansection R loneway"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] anova" "help anova"}{...}
{vieweralsosee "[R] oneway" "help oneway"}{...}
{viewerjumpto "Syntax" "loneway##syntax"}{...}
{viewerjumpto "Description" "loneway##description"}{...}
{viewerjumpto "Options" "loneway##options"}{...}
{viewerjumpto "Examples" "loneway##examples"}{...}
{viewerjumpto "Saved results" "loneway##saved_results"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R loneway} {hline 2}}Large one-way ANOVA, random effects, and reliability{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:loneway} {it:response_var} {it:group_var} {ifin} {weight} [{cmd:,} {it:options}]

{synoptset 12 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Main}
{synopt :{opt mea:n}}expected value of F distribution; default is 1{p_end}
{synopt :{opt med:ian}}median of F distribution; default is 1{p_end}
{synopt :{opt ex:act}}exact confidence intervals (groups must be equal with no
weights){p_end}
{synopt :{opt l:evel(#)}}set confidence level; default is
{cmd:level(95)}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}{opt by} is allowed; see {manhelp by D}.{p_end}
{p 4 6 2}{cmd:aweight}s are allowed; see {help weight}.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Linear models and related > ANOVA/MANOVA > Large one-way ANOVA}


{marker description}{...}
{title:Description}

{pstd}
{cmd:loneway} fits one-way analysis-of-variance (ANOVA) models on datasets with
many levels of {it:group_var} and presents different ancillary
statistics from {cmd:oneway} (see {helpb oneway:[R] oneway}):

	Feature{col 52}{cmd:oneway  loneway}
	{hline 60}
	Fit one-way model{col 55}x       x
	     on fewer than 376 levels{col 55}x       x
	     on more than 376 levels{col 63}x
	Bartlett's test for equal variance{col 55}x
	Multiple-comparison tests{col 55}x
	Intragroup correlation and SE{col 63}x
	Intragroup correlation confidence interval{col 63}x
	Est. reliability of group-averaged score{col 63}x
	Est. SD of group effect{col 63}x
	Est. SD within group{col 63}x


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt mean} specifies that the expected value of the F distribution with
k-1 and N-k degrees of freedom be used as the reference point in the
estimation of rho instead of the default value of 1.

{phang}
{opt median} specifies that the median of the F distribution with k-1 and N-k
degrees of freedom be used as the reference point in the estimation of rho
instead of the default value of 1.

{phang}
{opt exact} requests that exact confidence intervals be computed, as opposed
to the default asymptotic confidence intervals.  This option is allowed only
if the groups are equal in size and weights are not used.

{phang}
{opt level(#)} specifies the confidence level, as a percentage, for
confidence intervals of the coefficients.  The default is {cmd:level(95)} or as
set by {helpb set level}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse auto7}{p_end}

{pstd}Fit one-way random-effects ANOVA{p_end}
{phang2}{cmd:. loneway mpg manufacturer_grp}{p_end}

{pstd}Fit ANOVA to subset of the data{p_end}
{phang2}{cmd:. loneway mpg manufacturer_grp if nummake==4}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:loneway} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(rho)}}intraclass correlation{p_end}
{synopt:{cmd:r(lb)}}lower bound of 95% CI for rho{p_end}
{synopt:{cmd:r(ub)}}upper bound of 95% CI for rho{p_end}
{synopt:{cmd:r(rho_t)}}estimated reliability{p_end}
{synopt:{cmd:r(se)}}asymp. SE of intraclass correlation{p_end}
{synopt:{cmd:r(sd_w)}}estimated SD within group{p_end}
{synopt:{cmd:r(sd_b)}}estimated SD of group effect{p_end}
{p2colreset}{...}

{smcl}
{* *! version 1.2.4  04apr2011}{...}
{vieweralsosee "[D] functions" "mansection D functions"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] egen" "help egen"}{...}
{viewerjumpto "Description" "density functions##description"}{...}
{viewerjumpto "Probability distributions and density functions" "density functions##functions"}{...}
{viewerjumpto "References" "density functions##references"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink D functions} {hline 2}}Functions{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}This is a quick reference for the probability distributions and density
functions.  For help on all functions, see {manhelp functions D}.


{marker functions}{...}
{title:Probability distributions and density functions}

{pstd}
The probability distribution and density functions are organized under the
following headings:

{phang2}{help density_functions##beta:Beta and noncentral beta distributions}{p_end}
{phang2}{help density_functions##binomial:Binomial distribution}{p_end}
{phang2}{help density_functions##chisquare:Chi-squared and noncentral chi-squared distributions}{p_end}
{phang2}{help density_functions##dunnett:Dunnett's multiple range distribution}{p_end}
{phang2}{help density_functions##F:F and noncentral F distributions}{p_end}
{phang2}{help density_functions##gamma:Gamma distribution}{p_end}
{phang2}{help density_functions##hypergeometric:Hypergeometric distribution}{p_end}
{phang2}{help density_functions##negative_binomial:Negative binomial distribution}{p_end}
{phang2}{help density_functions##normal:Normal (Gaussian), log of the normal, and binormal distributions}{p_end}
{phang2}{help density_functions##poisson:Poisson distribution}{p_end}
{phang2}{help random_number_functions:Random-number functions}{p_end}
{phang2}{help density_functions##t:Student's t distribution}{p_end}
{phang2}{help density_functions##tukey:Tukey's Studentized range distribution}{p_end}


{marker beta}{...}
{title:Beta and noncentral beta distributions}

INCLUDE help f_ibeta

INCLUDE help f_betaden

INCLUDE help f_ibetatail

INCLUDE help f_invibeta

INCLUDE help f_invibetatail

INCLUDE help f_nibeta

INCLUDE help f_nbetaden

INCLUDE help f_invnibeta


{marker binomial}{...}
{title:Binomial distribution}

INCLUDE help f_binomial

INCLUDE help f_binomialp

INCLUDE help f_binomialtail

INCLUDE help f_invbinomial

INCLUDE help f_invbinomialtail


{marker chisquare}{...}
{title:Chi-squared and noncentral chi-squared distributions}

INCLUDE help f_chi2

INCLUDE help f_chi2tail

INCLUDE help f_invchi2

INCLUDE help f_invchi2tail

INCLUDE help f_nchi2

INCLUDE help f_invnchi2

INCLUDE help f_npnchi2


{marker dunnett}{...}
{title:Dunnett's multiple range}

INCLUDE help f_dunnettprob

INCLUDE help f_invdunnettprob


{marker F}{...}
{title:F and noncentral F distributions}

INCLUDE help f_f

INCLUDE help f_fden

INCLUDE help f_ftail

INCLUDE help f_invf

INCLUDE help f_invftail

INCLUDE help f_nfden

INCLUDE help f_nftail

INCLUDE help f_invnftail


{marker gamma}{...}
{title:Gamma distribution}

INCLUDE help f_gammap

INCLUDE help f_gammaden

INCLUDE help f_gammaptail

INCLUDE help f_invgammap

INCLUDE help f_invgammaptail

INCLUDE help f_dgammapda

INCLUDE help f_dgammapdada

INCLUDE help f_dgammapdadx

INCLUDE help f_dgammapdx

INCLUDE help f_dgammapdxdx


{marker hypergeometric}
{title:Hypergeometric distribution}

INCLUDE help f_hypergeometric

INCLUDE help f_hypergeometricp


{marker negative_binomial}{...}
{title:Negative binomial distribution}

INCLUDE help f_nbinomial

INCLUDE help f_nbinomialp

INCLUDE help f_nbinomialtail

INCLUDE help f_invnbinomial

INCLUDE help f_invnbinomialtail


{marker normal}{...}
{title:Normal (Gaussian), log of the normal, and binormal distributions}

INCLUDE help f_binormal

INCLUDE help f_normal

INCLUDE help f_normalden

INCLUDE help f_invnormal

INCLUDE help f_lnnormal

INCLUDE help f_lnnormalden


{marker poisson}{...}
{title:Poisson distribution}

INCLUDE help f_poisson

INCLUDE help f_poissonp

INCLUDE help f_poissontail

INCLUDE help f_invpoisson

INCLUDE help f_invpoissontail


{marker t}{...}
{title:Student's t distribution}

INCLUDE help f_tden

INCLUDE help f_ttail

INCLUDE help f_invttail


{marker tukey}{...}
{title:Tukey's Studentized range}

INCLUDE help f_tukeyprob

INCLUDE help f_invtukeyprob


{marker references}{...}
{title:References}

{marker HGL1970}{...}
{phang}
Haynam, G. E., Z. Govindarajulu, and F. C. Leone.  1970.
Tables of the cumulative noncentral chi-square distribution.
In Vol. 1 of {it:Selected Tables in Mathematical Statistics},
ed. H. L. Harter and D. B. Owen, 1-78.
Providence, RI: American Mathematical Society.

{marker JKB1995}{...}
{phang}
Johnson, N. L., S. Kotz, and N. Balakrishnan.  1995.
{it:Continuous Univariate Distributions, Vol. 2}.  2nd ed.  New York: Wiley.

{marker M1981}{...}
{phang}
Miller, R. G., Jr.  1981.
{it:Simultaneous Statistical Inference}.  2nd ed.  New York: Springer.
{p_end}

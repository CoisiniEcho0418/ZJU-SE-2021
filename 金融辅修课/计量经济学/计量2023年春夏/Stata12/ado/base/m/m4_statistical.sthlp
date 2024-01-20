{smcl}
{* *! version 1.2.7  21apr2011}{...}
{vieweralsosee "[M-4] statistical" "mansection M-4 statistical"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] intro" "help m4_intro"}{...}
{viewerjumpto "Contents" "m4_statistical##contents"}{...}
{viewerjumpto "Description" "m4_statistical##description"}{...}
{viewerjumpto "Remarks" "m4_statistical##remarks"}{...}
{title:Title}

{phang}
{manlink M-4 statistical} {hline 2} Statistical functions


{marker contents}{...}
{title:Contents}

{col 5}   [M-5]
{col 5}Manual entry{col 20}Function{col 39}Purpose
{col 5}{hline}

{col 5}   {c TLC}{hline 23}{c TRC}
{col 5}{hline 3}{c RT}{it: Pseudorandom variates }{c LT}{hline}
{col 5}   {c BLC}{hline 23}{c BRC}

{col 5}{bf:{help mf_runiform:runiform()}}{...}
{col 20}{cmd:runiform()}{...}
{col 39}uniform pseudorandom variates
{col 20}{cmd:rseed()}{...}
{col 39}obtain or set the random-variate
{col 39}generator seed
{col 20}{hline 10}
{col 20}{cmd:rbeta()}{...}
{col 39}beta pseudorandom variates
{col 20}{cmd:rbinomial()}{...}
{col 39}binomial pseudorandom variates
{col 20}{cmd:rchi2()}{...}
{col 39}chi-squared pseudorandom variates
{col 20}{cmd:rdiscrete()}{...}
{col 39}discrete pseudorandom variates
{col 20}{cmd:rgamma()}{...}
{col 39}gamma pseudorandom variates
{col 20}{cmd:rhypergeometric()}{...}
{col 39}hypergeometric pseudorandom variates
{col 20}{cmd:rnbinomial()}{...}
{col 39}negative binomial pseudorandom variates
{col 20}{cmd:rnormal()}{...}
{col 39}normal (Gaussian) pseudorandom variates
{col 20}{cmd:rpoisson()}{...}
{col 39}Poisson pseudorandom variates
{col 20}{cmd:rt()}{...}
{col 39}Student's t pseudorandom variates

{col 5}   {c TLC}{hline 34}{c TRC}
{col 5}{hline 3}{c RT}{it: Means, variances, & correlations }{c LT}{hline}
{col 5}   {c BLC}{hline 34}{c BRC}

{col 5}{bf:{help mf_mean:mean()}}{...}
{col 20}{cmd:mean()}{...}
{col 39}mean 
{col 20}{cmd:variance()}{...}
{col 39}variance 
{col 20}{cmd:quadvariance()}{...}
{col 39}quad-precision variance 
{col 20}{cmd:meanvariance()}{...}
{col 39}mean and variance
{col 20}{cmd:quadmeanvariance()}{...}
{col 39}quad-precision mean and variance
{col 20}{cmd:correlation()}{...}
{col 39}correlation
{col 20}{cmd:quadcorrelation()}{...}
{col 39}quad-precision correlation

{col 5}{bf:{help mf_cross:cross()}}{...}
{col 20}{cmd:cross()}{...}
{col 39}{it:X}'{it:X}, {it:X}'{it:Z}, {it:X}'diag({it:w}){it:Z}, etc.

{col 5}{bf:{help mf_corr:corr()}}{...}
{col 20}{cmd:corr()}{...}
{col 39}make correlation from variance matrix 

{col 5}{bf:{help mf_crossdev:crossdev()}}{...}
{col 20}{cmd:crossdev()}{...}
{col 39}({it:X}:-{it:x})'({it:X}:-{it:x}), ({it:X}:-{it:x})'({it:Z}:-{it:z}), etc.

{col 5}{bf:{help mf_quadcross:quadcross()}}{...}
{col 20}{cmd:quadcross()}{...}
{col 39}quad-precision {cmd:cross()}
{col 20}{cmd:quadcrossdev()}{...}
{col 39}quad-precision {cmd:crossdev()}

{col 5}   {c TLC}{hline 26}{c TRC}
{col 5}{hline 3}{c RT}{it: Factorial & combinations }{c LT}{hline}
{col 5}   {c BLC}{hline 26}{c BRC}

{col 5}{bf:{help mf_factorial:factorial()}}{...}
{col 20}{cmd:factorial()}{...}
{col 39}factorial
{col 20}{cmd:lnfactorial()}{...}
{col 39}natural logarithm of factorial
{col 20}{cmd:gamma()}{...}
{col 39}gamma function
{col 20}{cmd:lngamma()}{...}
{col 39}natural logarithm of gamma function
{col 20}{cmd:digamma()}{...}
{col 39}derivative of {cmd:lngamma()}
{col 20}{cmd:trigamma()}{...}
{col 39}second derivative of {cmd:lngamma()}

{col 5}{bf:{help mf_comb:comb()}}{...}
{col 20}{cmd:comb()}{...}
{col 39}combinatorial function {it:n} choose {it:k}

{col 5}{bf:{help mf_cvpermute:cvpermute()}}{...}
{col 20}{cmd:cvpermutesetup()}{...}
{col 39}permutation setup
{col 20}{cmd:cvpermute()}{...}
{col 39}return permutations, one at a time

{col 5}   {c TLC}{hline 27}{c TRC}
{col 5}{hline 3}{c RT}{it: Densities & distributions }{c LT}{hline}
{col 5}   {c BLC}{hline 27}{c BRC}

{col 5}{bf:{help mf_normal:normal()}}{...}
{col 20}{cmd:normalden()}{...}
{col 39}normal density
{col 20}{cmd:normal()}{...}
{col 39}cumulative normal dist.
{col 20}{cmd:invnormal()}{...}
{col 39}inverse cumulative normal
{col 20}{cmd:lnnormalden()}{...}
{col 39}logarithm of the normal density
{col 20}{cmd:lnnormal()}{...}
{col 39}logarithm of the cumulative normal dist.
{col 20}{hline 10}
{col 20}{cmd:binormal()}{...}
{col 39}cumulative binormal dist.
{col 20}{hline 10}
{col 20}{cmd:betaden()}{...}
{col 39}beta density
{col 20}{cmd:ibeta()}{...}
{col 39}cumulative beta dist.;
{col 39}  a.k.a. incomplete beta function
{col 20}{cmd:ibetatail()}{...}
{col 39}reverse cumulative beta dist.
{col 20}{cmd:invibeta()}{...}
{col 39}inverse cumulative beta
{col 20}{cmd:invibetatail()}{...}
{col 39}inverse reverse cumulative beta
{col 20}{hline 10}
{col 20}{cmd:binomialp()}{...}
{col 39}binomial probability
{col 20}{cmd:binomial()}{...}
{col 39}cumulative of binomial
{col 20}{cmd:binomialtail()}{...}
{col 39}reverse cumulative of binomial
{col 20}{cmd:invbinomial()}{...}
{col 39}inverse binomial (lower tail)
{col 20}{cmd:invbinomialtail()}{...}
{col 39}inverse binomial (upper tail)
{col 20}{hline 10}
{col 20}{cmd:chi2()}{...}
{col 39}cumulative chi-squared dist.
{col 20}{cmd:chi2tail()}{...}
{col 39}reverse cumulative chi-squared dist.
{col 20}{cmd:invchi2()}{...}
{col 39}inverse cumulative chi-squared
{col 20}{cmd:invchi2tail()}{...}
{col 39}inverse reverse cumulative chi-squared
{col 20}{hline 10}
{col 20}{cmd:dunnettprob()}{...}
{col 39}cumulative multiple range distribution;
{col 39}  used in Dunnett's multiple comparison
{col 20}{cmd:invdunnettprob()}{...}
{col 39}inverse cumulative multiple range dist.;
{col 39}  used in Dunnett's multiple comparison
{col 20}{hline 10}
{col 20}{cmd:Fden()}{...}
{col 39}F density
{col 20}{cmd:F()}{...}
{col 39}cumulative F dist.
{col 20}{cmd:Ftail()}{...}
{col 39}reverse cumulative F dist.
{col 20}{cmd:invF()}{...}
{col 39}inverse cumulative F
{col 20}{cmd:invFtail()}{...}
{col 39}inverse reverse cumulative F
{col 20}{hline 10}
{col 20}{cmd:gammaden()}{...}
{col 39}gamma density
{col 20}{cmd:gammap()}{...}
{col 39}cumulative gamma dist.;
{col 39}  a.k.a. incomplete gamma function
{col 20}{cmd:gammaptail()}{...}
{col 39}reverse cumulative gamma dist.
{col 20}{cmd:invgammap()}{...}
{col 39}inverse cumulative gamma
{col 20}{cmd:invgammaptail()}{...}
{col 39}inverse reverse cumulative gamma
{col 20}{cmd:dgammapda()}{...}
{col 39}{it:dg/da}
{col 20}{cmd:dgammapdx()}{...}
{col 39}{it:dg/dx}
{col 20}{cmd:dgammapdada()}{...}
{col 39}{it:d2g/da2}
{col 20}{cmd:dgammapdadx()}{...}
{col 39}{it:d2g/dadx}
{col 20}{cmd:dgammapdxdx()}{...}
{col 39}{it:d2g/dx2}
{col 20}{hline 10}
{col 20}{cmd:hypergeometricp()}{...}
{col 39}hypergeometric probability
{col 20}{cmd:hypergeometric()}{...}
{col 39}cumulative of hypergeometric
{col 20}{hline 10}
{col 20}{cmd:nbetaden()}{...}
{col 39}noncentral beta density
{col 20}{cmd:nibeta()}{...}
{col 39}cumulative noncentral beta dist.
{col 20}{cmd:invnibeta()}{...}
{col 39}inverse cumulative noncentral beta
{col 20}{hline 10}
{col 20}{cmd:nbinomialp()}{...}
{col 39}negative binomial probability
{col 20}{cmd:nbinomial()}{...}
{col 39}negative binomial cumulative
{col 20}{cmd:nbinomialtail()}{...}
{col 39}reverse cumulative of negative binomial
{col 20}{cmd:invnbinomial()}{...}
{col 39}inverse negative binomial (lower tail)
{col 20}{cmd:invnbinomialtail()}{...}
{col 39}inverse negative binomial (upper tail)
{col 20}{hline 10}
{col 20}{cmd:nchi2()}{...}
{col 39}noncentral cumulative chi-squared dist.
{col 20}{cmd:invnchi2()}{...}
{col 39}inverse noncentral cumulative chi-squared
{col 20}{cmd:npnchi2()}{...}
{col 39}noncentrality parameter of {cmd:nchi2()}
{col 20}{hline 10}
{col 20}{cmd:nFden()}{...}
{col 39}noncentral F density
{col 20}{cmd:nFtail()}{...}
{col 39}reverse cumulative noncentral F dist.
{col 20}{cmd:invnFtail()}{...}
{col 39}inverse reverse cumulative noncentral F
{col 20}{hline 10}
{col 20}{cmd:poissonp()}{...}
{col 39}Poisson probability
{col 20}{cmd:poisson()}{...}
{col 39}cumulative of Poisson
{col 20}{cmd:poissontail()}{...}
{col 39}reverse cumulative of Poisson
{col 20}{cmd:invpoisson()}{...}
{col 39}inverse Poisson (lower tail)
{col 20}{cmd:invpoissontail()}{...}
{col 39}inverse Poisson (upper tail)
{col 20}{hline 10}
{col 20}{cmd:tden()}{...}
{col 39}Student t density
{col 20}{cmd:ttail()}{...}
{col 39}reverse cumulative t dist.
{col 20}{cmd:invttail()}{...}
{col 39}inverse reverse cumulative t
{col 20}{hline 10}
{col 20}{cmd:tukeyprob()}{...}
{col 39}cumulative Tukey's Studentized range
{col 39}  distribution
{col 20}{cmd:invtukeyprob()}{...}
{col 39}inverse cumulative Tukey's Studentized
{col 39}  range distribution
{col 20}{hline 10}

{col 5}   {c TLC}{hline 29}{c TRC}
{col 5}{hline 3}{c RT}{it: Maximization & minimization }{c LT}{hline}
{col 5}   {c BLC}{hline 29}{c BRC}

{col 5}{bf:{help mf_optimize:optimize()}}{...}
{col 20}{cmd:optimize()}{...}
{col 44}function maximization & minimization
{col 20}{cmd:optimize_evaluate()}{...}
{col 44}evaluate function at initial values
{col 20}{cmd:optimize_init()}{...}
{col 44}begin optimization
{col 20}{cmd:optimize_init_}{it:*}{cmd:()}{...}
{col 44}set details
{col 20}{cmd:optimize_result_}{it:*}{cmd:()}{...}
{col 44}access results
{col 20}{cmd:optimize_query()}{...}
{col 44}report settings

{col 5}{bf:{help mf_moptimize:moptimize()}}{...}
{col 20}{cmd:moptimize()}{...}
{col 44}function optimization
{col 20}{cmd:moptimize_evaluate()}{...}
{col 44}evaluate function at initial values
{col 20}{cmd:moptimize_init()}{...}
{col 44}begin setup of optimization problem
{col 20}{cmd:moptimize_init_}{it:*}{cmd:()}{...}
{col 44}set details 
{col 20}{cmd:moptimize_result_}{it:*}{cmd:()}{...}
{col 44}access {cmd:moptimize()} results
{col 20}{cmd:moptimize_ado_cleanup()}{...}
{col 44}perform cleanup after ado 
{col 20}{cmd:moptimize_query()}{...}
{col 44}report settings
{col 20}{cmd:moptimize_util_}{it:*}{cmd:()}{...}
{col 44}utility functions for writing
{col 44}  evaluators and processing results

{col 5}   {c TLC}{hline 25}{c TRC}
{col 5}{hline 3}{c RT}{it: Logits, odds, & related }{c LT}{hline}
{col 5}   {c BLC}{hline 25}{c BRC}

{col 5}{bf:{help mf_logit:logit()}}{...}
{col 20}{cmd:logit()}{...}
{col 39}log of the odds ratio
{col 20}{cmd:invlogit()}{...}
{col 39}inverse log of the odds ratio
{col 20}{cmd:cloglog()}{...}
{col 39}complementary log-log
{col 20}{cmd:invcloglog()}{...}
{col 39}inverse complementary log-log

{col 5}   {c TLC}{hline 21}{c TRC}
{col 5}{hline 3}{c RT}{it: Multivariate normal }{c LT}{hline}
{col 5}   {c BLC}{hline 21}{c BRC}

{col 5}{bf:{help mf_ghk:ghk()}}{...}
{col 20}{cmd:ghk()}{...}
{col 39}GHK multivariate normal (MVN) simulator
{col 20}{cmd:ghk_init()}{...}
{col 39}GHK MVN initialization
{col 20}{cmd:ghk_init_}{it:*}{cmd:()}{...}
{col 39}set details
{col 20}{cmd:ghk()}{...}
{col 39}perform simulation
{col 20}{cmd:ghk_query_npts()}{...}
{col 39}return number of simulation points

{col 5}{bf:{help mf_ghkfast:ghkfast()}}{...}
{col 20}{cmd:ghkfast()}{...}
{col 39}GHK MVN simulator
{col 20}{cmd:ghkfast_init()}{...}
{col 39}GHK MVN initialization
{col 20}{cmd:ghkfast_init_}{it:*}{cmd:()}{...}
{col 39}set details
{col 20}{cmd:ghkfast()}{...}
{col 39}perform simulation
{col 20}{cmd:ghkfast_i()}{...}
{col 39}results for the ith observation
{col 20}{cmd:ghk_query_}{it:*}{cmd:()}{...}
{col 39}display settings

{col 5}{hline}


{marker description}{...}
{title:Description}

{p 4 4 2}
The above functions are statistical, probabilistic, or designed to work 
with data matrices.


{marker remarks}{...}
{title:Remarks}

{p2colset 8 29 32 2}{...}
{p 4 4 2}
Concerning data matrices, see 

{col 8}{...}
{bf:{help m4_stata:[M-4] stata}}{...}
{col 30}Stata interface functions

{p 4 4 2}
and especially 

{col 8}{...}
{bf:{help mf_st_data:[M-5] st_data()}}{...}
{col 30}Load copy of current Stata dataset
{col 8}{...}
{p2col:{bf:{help mf_st_view:[M-5] st_view()}}}{...}
 Make matrix that is a view onto current Stata dataset

{p 4 4 2}
For other mathematical functions, see

{col 8}{...}
{bf:{help m4_matrix:[M-4] matrix}}{...}
{col 30}Matrix mathematical functions

{col 8}{...}
{bf:{help m4_scalar:[M-4] scalar}}{...}
{col 30}Scalar mathematical functions

{col 8}{...}
{bf:{help m4_mathematical:[M-4] mathematical}}{...}
{col 30}Important mathematical functions
{p2colreset}{...}

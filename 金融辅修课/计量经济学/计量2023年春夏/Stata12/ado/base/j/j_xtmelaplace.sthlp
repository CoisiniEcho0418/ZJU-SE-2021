{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[XT] xtmelogit" "mansection XT xtmelogit"}{...}
{vieweralsosee "[XT] xtmepoisson" "mansection XT xtmepoisson"}{...}
{viewerjumpto "What is the Laplacian approximation" "j_xtmelaplace##define"}{...}
{viewerjumpto "How is the Laplacian approximation calculated?" "j_xtmelaplace##calculate"}{...}
{viewerjumpto "If Laplacian estimates are biased, why should I want them" "j_xtmelaplace##want"}{...}
{viewerjumpto "References" "j_xtmelaplace##references"}{...}
{marker define}{...}
{title:What is the Laplacian approximation?}

{pstd}
The Laplacian approximation is a computationally efficient method of calculating
the log likelihood in a generalized linear mixed model and is one of the
available estimation methods offered by {helpb xtmelogit} and 
{helpb xtmepoisson}.


{marker calculate}{...}
{title:How is the Laplacian approximation calculated?}

{pstd}
Calculating the log likelihood in a mixed model requires integrating out the
random effects, which are assumed to be normally distributed, so that the
likelihood may be expressed as a function of the fixed effects and the
variance components that summarize the random effects.  When the response is
non-Gaussian (binary, for instance), the integral has no closed form and must
instead be approximated by some other means.  The Laplacian method handles
this task by approximating the integrand with a normal distribution centered at
the values of the random effects that maximize the integrand.  These
maximizers correspond to the modes of the posterior distributions of the
random effects given the response.

{pstd}
Another way to estimate the integral is by adaptive Gauss-Hermite
quadrature, and this method is also available in {cmd:xtmelogit} and
{cmd:xtmepoisson}.  Adaptive quadrature is merely plain quadrature in which the
quadrature abscissas are adjusted to better capture the features of the
integrand.  In {cmd:xtmelogit} and {cmd:xtmepoisson}, the method of adapting
these abscissas is also based on modal estimates of the random effects.  In
fact, the Laplacian approximation is merely adaptive quadrature performed
using one abscissa, the mode itself 
({help j_xtmelaplace##PB1995:Pinheiro and Bates 1995}).

{pstd}
Because the Laplacian approximation involves only one abscissa, estimation can
be much faster than adaptive quadrature using many abscissas.  Of course,
there is a price to be paid for this speed.  Parameter estimates based on the
Laplacian approximation tend to exhibit more bias than those based on
multiabscissa adaptive quadrature, with the bias diminishing as the number of
abscissas (and the computation time involved) increases.


{marker want}{...}
{title:If Laplacian estimates are biased, why should I want them?}

{pstd}
Despite its simplicity, the Laplacian approximation can perform well
({help j_xtmelaplace##LP1994:Liu and Pierce 1994};
 {help j_xtmelaplace##TK1986:Tierney and Kadane 1986}),
and on the basis of our own empirical evidence and the simulation studies of
 {help j_xtmelaplace##PC2006:Pinheiro and Chao (2006)},
bias tends to be more prominent in the estimated variance components than in
the estimated fixed effects.  If you are more interested in inference
on fixed effects adjusted for multilevel random effects than in
estimates of the variance components that summarize the random effects, then
the Laplacian approximation may be adequate for your needs.  

{pstd}
Also, the Laplacian approximation often produces a good 
approximation of the overall model log likelihood.  Therefore, 
the Laplacian approximation can be useful during the model-building phase of
your analysis as you compare competing models with LR tests (which are based on
log likelihoods) before settling on a final model.


{marker references}{...}
{title:References}

{marker LP1994}{...}
{phang}
Liu, Q., and D. A. Pierce. 1994. A note on Gauss-Hermite quadrature.
{it:Biometrika} 81: 624-629.{p_end}

{marker PB1995}{...}
{phang}Pinheiro, J. C., and D. M. Bates. 1995. Approximations to the
log-likelihood function in the nonlinear mixed-effects model.
{it:Journal of Computational and Graphical Statistics} 4: 12-35.{p_end}

{marker PC2006}{...}
{phang}Pinheiro, J. C., and E. C. Chao. 2006. Efficient Laplacian and 
adaptive Gaussian quadrature algorithms for multilevel generalized 
linear mixed models.  
{it:Journal of Computational and Graphical Statistics} 15: 58-81.{p_end}

{marker TK1986}{...}
{phang}Tierney, L., and J. B. Kadane. 1986. Accurate approximations for 
posterior moments and marginal densities.  
{it:Journal of the American Statistical Association} 81: 82-86.{p_end}

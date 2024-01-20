{smcl}
{* *! version 1.2.5  08jul2011}{...}
{vieweralsosee "[M-4] mathematical" "mansection M-4 mathematical"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] intro" "help m4_intro"}{...}
{viewerjumpto "Contents" "m4_mathematical##contents"}{...}
{viewerjumpto "Description" "m4_mathematical##description"}{...}
{viewerjumpto "Remarks" "m4_mathematical##remarks"}{...}
{title:Title}

{phang}
{manlink M-4 mathematical} {hline 2} Important mathematical functions


{marker contents}{...}
{title:Contents}

{col 5}   [M-5]
{col 5}Manual entry{col 18}Function{col 42}Purpose
{col 5}{hline}

{col 5}   {c TLC}{hline 32}{c TRC}
{col 5}{hline 3}{c RT}{it: Basics} ({it:also see} {bf:{help m4_scalar:[M-4] scalar}}) {c LT}{hline}
{col 5}   {c BLC}{hline 32}{c BRC}

{col 5}{bf:{help mf_sum:sum()}}{...}
{col 18}{cmd:rowsum()}{...}
{col 42}sum of each row
{col 18}{cmd:colsum()}{...}
{col 42}sum of each column
{col 18}{cmd:sum()}{...}
{col 42}overall sum
{col 18}{cmd:quadrowsum()}{...}
{col 42}quad-precision sum of each row
{col 18}{cmd:quadcolsum()}{...}
{col 42}quad-precision sum of each column
{col 18}{cmd:quadsum()}{...}
{col 42}quad-precision overall sum

{col 5}{bf:{help mf_runningsum:runningsum()}}{...}
{col 18}{cmd:runningsum()}{...}
{col 42}running sum of vector
{col 18}{cmd:quadrunningsum()}{...}
{col 42}quad-precision {cmd:runningsum()}

{col 5}{bf:{help mf_minmax:minmax()}}{...}
{col 18}{cmd:rowmin()}{...}
{col 42}minimum, by row
{col 18}{cmd:colmin()}{...}
{col 42}minimum, by column
{col 18}{cmd:min()}{...}
{col 42}minimum, overall
{col 18}{cmd:rowmax()}{...}
{col 42}maximum, by row
{col 18}{cmd:colmax()}{...}
{col 42}maximum, by column
{col 18}{cmd:max()}{...}
{col 42}maximum, overall
{col 18}{cmd:rowminmax()}{...}
{col 42}minimum and maximum, by row
{col 18}{cmd:colminmax()}{...}
{col 42}minimum and maximum, by column
{col 18}{cmd:minmax()}{...}
{col 42}minimum and maximum, overall
{col 18}{cmd:rowmaxabs()}{...}
{col 42}{cmd:rowmax(abs())}
{col 18}{cmd:colmaxabs()}{...}
{col 42}{cmd:colmax(abs())}

{col 5}{bf:{help mf_deriv:deriv()}}{...}
{col 18}{cmd:deriv()}{...}
{col 42}numerical derivatives
{col 18}{cmd:deriv_init()}{...}
{col 42}begin derivatives
{col 18}{cmd:deriv_init_}{it:*}{cmd:()}{...}
{col 42}set details
{col 18}{cmd:deriv()}{...}
{col 42}compute derivatives
{col 18}{cmd:deriv_result_}{it:*}{cmd:()}{...}
{col 42}access results
{col 18}{cmd:deriv_query()}{...}
{col 42}report settings 

{col 5}{bf:{help mf_optimize:optimize()}}{...}
{col 18}{cmd:optimize()}{...}
{col 42}function maximization and minimization
{col 18}{cmd:optimize_init()}{...}
{col 42}begin optimization
{col 18}{cmd:optimize_init_}{it:*}{cmd:()}{...}
{col 42}set details
{col 18}{cmd:optimize()}{...}
{col 42}perform optimization
{col 18}{cmd:optimize_result_}{it:*}{cmd:()}{...}
{col 42}access results
{col 18}{cmd:optimize_query()}{...}
{col 42}report settings 

{col 5}{bf:{help mf_moptimize:moptimize()}}{...}
{col 18}{cmd:moptimize()}{...}
{col 42}function optimization
{col 18}{cmd:moptimize_ado_cleanup()}{...}
{col 42}perform cleanup after ado 
{col 18}{cmd:moptimize_evaluate()}{...}
{col 42}evaluate function at initial values
{col 18}{cmd:moptimize_init()}{...}
{col 42}begin setup of optimization problem
{col 18}{cmd:moptimize_init_}{it:*}{cmd:()}{...}
{col 42}set details 
{col 18}{cmd:moptimize_result_}{it:*}{cmd:()}{...}
{col 42}access {cmd:moptimize()} results
{col 18}{cmd:moptimize_query()}{...}
{col 42}report settings
{col 18}{cmd:moptimize_util_}{it:*}{cmd:()}{...}
{col 42}utility functions for writing
{col 42}  evaluators and processing results

{col 5}   {c TLC}{hline 19}{c TRC}
{col 5}{hline 3}{c RT}{it: Fourier transform }{c LT}{hline}
{col 5}   {c BLC}{hline 19}{c BRC}

{col 5}{bf:{help mf_fft:fft()}}{...}
{col 18}{cmd:fft()}{...}
{col 42}fast Fourier transform
{col 18}{cmd:invfft()}{...}
{col 42}inverse fast Fourier transform
{col 18}{cmd:convolve()}{...}
{col 42}convolution
{col 18}{cmd:deconvolve()}{...}
{col 42}inverse of {cmd:convolve()}
{col 18}{cmd:Corr()}{...}
{col 42}correlation
{col 18}{cmd:ftperiodogram()}{...}
{col 42}power spectrum
{col 18}{cmd:ftpad()}{...}
{col 42}pad to power-of-2 length
{col 18}{cmd:ftwrap()}{...}
{col 42}convert to frequency-wraparound order
{col 18}{cmd:ftunwrap()}{...}
{col 42}convert from frequency-wraparound
{col 42}  order
{col 18}{cmd:ftretime()}{...}
{col 42}change time scale of signal
{col 18}{cmd:ftfreqs()}{...}
{col 42}frequencies of transform

{col 5}   {c TLC}{hline 15}{c TRC}
{col 5}{hline 3}{c RT}{it: Cubic splines }{c LT}{hline}
{col 5}   {c BLC}{hline 15}{c BRC}

{col 5}{bf:{help mf_spline3:spline3()}}{...}
{col 18}{cmd:spline3()}{...}
{col 42}fit cubic spline
{col 18}{cmd:spline3eval()}{...}
{col 42}evaluate cubic spline

{col 5}   {c TLC}{hline 13}{c TRC}
{col 5}{hline 3}{c RT}{it: Polynomials }{c LT}{hline}
{col 5}   {c BLC}{hline 13}{c BRC}

{col 5}{bf:{help mf_polyeval:polyeval()}}{...}
{col 18}{cmd:polyeval()}{...}
{col 42}evaluate polynomial
{col 18}{cmd:polysolve()}{...}
{col 42}solve for polynomial
{col 18}{cmd:polytrim()}{...}
{col 42}trim polynomial
{col 18}{cmd:polyderiv()}{...}
{col 42}derivative of polynomial
{col 18}{cmd:polyinteg()}{...}
{col 42}integral of polynomial
{col 18}{cmd:polyadd()}{...}
{col 42}add polynomials
{col 18}{cmd:polymult()}{...}
{col 42}multiply polynomials
{col 18}{cmd:polydiv()}{...}
{col 42}divide polynomials
{col 18}{cmd:polyroots()}{...}
{col 42}find roots of polynomial

{col 5}   {c TLC}{hline 29}{c TRC}
{col 5}{hline 3}{c RT}{it: Number-theoretic point sets }{c LT}{hline}
{col 5}   {c BLC}{hline 29}{c BRC}

{col 5}{bf:{help mf_halton:halton()}}{...}
{col 18}{cmd:halton()}{...}
{col 42}generate a Halton or Hammersley set
{col 18}{cmd:ghalton()}{...}
{col 42}generate a generalized Halton sequence

{col 5}   {c TLC}{hline 17}{c TRC}
{col 5}{hline 3}{c RT}{it: Base conversion }{c LT}{hline}
{col 5}   {c BLC}{hline 17}{c BRC}

{col 5}{bf:{help mf_inbase:inbase()}}{...}
{col 18}{cmd:inbase()}{...}
{col 42}convert to specified base
{col 18}{cmd:frombase()}{...}
{col 42}convert from specified base

{col 5}{hline}


{marker description}{...}
{title:Description}

{p 4 4 2}
The above functions are important mathematical functions that most people 
would not call either matrix functions or scalar functions, but that 
use matrices and scalars.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
For other mathematical functions, see 

{col 8}{...}
{bf:{help m4_matrix:[M-4] matrix}}{...}
{col 30}Matrix mathematical functions

{col 8}{...}
{bf:{help m4_scalar:[M-4] scalar}}{...}
{col 30}Scalar mathematical functions

{col 8}{...}
{bf:{help m4_statistical:[M-4] statistical}}{...}
{col 30}Statistical functions

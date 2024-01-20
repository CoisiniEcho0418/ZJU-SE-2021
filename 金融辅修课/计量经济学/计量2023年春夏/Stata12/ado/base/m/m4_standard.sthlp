{smcl}
{* *! version 1.1.7  08jul2011}{...}
{vieweralsosee "[M-4] standard" "mansection M-4 standard"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] intro" "help m4_intro"}{...}
{viewerjumpto "Contents" "m4_standard##contents"}{...}
{viewerjumpto "Description" "m4_standard##description"}{...}
{viewerjumpto "Remarks" "m4_standard##remarks"}{...}
{title:Title}

{phang}
{manlink M-4 standard} {hline 2} Functions to create standard matrices


{marker contents}{...}
{title:Contents}

{col 5}   [M-5]
{col 5}Manual entry{col 22}Function{col 40}Purpose
{col 5}{hline}

{col 5}   {c TLC}{hline 26}{c TRC}
{col 5}{hline 3}{c RT}{it: Unit & constant matrices }{c LT}{hline}
{col 5}   {c BLC}{hline 26}{c BRC}

{col 5}{bf:{help mf_i:I()}}{...}
{col 22}{cmd:I()}{...}
{col 40}identity matrix

{...}
{col 5}{bf:{help mf_e:e()}}{...}
{col 22}{cmd:e()}{...}
{col 40}unit vectors
{...}

{col 5}{bf:{help mf_j:J()}}{...}
{col 22}{cmd:J()}{...}
{col 40}matrix of constants
{...}

{col 5}{bf:{help mf_designmatrix:designmatrix()}}{...}
{col 22}{cmd:designmatrix()}{...}
{col 40}design matrices
{...}

{col 5}   {c TLC}{hline 25}{c TRC}
{col 5}{hline 3}{c RT}{it: Block-diagonal matrices }{c LT}{hline}
{col 5}   {c BLC}{hline 25}{c BRC}

{col 5}{bf:{help mf_blockdiag:blockdiag()}}{...}
{col 22}{cmd:blockdiag()}{...}
{col 40}block-diagonal matrix
{...}

{col 5}   {c TLC}{hline 8}{c TRC}
{col 5}{hline 3}{c RT}{it: Ranges }{c LT}{hline}
{col 5}   {c BLC}{hline 8}{c BRC}

{col 5}{bf:{help mf_range:range()}}{...}
{col 22}{cmd:range()}{...}
{col 40}vector over specified range
{col 22}{cmd:rangen()}{...}
{col 40}vector of n over specified range
{...}

{col 5}{bf:{help mf_unitcircle:unitcircle()}}{...}
{col 22}{cmd:unitcircle()}{...}
{col 40}unit circle on complex plane
{...}

{col 5}   {c TLC}{hline 8}{c TRC}
{col 5}{hline 3}{c RT}{it: Random }{c LT}{hline}
{col 5}   {c BLC}{hline 8}{c BRC}

{col 5}{bf:{help mf_runiform:runiform()}}{...}
{col 22}{cmd:runiform()}{...}
{col 40}uniformly distributed random numbers
{col 22}{cmd:rseed()}{...}
{col 40}obtain or set random variate
{col 40}generator seed

{col 5}   {c TLC}{hline 16}{c TRC}
{col 5}{hline 3}{c RT}{it: Named matrices }{c LT}{hline}
{col 5}   {c BLC}{hline 16}{c BRC}

{col 5}{bf:{help mf_hilbert:Hilbert()}}{...}
{col 22}{cmd:Hilbert()}{...}
{col 40}Hilbert matrices
{col 22}{cmd:invHilbert()}{...}
{col 40}inverse Hilbert matrices

{col 5}{bf:{help mf_toeplitz:Toeplitz()}}{...}
{col 22}{cmd:Toeplitz()}{...}
{col 40}Toeplitz matrices

{col 5}{bf:{help mf_vandermonde:Vandermonde()}}{...}
{col 22}{cmd:Vandermonde()}{...}
{col 40}Vandermonde matrices
{col 5}{hline}

{col 5}   {c TLC}{hline 27}{c TRC}
{col 5}{hline 3}{c RT}{it: vec() & vech() transforms }{c LT}{hline}
{col 5}   {c BLC}{hline 27}{c BRC}

{col 5}{bf:{help mf_dmatrix:Dmatrix()}}{...}
{col 22}{cmd:Dmatrix()}{...}
{col 40}duplication matrices

{col 5}{bf:{help mf_kmatrix:Kmatrix()}}{...}
{col 22}{cmd:Kmatrix()}{...}
{col 40}commutation matrices

{col 5}{bf:{help mf_lmatrix:Lmatrix()}}{...}
{col 22}{cmd:Lmatrix()}{...}
{col 40}elimination matrices
{col 5}{hline}


{marker description}{...}
{title:Description}

{p 4 4 2}
The functions above create standard matrices such as the identity matrix, 
etc.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
For other mathematical functions, see

	{bf:{help m4_matrix:[M-4] matrix}}          Matrix mathematical functions

	{bf:{help m4_scalar:[M-4] scalar}}          Scalar mathematical functions

	{bf:{help m4_mathematical:[M-4] mathematical}}    Important mathematical functions

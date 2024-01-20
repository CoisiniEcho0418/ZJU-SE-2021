{smcl}
{* *! version 1.1.10  08jul2011}{...}
{vieweralsosee "[M-1] LAPACK" "mansection M-1 LAPACK"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] copyright lapack" "help copyright_lapack"}{...}
{vieweralsosee "[M-5] lapack()" "help mf_lapack"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-1] intro" "help m1_intro"}{...}
{viewerjumpto "Description" "m1_lapack##description"}{...}
{viewerjumpto "Remarks" "m1_lapack##remarks"}{...}
{viewerjumpto "Acknowledgments" "m1_lapack##acknowledgments"}{...}
{viewerjumpto "Reference" "m1_lapack##reference"}{...}
{title:Title}

{phang}
{manlink M-1 LAPACK} {hline 2} The LAPACK linear-algebra routines


{marker description}{...}
{title:Description}

{p 4 4 2}
    LAPACK stands for Linear Algebra PACKage and is a freely available
    set of FORTRAN 90 routines for solving systems of
    simultaneous equations, eigenvalue problems, and singular value problems.
    Many of the LAPACK routines are based on older EISPACK and LINPACK
    routines, and the more modern LAPACK does much of its computation by using
    BLAS (Basic Linear Algebra Subprogram). 


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
    The LAPACK and BLAS routines form the basis for many of Mata's
    linear-algebra capabilities.  Individual functions of Mata that 
    use LAPACK routines always make note of that fact.

{p 4 4 2}
    For up-to-date information on LAPACK, see 
    {browse "http://www.netlib.org/lapack/"}.

{p 4 4 2}
    Advanced programmers can directly access the LAPACK functions; see
    {helpb mf_lapack:[M-5] lapack()}.


{marker acknowledgments}{...}
{title:Acknowledgments}

{p 4 4 2}
    We thank the authors of LAPACK for their excellent work:

{p 8 12 2}
    E. Anderson, Z. Bai, C. Bischof, S. Blackford, J. Demmel, J. Dongarra, 
    J. Du Croz, A. Greenbaum, S. Hammarling, A. McKenney, and D. Sorensen.


{marker reference}{...}
{title:Reference}

{phang}
Anderson, E., Z. Bai, C. Bischof, S. Blackford, J. Demmel, J. Dongarra, 
    J. Du Croz, A. Greenbaum, S. Hammarling, A. McKenney, and D. Sorensen.
    1999.  {it:LAPACK Users' Guide}. 3rd ed.  Philadelphia: Society for
    Industrial and Applied Mathematics.
{p_end}

{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog "matrix eigenvalues" "dialog matrix_eigenvalues"}{...}
{vieweralsosee "[P] matrix eigenvalues" "mansection P matrixeigenvalues"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "[P] matrix symeigen" "help matrix_symeigen"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] matrix" "help m4_matrix"}{...}
{viewerjumpto "Syntax" "matrix_eigenvalues##syntax"}{...}
{viewerjumpto "Description" "matrix_eigenvalues##description"}{...}
{viewerjumpto "Examples" "matrix_eigenvalues##examples"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink P matrix eigenvalues} {hline 2}}Eigenvalues of nonsymmetric matrices{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}
{cmdab:mat:rix} {cmdab:eigenval:ues} {it:r} {it:c} {cmd:=} {it:A}

{phang}
where {it:A} is an n x n nonsymmetric, real matrix.


{title:Menu}

{phang}
{bf:Data > Matrices, ado language > Eigenvalues and eigenvectors of symmetric matrices}


{marker description}{...}
{title:Description}

{pstd}
{cmd:matrix eigenvalues} returns the real part of the eigenvalues in the
1 x n row vector {it:r} and the imaginary part of the eigenvalues in the
1 x n row vector {it:c}. Thus the {it:j}th eigenvalue is
{it:r}{cmd:[1,}{it:j}{cmd:]} + i*{it:c}{cmd:[1,}{it:j}{cmd:]}.
                                                                                
{pstd}
The eigenvalues are sorted by their moduli;
{it:r}{cmd:[1,1]} + i*{it:c}{cmd:[1,1]} has the largest
modulus, and
{it:r}{cmd:[1,}{it:n}{cmd:]} + i*{it:c}{cmd:[1,}{it:n}{cmd:]} has the smallest
modulus.

{pstd}
If you want the eigenvalues for a symmetric matrix, see 
{manhelp matrix_symeigen P:matrix symeigen}.

{pstd}
Also see {bf:{help mf_eigensystem:[M-5] eigensystem()}} for alternative
routines for obtaining eigenvectors and eigenvalues.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. matrix A = (0.66151492, .2551595, .35603325, -0.15403902,}
           {cmd: -.12734386)}{p_end}
{phang}{cmd:. matrix A = A \ (I(4), J(4,1,0))}{p_end}
{phang}{cmd:. mat list A}{p_end}
{phang}{cmd:. matrix eigenvalues re im = A}{p_end}
{phang}{cmd:. mat list re}{p_end}
{phang}{cmd:. mat list im}{p_end} 

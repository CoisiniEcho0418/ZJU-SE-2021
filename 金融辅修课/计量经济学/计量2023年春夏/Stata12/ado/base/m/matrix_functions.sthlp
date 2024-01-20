{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[D] functions" "mansection D functions"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "[P] matrix define" "help matrix_define"}{...}
{vieweralsosee "matrix operators" "help matrix operators"}{...}
{viewerjumpto "Description" "matrix_functions##description"}{...}
{viewerjumpto "Matrix functions returning a scalar" "matrix_functions##scalar"}{...}
{viewerjumpto "Matrix functions returning a matrix" "matrix_functions##matrix"}{...}
{viewerjumpto "Examples" "matrix_functions##examples"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink D functions} {hline 2}}Functions{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}This is a quick reference to matrix functions available within Stata.
See {manhelp matrix P} for background information and links to more matrix
help.  For help on all functions, see {manhelp functions D}.

{pstd}
Stata has a newer, more powerful matrix language.  For information 
on it, see {bf:{help mata:[M] Mata}}.

{pstd}
Let {it:A}, {it:B}, {it:C}, ..., represent matrix names or matrix
expressions and let {it:a}, {it:b}, {it:c}, ..., represent numbers or scalar
expressions.


{marker scalar}{...}
{title:Matrix functions returning a scalar}

INCLUDE help f_colnumb

INCLUDE help f_colsof

INCLUDE help f_det

INCLUDE help f_diag0cnt

INCLUDE help f_el

INCLUDE help f_issymmetric

INCLUDE help f_matmissing

INCLUDE help f_mreldif

INCLUDE help f_rownumb

INCLUDE help f_rowsof

INCLUDE help f_trace

{pstd}
Matrix functions returning scalar may be used in any expression context, not
just matrix expression contexts.


{marker matrix}{...}
{title:Matrix functions returning a matrix}

INCLUDE help f_cholesky

INCLUDE help f_corr

INCLUDE help f_diag

INCLUDE help f_get

INCLUDE help f_hadamard

INCLUDE help f_i

INCLUDE help f_inv

INCLUDE help f_invsym

INCLUDE help f_j

INCLUDE help f_matuniform

INCLUDE help f_nullmat

INCLUDE help f_sweep

INCLUDE help f_vec

INCLUDE help f_vecdiag


{marker examples}{...}
{title:Examples}

{phang}{cmd:. matrix myid = I(3)}{p_end}
{phang}{cmd:. matrix list myid}

{phang}{cmd:. matrix new = J(2,3,0)}{p_end}
{phang}{cmd:. matrix list new}

{phang}{cmd:. matrix A = (1,2\2,5)}{p_end}
{phang}{cmd:. matrix Ainv = invsym(A)}{p_end}
{phang}{cmd:. matrix list Ainv}

{phang}{cmd:. matrix L = cholesky(4*I(2) + A'*A)}{p_end}
{phang}{cmd:. matrix list L}

{phang}{cmd:. matrix B = (1,5,9\2,1,7\3,5,1)}{p_end}
{phang}{cmd:. matrix Binv = inv(B)}{p_end}
{phang}{cmd:. matrix list Binv}

{phang}{cmd:. matrix C = sweep(B,1)}{p_end}
{phang}{cmd:. matrix list C}

{phang}{cmd:. matrix C = sweep(C,1)}{p_end}
{phang}{cmd:. matrix list C}

{phang}{cmd:. matrix Cov = (36.6598,-3596.48\-3596.48,604030)}{p_end}
{phang}{cmd:. matrix R = corr(Cov)}{p_end}
{phang}{cmd:. matrix list R}

{phang}{cmd:. matrix d = (1,2,3)}{p_end}
{phang}{cmd:. matrix D = diag(d)}{p_end}
{phang}{cmd:. matrix list D}

{phang}{cmd:. matrix e = vec(D)}{p_end}
{phang}{cmd:. matrix list e}

{phang}{cmd:. matrix f = vecdiag(D)}{p_end}
{phang}{cmd:. matrix list f}

{phang}{cmd:. matrix G = diag(inv(B) * vecdiag(d) + 4*sweep(B+J(3,3,10),2)'*I(3))')}{p_end}
{phang}{cmd:. matrix list G}

{phang}{cmd:. matrix U = matuniform(3,4)}{p_end}
{phang}{cmd:. matrix list U}

{phang}{cmd:. matrix H = hadamard(B,C)}{p_end}
{phang}{cmd:. matrix list H}{p_end}

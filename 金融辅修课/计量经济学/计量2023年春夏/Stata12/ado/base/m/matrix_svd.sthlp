{smcl}
{* *! version 1.1.5  11feb2011}{...}
{viewerdialog "matrix svd" "dialog matrix_svd"}{...}
{vieweralsosee "[P] matrix svd" "mansection P matrixsvd"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] matrix" "help m4_matrix"}{...}
{vieweralsosee "[M-5] svd()" "help mf_svd"}{...}
{viewerjumpto "Syntax" "matrix_svd##syntax"}{...}
{viewerjumpto "Description" "matrix_svd##description"}{...}
{viewerjumpto "Examples" "matrix_svd##examples"}{...}
{title:Title}

{p2colset 5 23 25 2}{...}
{p2col :{manlink P matrix svd} {hline 2}}Singular value decomposition{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}{cmdab:mat:rix} {cmd:svd} {it:U} {it:W} {it:V} {cmd:=} {it:A}

{pstd}
where {it:U}, {it:W}, and {it:V} are matrix names (the matrices may exist
or not) and {it:A} is the name of an existing m x n matrix, m {ul:>} n.


{title:Menu}

{phang}
{bf:Data > Matrices, ado language > Singular value decomposition}


{marker description}{...}
{title:Description}

{pstd}
{cmd:matrix svd} produces the singular value decomposition (SVD) of {it:A}.

{pstd}
The singular value decomposition of m x n matrix {it:A}, m {ul:>} n, is defined
as

	{it:A} = {it:U} diag({it:W}) {it:V}'

{pstd}
where {it:U} is column orthogonal, the elements of {it:W} are
positive or zero, and {it:V}'{it:V}=I.

{pstd}
Also see {bf:{help mf_svd:[M-5] svd()}} for alternative routines for obtaining
the singular value decomposition.


{marker examples}{...}
{title:Examples}

    {cmd:. matrix A = (1,2,9\2,7,5\2,4,18)}
    {cmd:. matrix svd U w V = A}
    {cmd:. matrix list U}
    {cmd:. matrix list w}
    {cmd:. matrix list V}
    {cmd:. matrix newA = U*diag(w)*V'}
    {cmd:. matrix list newA}

{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[P] matrix define" "mansection P matrixdefine"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix define (extraction)" "help matrix_extraction"}{...}
{vieweralsosee "[P] matrix define (subscripting)" "help matrix_subscripting"}{...}
{viewerjumpto "Syntax" "matrix_substitution##syntax"}{...}
{viewerjumpto "Description" "matrix_substitution##description"}{...}
{viewerjumpto "Examples" "matrix_substitution##examples"}{...}
{title:Title}

{pstd}
{manlink P matrix define} {hline 2} Submatrix substitution


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmdab:mat:rix} {it:A}{cmd:[}{it:r}{cmd:,}{it:c}{cmd:]} {cmd:=} {it:...}

{pstd}
where {it:r} and {it:c} are numeric scalar expressions.


{marker description}{...}
{title:Description}

{pstd}
If the matrix expression to the right of the equal sign evaluates to a
scalar or 1 x 1 matrix, the indicated element of {it:A} is replaced.  If the
matrix expression evaluates to a matrix, the resulting matrix is placed in
{it:A} with its upper left corner at ({it:r},{it:c}).


{marker examples}{...}
{title:Examples}

{phang}{cmd:. matrix A[2,2] = B}{p_end}
{phang}{cmd:. matrix A[rownumb(A,"price"), colnumb(A,"mpg")] = sqrt(2)}{p_end}

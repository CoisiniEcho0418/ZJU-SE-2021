{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[P] matrix define" "mansection P matrixdefine"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix define (extraction)" "help matrix_extraction"}{...}
{vieweralsosee "[P] matrix define (substitution)" "help matrix_substitution"}{...}
{viewerjumpto "Syntax" "matrix_subscripting##syntax"}{...}
{viewerjumpto "Description" "matrix_subscripting##description"}{...}
{viewerjumpto "Examples" "matrix_subscripting##examples"}{...}
{title:Title}

{pstd}
{manlink P matrix define} {hline 2} Matrix subscripting


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmdab:mat:rix} {it:A} {cmd:=} {it:...} {it:B}{cmd:[}{it:r}{cmd:,}{it:c}{cmd:]} {it:...}

{pstd}
where {it:r} and {it:c} are numeric or string scalar expressions.


{marker description}{...}
{title:Description}

{pstd}
Subscripting with numeric expressions may be used in any expression context
(such as {helpb generate} and {helpb replace})  Subscripting by row/column
name may only be used in a matrix context.  (This latter is not a constraint;
see the {cmd:rownumb()} and {cmd:colnumb()} matrix functions returning scalar
in {hi:[P] matrix define} and {help matrix functions}; they may be used
in any expression context.)


{marker examples}{...}
{title:Examples}

{phang}{cmd:. matrix A = A/A[1,1]}{p_end}
{phang}{cmd:. matrix B = A["weight","displ"]}{p_end}
{phang}{cmd:. matrix D = G[1,"eq1:l1.gnp"]}{p_end}

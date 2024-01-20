{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[P] macro" "help macro"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "[P] matrix rownames" "help matrix_rownames"}{...}
{viewerjumpto "Syntax" "matmacfunc##syntax"}{...}
{viewerjumpto "Description" "matmacfunc##description"}{...}
{viewerjumpto "Option" "matmacfunc##option"}{...}
{viewerjumpto "Examples" "matmacfunc##examples"}{...}
{title:Title}

{phang}
Macro extended functions regarding matrices


{marker syntax}{...}
{title:Syntax}

{pstd}
The following extended macro functions are allowed with {cmd:local} and
{cmd:global}:

	{cmd:: rowfullnames} {it:A}
	{cmd:: colfullnames} {it:A}

	{cmd:: rownames} {it:A}
	{cmd:: colnames} {it:A}

	{cmd:: roweq} {it:A} {cmd:,} {cmdab:q:uoted}
	{cmd:: coleq} {it:A} {cmd:,} {cmdab:q:uoted}


{marker description}{...}
{title:Description}

{pstd}
These extended macro functions obtain the current row and column names and
row and column equation names of a matrix.  See
{manhelp matrix_rownames P:matrix rownames} for
setting the names.  See {manhelp macro P} for information on extended macro
functions.  See {manhelp matrix P} for information on matrices in Stata.


{marker option}{...}
{title:Option}

{phang}
{cmd:quoted} encloses each equation name in double quotes.  Some Stata
estimation commands, such as {helpb mlogit}, create matrices with equation
names containing spaces when the dependent variable has value labels
containing spaces.  The {cmd:quoted} option makes it possible to correctly
determine each equation name.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. local names : rownames mymat}{p_end}
{phang}{cmd:. local names : rowfullnames mymat}{p_end}
{phang}{cmd:. local names : colfullnames e(b)}{p_end}

{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[P] matrix rownames" "mansection P matrixrownames"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "matmacfunc" "help matmacfunc"}{...}
{viewerjumpto "Syntax" "matrix_rownames##syntax"}{...}
{viewerjumpto "Description" "matrix_rownames##description"}{...}
{viewerjumpto "Examples" "matrix_rownames##examples"}{...}
{title:Title}

{p2colset 5 28 30 2}{...}
{p2col :{manlink P matrix rownames} {hline 2}}Name rows and columns{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

    Reset row names of matrix

{p 8 15 2}{cmdab:mat:rix} {cmdab:rown:ames} {it:A} {cmd:=} {it:names}{p_end}


    Reset column names of matrix

{p 8 15 2}{cmdab:mat:rix} {cmdab:coln:ames} {it:A} {cmd:=} {it:names}


    Reset row names and interpret simple names as equation names

{p 8 15 2}{cmdab:mat:rix} {cmdab:rowe:q} {space 2} {it:A} {cmd:=} {it:names}{p_end}


    Reset column names and interpret simple names as equation names

{p 8 15 2}{cmdab:mat:rix} {cmdab:cole:q} {space 2} {it:A} {cmd:=} {it:names}


{pstd}
where {it:name} can be

{phang2}o  a simple name;{p_end}
{phang2}o  a colon followed by a simple name;{p_end}
{phang2}o  an equation name followed by a colon; or{p_end}
{phang2}o  an equation name, a colon, and a simple name.

{pstd}
and a simple name may be augmented with time-series operators and
factor-variable specifications.


{marker description}{...}
{title:Description}

{pstd}
{cmd:matrix rownames} and {cmd:colnames} reset the row and column names of
an already existing matrix.

{pstd}
{cmd:matrix roweq} and {cmd:coleq} also reset the row and column names of
an already existing matrix, but if a simple name (a name without
a colon) is specified, it is interpreted as an equation name.

{pstd}
In either case, the part of the name not specified is left unchanged.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. mat A = (1,2,3\ 4,5,6\ 7,8,9)}

{pstd}List matrix {cmd:A}{p_end}
{phang2}{cmd:. mat list A}

{pstd}Change row names of {cmd:A} to {cmd:myrow1}, {cmd:myrow2}, and
{cmd:myrow3}{p_end}
{phang2}{cmd:. matrix rownames A = myrow1 myrow2 myrow3}

{pstd}List the result{p_end}
{phang2}{cmd:. mat list A}

{pstd}Change column names of {cmd:A} to {cmd:mycol1}, {cmd:mycol2}, and
{cmd:mycol3}{p_end}
{phang2}{cmd:. mat colnames A = mycol1 mycol2 mycol3}

{pstd}List the result{p_end}
{phang2}{cmd:. mat list A}

{pstd}Prefix the column names of {cmd:A} with equation names {cmd:eq1},
{cmd:eq2}, and {cmd:eq3}{p_end}
{phang2}{cmd:. mat coleq A = eq1 eq2 eq3}

{pstd}List the result{p_end}
{phang2}{cmd:. mat list A}

{pstd}
See how factor variables are incorporated in row or column names.
Here {cmd:rep78==1} is the base category{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. regress mpg gear i.rep78}{p_end}
{phang2}{cmd:. matrix list e(b)}{p_end}

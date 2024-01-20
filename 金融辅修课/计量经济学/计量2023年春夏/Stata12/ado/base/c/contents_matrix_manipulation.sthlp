{smcl}
{p 0 4}
{help contents:Top}
> {help contents_programming_matrices:Programming and matrices}
> {help contents_matrices:Matrices}
{bind:> {bf:Matrix definition and manipulation}}
{p_end}
{hline}

{title:Help file listings}

{p 4 8 4}
{bf:{help matrix_define:Inputting matrices by hand}}{break}
    {cmd:matrix} {it:A} {cmd:= (1.3, 4.8 \ 2.2, 6.9)}

{p 4 8 4}
{bf:{help matrix_subscripting:Matrix subscripting}}{break}
    subscripting can be by numeric expression or row/column name

{p 4 8 4}
{bf:{help matrix_extraction:Submatrix extraction}}{break}
    more than one row and column can be referenced in the subscripting

{p 4 8 4}
{bf:{help matrix_substitution:Submatrix substitution}}{break}
    matrix subscripts to the left of the equal sign cause
    submatrix substitution

{p 4 8 4}
{bf:{help matrix_rownames:Setting row and column names}}{break}
    place names and equation names on rows and columns of a matrix

{p 4 8 4}
{bf:{help matmacfunc:Macro extended functions regarding matrices}}{break}
    place matrix row and column names or equation names of a matrix
    into a macro

{p 4 8 4}
{bf:{help f_get:Obtaining copies of system matrices}}{break}
    {cmd:e(V)} and {cmd:e(b)} are commonly used, but other system
    matrices are also available

{hline}

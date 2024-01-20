{smcl}
{* *! version 1.1.2  11feb2011}{...}
{viewerdialog define "dialog scalardefine"}{...}
{viewerdialog list "dialog scalarlist"}{...}
{viewerdialog drop "dialog scalardrop"}{...}
{vieweralsosee "[P] scalar" "mansection P scalar"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] macro" "help macro"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{viewerjumpto "Syntax" "scalar##syntax"}{...}
{viewerjumpto "Description" "scalar##description"}{...}
{viewerjumpto "Examples" "scalar##examples"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink P scalar} {hline 2}}Scalar variables{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

    Define scalar variable

{p 8 15 2}{cmdab:sca:lar} [{cmdab:de:fine}] {it:scalar_name} {cmd:=}
    {it:{help exp}}


    List contents of scalars

{p 8 15 2}{cmdab:sca:lar} {c -(} {cmdab:di:r} | {cmdab:l:ist} {c )-} [
{cmd:_all} | {it:scalar_names} ]


    Drop specified scalars from memory

{p 8 15 2}{cmdab:sca:lar} {cmd:drop} {c -(} {cmd:_all} | {it:scalar_names} {c )-}


{marker description}{...}
{title:Description}

{pstd}
{cmd:scalar define} defines the contents of the scalar
variable {it:scalar_name}.  The expression may be either a numeric
or a string expression.

{pstd}
{cmd:scalar dir} and {cmd:scalar list} both list
the contents of scalars.

{pstd}
{cmd:scalar drop} eliminates scalars from memory.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. scalar a = 2}{p_end}
{phang}{cmd:. scalar b = a+3}{p_end}
{phang}{cmd:. scalar root2 = sqrt(2)}{p_end}
{phang}{cmd:. scalar im = sqrt(-1)}{p_end}
{phang}{cmd:. scalar x = .a}{p_end}
{phang}{cmd:. scalar s1 = "hello world"}{p_end}
{phang}{cmd:. scalar s2 = word(s1,1)}{p_end}
{phang}{cmd:. scalar list}{p_end}
{phang}{cmd:. scalar drop a b}{p_end}
{phang}{cmd:. scalar drop _all}{p_end}

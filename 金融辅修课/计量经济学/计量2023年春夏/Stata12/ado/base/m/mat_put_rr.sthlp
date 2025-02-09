{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[P] matrix get" "mansection P matrixget"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix" "help matrix"}{...}
{vieweralsosee "[R] test" "help test"}{...}
{viewerjumpto "Syntax" "mat_put_rr##syntax"}{...}
{viewerjumpto "Description" "mat_put_rr##description"}{...}
{viewerjumpto "Example" "mat_put_rr##example"}{...}
{title:Title}

{p2colset 5 23 25 2}{...}
{p2col :{manlink P matrix get} {hline 2}}Post test constraint matrix{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

    {cmd:mat_put_rr} {it:matname}


{marker description}{...}
{title:Description}

{pstd}
{cmd:mat_put_rr} is a programmer's command that posts {it:matname} as the
internal {it:Rr} matrix. {it:matname} must have one more than the number of
columns in the {cmd:e(b)} and {cmd:e(V)} matrices.  The extra column contains
the r vector, and the earlier columns contain the {it:R} matrix for the Wald
test

{center:{it:Rb} = r}

{pstd}
See {mansection R testMethodsandformulas:{it:Methods and formulas}} in
{bf:[R] test}.

{pstd}
The {cmd:matrix} ... {cmd:get(Rr)} command provides a way to obtain the
current {it:Rr} system matrix; see {manhelp get() P:matrix get}.


{marker example}{...}
{title:Example}

{phang2}{cmd:. regress y x1 x2 x3 x4}{p_end}
{phang2}{cmd:. mat z = (1,0,0,-1,0,2.8 \ 1,0,-1,0,0,0)}{p_end}
{phang2}{cmd:. mat_put_rr z}{p_end}
{phang2}{cmd:. test}

{pstd}
gives the same result as

{phang2}{cmd:. regress y x1 x2 x3 x4}{p_end}
{phang2}{cmd:. test x1-x2=2.8, notest}{p_end}
{phang2}{cmd:. test x1-x3=0, accum}{p_end}

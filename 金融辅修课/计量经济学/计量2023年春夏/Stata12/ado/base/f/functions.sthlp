{smcl}
{* *! version 1.1.3  12may2011}{...}
{vieweralsosee "[D] functions" "mansection D functions"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] egen" "help egen"}{...}
{vieweralsosee "[D] generate" "help generate"}{...}
{vieweralsosee "[U] 13 Functions and expressions (expressions)" "help exp"}{...}
{vieweralsosee "[U] 13 Functions and expressions (operators)" "help operators"}{...}
{viewerjumpto "Description" "functions##description"}{...}
{viewerjumpto "Introduction" "functions##intro"}{...}
{viewerjumpto "Examples" "functions##examples"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink D functions} {hline 2}}Functions in expressions{p_end}
{p2colreset}{...}


{marker description}{...}
{title:Description}

    Quick references are available for the following types of functions:

        {c TLC}{hline 38}{c TT}{hline 25}{c TRC}
        {c |} Type of function{space 21}{c |} See help                {c |}
        {c LT}{hline 38}{c +}{hline 25}{c RT}
        {c |} Mathematical functions{space 15}{c |} {help math functions}          {c |}
        {c |}{space 38}{c |}{space 25}{c |}
        {c |} Probability distributions and        {c |}                         {c |}
        {c |}   density functions{space 18}{c |} {help density functions}       {c |}
        {c |}{space 38}{c |}{space 25}{c |}
        {c |} Random-number functions{space 14}{c |} {help random-number functions} {c |}
        {c |}{space 38}{c |}{space 25}{c |}
        {c |} String functions{space 21}{c |} {help string functions}        {c |}
        {c |}{space 38}{c |}{space 25}{c |}
        {c |} Programming functions{space 16}{c |} {help programming functions}   {c |}
        {c |}{space 38}{c |}{space 25}{c |}
        {c |} Date and time functions{space 14}{c |} {help datetime_functions}      {c |}
        {c |}{space 38}{c |}{space 25}{c |}
        {c |} Selecting time spans{space 17}{c |} {help time-series functions}   {c |}
        {c |}{space 38}{c |}{space 25}{c |}
        {c |} Matrix functions{space 21}{c |} {help matrix functions}        {c |}
        {c |}{space 38}{c |}{space 25}{c |}
        {c BLC}{hline 38}{c BT}{hline 25}{c BRC}


{marker intro}{...}
{title:Introduction}

{pstd}
Functions are used in expressions, which are abbreviated {help exp} in
syntax diagrams.  For example, a simplified version of {helpb generate}'s
syntax is

{phang2}{cmd:generate} {it:newvar} {cmd:=} {it:exp}

{pstd}
and thus, one might type "{cmd:generate loginc = ln(income)}".  {cmd:ln()}
is a function.

{pstd}
Functions may be specified in any expression.  The arguments of a function
may be any expression, including other functions.

{pstd}
A function's arguments are enclosed in parentheses and, if there are
multiple arguments, separated by commas.

{pstd}
Functions return {it:missing} ({hi:.}) when the value of the
function is undefined.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. generate y = sqrt(abs(z*z-x*x-y))}

{phang}{cmd:. gen str20 new = cond(sex=="m","Mr. ", "Ms. ") + proper(name)}
{p_end}

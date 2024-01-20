{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[R] matsize" "mansection R matsize"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] memory" "help memory"}{...}
{vieweralsosee "[R] query" "help query"}{...}
{viewerjumpto "Syntax" "matsize##syntax"}{...}
{viewerjumpto "Description" "matsize##description"}{...}
{viewerjumpto "Option" "matsize##option"}{...}
{viewerjumpto "Example" "matsize##example"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R matsize} {hline 2}}Set the maximum number of variables in a model{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 20 2}{cmd:set} {cmdab:mat:size} {it:#} [{cmd:,} {cmdab:perm:anently}]

{phang}
    where {cmd:10} {ul:<} {it:#} {ul:<} {cmd:11000} for Stata/MP and Stata/SE
        and where {cmd:10} {ul:<} {it:#} {ul:<} {cmd:800} for Stata/IC.


{marker description}{...}
{title:Description}

{pstd}
{cmd:set matsize} sets the maximum number of variables that can be included
in any of Stata's estimation commands.

{pstd}
For {help statamp:Stata/MP} and {help SpecialEdition:Stata/SE}, the default
value is 400, but it may be changed upward or downward.  The upper limit is
11,000.

{pstd}
For {help stataic:Stata/IC}, the initial value is 400, but it may be changed
upward or downward.  The upper limit is 800.

{pstd}
The command may not be used with Small Stata; {cmd:matsize} is permanently
frozen at 100.

{pstd}
Changing {cmd:matsize} has no effect on Mata.


{marker option}{...}
{title:Option}

{phang}
{cmd:permanently} specifies that, in addition to making the change right now,
the {cmd:matsize} setting be remembered and become the default setting when
you invoke Stata.


{marker example}{...}
{title:Example}

    {cmd:. regress y x1-x400}
    {err}matsize too small
{p 8 8}
You have attempted to create a matrix with more than 400
rows or columns or to fit a model with more than 400
variables plus ancillary parameters.  You need to increase matsize by using the
{cmd:set matsize} command; see help {help matsize}.
{p_end}
    {txt}{search r(908):r(908);}

    {cmd:. set matsize 450}

    {cmd:. regress y x1-x400}
      (output appears)

{smcl}
{* *! version 1.0.8  18may2011}{...}
{vieweralsosee "[R] set cformat" "mansection R setcformat"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] estimation options" "help estimation options"}{...}
{vieweralsosee "[R] set" "help set"}{...}
{viewerjumpto "Syntax" "set_cformat##syntax"}{...}
{viewerjumpto "Description" "set_cformat##description"}{...}
{viewerjumpto "Option" "set_cformat##option"}{...}
{viewerjumpto "Example" "set_cformat##example"}{...}
{title:Title}

{p2colset 5 24 26 2}{...}
{p2col :{manlink R set cformat} {hline 2}}Format settings for coefficient tables{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:set}
{cmd:cformat}
[{it:fmt}]
[{cmd:,} {cmdab:perm:anently}]

{p 8 16 2}
{cmd:set}
{cmd:pformat}
[{it:fmt}]
[{cmd:,} {cmdab:perm:anently}]

{p 8 16 2}
{cmd:set}
{cmd:sformat}
[{it:fmt}]
[{cmd:,} {cmdab:perm:anently}]

{pstd}
where {it:fmt} is a {help format:numerical format}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:set} {cmd:cformat} specifies the output format of
coefficients, standard errors, and confidence limits in coefficient tables.

{pstd}
{cmd:set} {cmd:pformat} specifies the output format of
p-values in coefficient tables.

{pstd}
{cmd:set} {cmd:sformat} specifies the output format of
test statistics in coefficient tables.


{marker option}{...}
{title:Option}

{phang}
{cmd:permanently} specifies that, in addition to making the change right now,
the setting be remembered and become the default setting when you invoke Stata.


{marker example}{...}
{title:Example}

{phang}
Use a {cmd:%9.2f} format for coefficients, standard errors, and confidence
limits

{phang2}
{cmd:. set cformat %9.2f}

{phang}
Reset the format to the command-specific default

{phang2}
{cmd:. set cformat}
{p_end}

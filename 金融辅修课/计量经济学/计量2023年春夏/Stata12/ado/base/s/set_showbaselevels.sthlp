{smcl}
{* *! version 1.0.10  28apr2011}{...}
{vieweralsosee "[R] set showbaselevels" "mansection R setshowbaselevels"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] set" "help set"}{...}
{viewerjumpto "Syntax" "set_showbaselevels##syntax"}{...}
{viewerjumpto "Description" "set_showbaselevels##description"}{...}
{viewerjumpto "Option" "set_showbaselevels##option"}{...}
{viewerjumpto "Example" "set_showbaselevels##example"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink R set showbaselevels} {hline 2}}Display settings for
   coefficient tables{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:set}
{cmd:showbaselevels}
[{opt on}|{opt off}|{opt all}]
[{cmd:,} {cmdab:perm:anently}]

{p 8 16 2}
{cmd:set}
{cmd:showemptycells}
[{opt on}|{opt off}]
[{cmd:,} {cmdab:perm:anently}]

{p 8 16 2}
{cmd:set}
{cmd:showomitted}
[{opt on}|{opt off}]
[{cmd:,} {cmdab:perm:anently}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:set} {cmd:showbaselevels} specifies whether to display base levels of
factor variables and their interactions in coefficient tables.  {cmd:set}
{cmd:showbaselevels} {cmd:on} specifies that base levels be reported for
factor variables and for interactions whose bases cannot be inferred from
their component factor variables.  {cmd:set} {cmd:showbaselevels} {cmd:all}
specifies that all base levels of factor variables and interactions be
reported.

{pstd}
{cmd:set} {cmd:showemptycells} specifies whether to display empty cells
in coefficient tables.

{pstd}
{cmd:set} {cmd:showomitted} specifies whether to display omitted
coefficients in coefficient tables.


{marker option}{...}
{title:Option}

{phang}
{cmd:permanently} specifies that, in addition to making the change right now,
the setting be remembered and become the default setting when you invoke Stata.


{marker example}{...}
{title:Example}

{phang}
Show all base levels for factor variables
and interactions but suppress empty cells and omitted predictors

{pmore2}
{cmd:. set showbaselevels all}{break}
{cmd:. set showemptycells off}{break}
{cmd:. set showomitted off}

{phang}
Reset the display of baselevels, empty cells, and omitted predictors to the
command-specific default behavior

{pmore2}
{cmd:. set showbaselevels}{break}
{cmd:. set showemptycells}{break}
{cmd:. set showomitted}{p_end}

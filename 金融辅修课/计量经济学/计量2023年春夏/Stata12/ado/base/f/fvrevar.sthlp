{smcl}
{* *! version 1.2.2  11feb2011}{...}
{vieweralsosee "[R] fvrevar" "mansection R fvrevar"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[TS] tsrevar" "help tsrevar"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] syntax" "help syntax"}{...}
{vieweralsosee "[P] unab" "help unab"}{...}
{viewerjumpto "Syntax" "fvrevar##syntax"}{...}
{viewerjumpto "Description" "fvrevar##description"}{...}
{viewerjumpto "Options" "fvrevar##options"}{...}
{viewerjumpto "Examples" "fvrevar##examples"}{...}
{viewerjumpto "Saved results" "fvrevar##saved_results"}{...}
{title:Title}

{p2colset 5 20 24 2}{...}
{p2col :{manlink R fvrevar} {hline 2}}Factor-variables operator programming 
command{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:fvrevar} [{varlist}] {ifin} [{cmd:,}
	{opt sub:stitute}
	{opt ts:only}
	{opt l:ist}
	{opt stub(stub)}]

{phang}
You must {cmd:tsset} your data before using {cmd:fvrevar} if {it:varlist}
contains time-series operators; see {helpb tsset:[TS] tsset}.


{marker description}{...}
{title:Description}

{pstd}
{opt fvrevar} creates an equivalent, temporary variable list for a {varlist}
that might contain factor variables, interactions, or time-series-operated
variables so that the resulting variable list can be used by commands that do
not otherwise support factor variables or time-series-operated variables.  The
resulting list also could be used in a program to speed execution at the cost
of using more memory.


{marker options}{...}
{title:Options}

{phang}
{opt substitute} specifies that equivalent, temporary variables be substituted
for any factor variables, interactions, or time-series-operated variables in
{varlist}.  {opt substitute} is the default action taken by {opt fvrevar};
you do not need to specify the option.

{phang}
{opt tsonly} specifies that equivalent, temporary variables be substituted for
only the time-series-operated variables in {varlist}.

{phang}
{opt list} specifies that all factor-variable operators and time-series
operators be removed from {varlist} and the resulting list of base
variables be returned in {cmd:r(varlist)}.  No new variables are created with
this option.

{phang}
{opt stub(stub)} specifies that {cmd:fvrevar} generate named variables instead
of temporary variables.  The new variables will be named {it:stub#}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Describe the data{p_end}
{phang2}{cmd:. describe}{p_end}

{pstd}Create five temporary variables containing the values for each level of
factor variable {cmd:rep78}{p_end}
{phang2}{cmd:. fvrevar i.rep78}{p_end}

{pstd}Show contents of {cmd:r(varlist)}{p_end}
{phang2}{cmd:. display "`r(varlist)'"}{p_end}

{pstd}Do not create temporary variables and only return the list corresponding
to the unoperated base variable of {cmd:i.rep78}{p_end}
{phang2}{cmd:. fvrevar i.rep78, list}{p_end}

{pstd}Show contents of {cmd:r(varlist)}{p_end}
{phang2}{cmd:. display "`r(varlist)'"}{p_end}

{pstd}Only create two temporary variables corresponding to levels {cmd:2} and
{cmd:3} of factor variable {cmd:rep78} {p_end}
{phang2}{cmd:. fvrevar i(2,3).rep78}{p_end}

{pstd}Show contents of {cmd:r(varlist)}{p_end}
{phang2}{cmd:. display "`r(varlist)'"}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:fvrevar} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(varlist)}}the modified variable list or list of base-variable
names{p_end}
{p2colreset}{...}

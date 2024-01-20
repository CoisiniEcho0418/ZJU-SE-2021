{smcl}
{* *! version 1.2.6  11feb2011}{...}
{viewerdialog cf "dialog cf"}{...}
{vieweralsosee "[D] cf" "mansection D cf"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] compare" "help compare"}{...}
{vieweralsosee "[P] dta_equal" "help dta_equal"}{...}
{viewerjumpto "Syntax" "cf##syntax"}{...}
{viewerjumpto "Description" "cf##description"}{...}
{viewerjumpto "Options" "cf##options"}{...}
{viewerjumpto "Examples" "cf##examples"}{...}
{viewerjumpto "Saved results" "cf##saved_results"}{...}
{title:Title}

{p2colset 5 15 17 2}{...}
{p2col:  {manlink D cf} {hline 2}}Compare two datasets{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 11 2}
{cmd:cf}
{varlist}
{cmd:using}
{it:{help filename}}
[{cmd:,} {opt a:ll} {opt v:erbose}]


{title:Menu}

{phang}
{bf:Data > Data utilities > Compare two datasets}


{marker description}{...}
{title:Description}

{pstd}
{opt cf} compares {varlist} of the dataset in memory (the master dataset)
with the corresponding variables in {it:{help filename}} (the using dataset).
{opt cf} returns nothing (that is, a return code of 0) if
the specified variables are identical and a return code of 9 if there are
any differences.  Only the variable values are compared.  Variable labels,
value labels, notes, characteristics, etc., are not compared.


{marker options}{...}
{title:Options}

{phang}
{opt all} displays the result of the comparison for each variable in 
{varlist}.  Unless {opt all} is specified, only the results of the
variables that differ are displayed.

{phang}
{opt verbose} gives a detailed listing, by variable, of each observation that
differs.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. drop gear_ratio}{p_end}
{phang2}{cmd:. replace mpg = 20 in 1/2}{p_end}
{phang2}{cmd:. replace rep78 = 6 in 3}{p_end}
{phang2}{cmd:. save mycf}{p_end}
{phang2}{cmd:. sysuse auto}

{pstd}Compare the variables in memory with the variables in
{cmd:mycf.dta}{p_end}
{phang2}{cmd:. cf _all using mycf}

{pstd}Same as above, but give a detailed listing of the differences{p_end}
{phang2}{cmd:. cf _all using mycf, verbose}

{pstd}Compare the {cmd:mpg} and {cmd:foreign} variables in memory with those
variables in {cmd:mycf.dta}{p_end}
{phang2}{cmd:. cf mpg foreign using mycf}

{pstd}Same as above, but give a detailed listing of the differences{p_end}
{phang2}{cmd:. cf mpg foreign using mycf, verbose}

{pstd}Same as above, but list all specified variables, even if there are no
differences{p_end}
{phang2}{cmd:. cf mpg foreign using mycf, verbose all}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:cf} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 4 15 19 2: Macros}{p_end}
{synopt:{cmd:r(Nsum)}}number of differences{p_end}
{p2colreset}{...}

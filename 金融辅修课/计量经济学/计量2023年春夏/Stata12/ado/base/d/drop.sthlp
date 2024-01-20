{smcl}
{* *! version 1.2.3  11feb2011}{...}
{viewerdialog "Variables Manager" "stata varmanage"}{...}
{viewerdialog "keep/drop observations" "dialog drop_obs"}{...}
{vieweralsosee "[D] drop" "mansection D drop"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] clear" "help clear"}{...}
{vieweralsosee "[D] varmanage" "help varmanage"}{...}
{viewerjumpto "Syntax" "drop##syntax"}{...}
{viewerjumpto "Description" "drop##description"}{...}
{viewerjumpto "Examples" "drop##examples"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink D drop} {hline 2}}Eliminate variables or observations{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

    Drop variables

{p 8 13 2}{cmd:drop} {varlist}


    Drop observations

{p 8 13 2}{cmd:drop} {help if:{bf:if} {it:exp}}


    Drop a range of observations

{p 8 13 2}{cmd:drop} {help in:{bf:in} {it:range}} [{help if:{bf:if} {it:exp}}]


    Keep variables

{p  8 13 2}{cmd:keep} {varlist}


    Keep observations that satisfy specified condition

{p 8 13 2}{cmd:keep} {help if:{bf:if} {it:exp}}


    Keep a range of observations

{p 8 13 2}{cmd:keep} {help in:{bf:in} {it:range}} [{help if:{bf:if} {it:exp}}]


{phang}
{cmd:by} is allowed with the second syntax of {cmd:drop} and the second
syntax of {cmd:keep}; see {manhelp by D}.


{title:Menu}

    {title:Keep or drop variables}

{phang2}
{bf:Data > Variables Manager}

    {title:Keep or drop observations}

{phang2}
{bf:Data > Create or change data > Keep or drop observations}


{marker description}{...}
{title:Description}

{pstd}
{cmd:drop} eliminates variables or observations from the data in memory.

{pstd}
{cmd:keep} works the same as {cmd:drop}, except that you specify the
variables or observations to be kept rather than the variables or observations
to be deleted.

{pstd}
Warning: {cmd:drop} and {cmd:keep} are not reversible.  Once you have eliminated
observations, you cannot read them back in again.  You would need to go back to
the original dataset and read it in again.  Instead of applying {cmd:drop} or
{cmd:keep} for a subset analysis, consider using {cmd:if} or {cmd:in} to select
subsets temporarily.  This is usually the best strategy.  Alternatively,
applying {cmd:preserve} followed in due course by {cmd:restore} may be a good
approach.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse census}{p_end}

{pstd}Describe the data{p_end}
{phang2}{cmd:. describe}

{pstd}Drop all variables with names that begin with {cmd:pop}{p_end}
{phang2}{cmd:. drop pop*}{p_end}

{pstd}Describe the resulting data{p_end}
{phang2}{cmd:. describe}

{pstd}Drop {cmd:marriage} and {cmd:divorce}{p_end}
{phang2}{cmd:. drop marriage divorce}

{pstd}Describe the resulting data{p_end}
{phang2}{cmd:. describe}

{pstd}Drop any observation for which {cmd:medage} is greater than 32{p_end}
{phang2}{cmd:. drop if medage > 32}

{pstd}Drop the first observation for each region{p_end}
{phang2}{cmd:. by region, sort: drop if _n == 1}

{pstd}Drop all but the last observation in each region{p_end}
{phang2}{cmd:. by region: drop if _n != _N}

{pstd}Keep the first 2 observations in the dataset{p_end}
{phang2}{cmd:. keep in 1/2}

{pstd}Describe the resulting data{p_end}
{phang2}{cmd:. describe}

{pstd}Drop all observations and variables{p_end}
{phang2}{cmd:. drop _all}

{pstd}Describe the resulting data{p_end}
{phang2}{cmd:. describe}{p_end}

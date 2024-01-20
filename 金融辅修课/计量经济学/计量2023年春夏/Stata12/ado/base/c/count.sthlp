{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog count "dialog count"}{...}
{vieweralsosee "[D] count" "mansection D count"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] tabulate oneway" "help tabulate_oneway"}{...}
{viewerjumpto "Syntax" "count##syntax"}{...}
{viewerjumpto "Description" "count##description"}{...}
{viewerjumpto "Examples" "count##examples"}{...}
{viewerjumpto "Saved results" "count##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink D count} {hline 2}}Count observations satisfying specified
conditions{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{opt cou:nt}
{ifin}

{p 4 6 2}
{opt by} is allowed; see {manhelp by D}.


{title:Menu}

{phang}
{bf:Data > Data utilities > Count observations satisfying condition}


{marker description}{...}
{title:Description}

{pstd}
{opt count} counts the number of observations that satisfy the specified
conditions.  If no conditions are specified, {opt count} displays the number of
observations in the data.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}{p_end}

{pstd}Count the number of observations having {cmd:rep78>4}{p_end}
{phang2}{cmd:. count if rep78>4}{p_end}

{pstd}By categories of {cmd:foreign}, count the number of observations having
{cmd:rep78>4}{p_end}
{phang2}{cmd:. by foreign: count if rep78>4}{p_end}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:count} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{p2colreset}{...}

{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[P] levelsof" "mansection P levelsof"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] foreach" "help foreach"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] codebook" "help codebook"}{...}
{vieweralsosee "[D] inspect" "help inspect"}{...}
{vieweralsosee "[R] tabulate oneway" "help tabulate_oneway"}{...}
{viewerjumpto "Syntax" "levelsof##syntax"}{...}
{viewerjumpto "Description" "levelsof##description"}{...}
{viewerjumpto "Options" "levelsof##options"}{...}
{viewerjumpto "Remarks" "levelsof##remarks"}{...}
{viewerjumpto "Examples" "levelsof##examples"}{...}
{viewerjumpto "Saved results" "levelsof##saved_results"}{...}
{viewerjumpto "References" "levelsof##references"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink P levelsof} {hline 2}}Levels of variable{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:levelsof}
{varname}
{ifin}
[{cmd:,} {it:options}]

{synoptset 21}{...}
{synopthdr}
{synoptline}
{synopt:{opt c:lean}}display string values without compound double quotes{p_end}
{synopt:{opt l:ocal(macname)}}insert the list of values in the local macro {it:macname}{p_end}
{synopt:{opt miss:ing}}include missing values of {varname} in calculation{p_end}
{synopt:{opt s:eparate(separator)}}separator to serve as punctuation for the values of returned list; default is a space{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:levelsof} displays a sorted list of the distinct values of {varname}.


{marker options}{...}
{title:Options}

{phang}
{cmd:clean} displays string values without compound double quotes.
By default, each distinct string value is displayed within compound double
quotes, as these are the most general delimiters.  If you know that the
string values in {varname} do not include embedded spaces or embedded
quotes, this is an appropriate option.  {cmd:clean} 
does not affect the display of values from numeric variables.

{phang}
{cmd:local(}{it:macname}{cmd:)} inserts the list of values in
local macro {it:macname} within the calling program's space.  Hence,
that macro will be accessible after {cmd:levelsof} has finished.
This is helpful for subsequent use, especially with {helpb foreach}.

{phang}
{cmd:missing} specifies that missing values of {varname}
should be included in the calculation.  The default is to exclude them.

{phang}
{cmd:separate(}{it:separator}{cmd:)} specifies a separator
to serve as punctuation for the values of the returned list.
The default is a space.  A useful alternative is a comma.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:levelsof} serves two different functions.  First, it gives a
compact display of the distinct values of {it:varname}.  More commonly, it is
useful when you desire to cycle through the distinct values of
{it:varname} with (say) {cmd:foreach}; see {helpb foreach:[P] foreach}.
{cmd:levelsof} leaves behind a list in {cmd:r(levels)} that may be used in a
subsequent command.

{pstd}
{cmd:levelsof} may hit the {help limits} imposed by your Stata.  However,
it is typically used when the number of distinct values of
{it:varname} is modest.

{pstd}
The terminology of levels of a factor has long been standard in
experimental design.  See
{help levelsof##CC1957:Cochran and Cox (1957, 148)},
{help levelsof##F1942:Fisher (1942)}, or
{help levelsof##Y1937:Yates (1937, 5)}.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. sysuse auto}

{phang}{cmd:. levelsof rep78}{p_end}
{phang}{cmd:. display "`r(levels)'"}

{phang}{cmd:. levelsof rep78, miss local(mylevs)}{p_end}
{phang}{cmd:. display "`mylevs'"}

{phang}{cmd:. levelsof rep78, sep(,)}{p_end}
{phang}{cmd:. display "`r(levels)'"}

{pstd}Showing value labels when defined:{p_end}
{pstd}{cmd:. levelsof factor, local(levels)}{break}
{cmd:. foreach l of local levels {c -(}}{break}
{cmd:.{space 8}di "-> factor = `: label (factor) `l''"}{break}
{cmd:.}{space 8}{it:whatever}{cmd: if factor == `l'}{break}
{cmd:. {c )-}}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:levelsof} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(levels)}}list of distinct values{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{marker CC1957}{...}
{phang}
Cochran, W. G., and G. M. Cox. 1957. {it:Experimental Designs}. 2nd ed.
New York: Wiley.

{marker F1942}{...}
{phang}
Fisher, R. A. 1942. The theory of confounding in factorial experiments in
relation to the theory of groups.
{it:Annals of Eugenics} 11: 341-353.

{marker Y1937}{...}
{phang}
Yates, F. 1937. {it:The Design and Analysis of Factorial Experiments}.
Harpenden, England: Technical Communication 35, Imperial Bureau of
Soil Science.
{p_end}

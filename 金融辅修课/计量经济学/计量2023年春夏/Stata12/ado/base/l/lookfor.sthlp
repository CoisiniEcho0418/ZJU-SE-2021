{smcl}
{* *! version 1.2.3  11feb2011}{...}
{vieweralsosee "[D] lookfor" "mansection D lookfor"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] describe" "help describe"}{...}
{vieweralsosee "[D] ds" "help ds"}{...}
{viewerjumpto "Syntax" "lookfor##syntax"}{...}
{viewerjumpto "Description" "lookfor##description"}{...}
{viewerjumpto "Examples" "lookfor##examples"}{...}
{viewerjumpto "Saved results" "lookfor##saved_results"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink D lookfor} {hline 2}}Search for string in variable names and labels{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}{cmd:lookfor} {it:{help strings:string}}
    [{it:{help strings:string}} [...]]


{marker description}{...}
{title:Description}

{pstd}
{cmd:lookfor} helps you find variables by searching for
{it:{help strings:string}} among
all variable names and labels.  If multiple {it:string}s are specified,
{cmd:lookfor} will search for each of them separately.  You may search
for a phrase by enclosing {it:string} in double quotes.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse nlswork}

{pstd}Find all occurrences of {cmd:code} in variable names and labels{p_end}
{phang2}{cmd:. lookfor code}

{pstd}Find all occurrences of {cmd:married} in variable names and
labels{p_end}
{phang2}{cmd:. lookfor married}

{pstd}Find all occurrences of {cmd:gnp} in variable names and labels{p_end}
{phang2}{cmd:. lookfor gnp}

{pstd}Find all occurrences of {cmd:code} or {cmd:married} in variable names
and labels{p_end}
{phang2}{cmd:. lookfor code married}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. sysuse sp500}

{pstd}Find all occurrences of {cmd:price} in variable names and labels{p_end}
{phang2}{cmd:. lookfor price}

{pstd}Find all occurrences of the phrase {cmd:price change} in variable names
and labels{p_end}
{phang2}{cmd:. lookfor "price change"}{p_end}
    {hline}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:lookfor} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(varlist)}}the varlist of found variables{p_end}
{p2colreset}{...}

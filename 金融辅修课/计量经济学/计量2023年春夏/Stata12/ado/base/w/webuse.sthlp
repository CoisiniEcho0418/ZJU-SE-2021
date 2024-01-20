{smcl}
{* *! version 1.2.2  11feb2011}{...}
{viewerdialog webuse "dialog webuse"}{...}
{vieweralsosee "[D] webuse" "mansection D webuse"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[U] 1.2.2 Example datasets" "help dta_contents"}{...}
{vieweralsosee "[D] sysuse" "help sysuse"}{...}
{vieweralsosee "[D] use" "help use"}{...}
{viewerjumpto "Syntax" "webuse##syntax"}{...}
{viewerjumpto "Description" "webuse##description"}{...}
{viewerjumpto "Option" "webuse##option"}{...}
{viewerjumpto "Examples" "webuse##examples"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink D webuse} {hline 2}}Use dataset from Stata website{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Load dataset over the web

{p 8 16 2}
{cmd:webuse} [{cmd:"}]{it:{help filename}}[{cmd:"}] [{cmd:,} {cmd:clear}]


{phang}
Report URL from which datasets will be obtained

{p 8 16 2}
{cmd:webuse} {cmd:query}


{phang}
Specify URL from which dataset will be obtained

{p 8 16 2}
{cmd:webuse} {cmd:set} [{cmd:http://}]{it:url}[{cmd:/}]


{phang}
Reset URL to default

{p 8 16 2}
{cmd:webuse} {cmd:set}


{title:Menu}

{phang}
{bf:File > Example Datasets...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:webuse} {it:{help filename}} loads the specified dataset, obtaining it
over the web.  By default, datasets are obtained from
{cmd:http://www.stata-press.com/data/r12/}.
If {it:filename} is specified without a suffix, {cmd:.dta} is assumed.

{pstd}
{cmd:webuse} {cmd:query} reports the URL from which datasets will be obtained.

{pstd}
{cmd:webuse} {cmd:set} allows you to specify the URL to be used as the source
for datasets.  {cmd:webuse} {cmd:set} without arguments resets the source
to {cmd:http://www.stata-press.com/data/r12/}.


{marker option}{...}
{title:Option}

{phang}
{cmd:clear} specifies that it is okay to replace the data in memory, even
though the current data have not been saved to disk.


{marker examples}{...}
{title:Examples}

{pstd}Report URL from which datasets will be obtained{p_end}
{phang2}{cmd:. webuse query}

{pstd}Change URL from which datasets will be obtained{p_end}
{phang2}{cmd:. webuse set http://www.zzz.edu/users/~sue}

{pstd}Reset URL to the default{p_end}
{phang2}{cmd:. webuse set}

{pstd}Load the {cmd:lifeexp} dataset that is stored at 
http://www.stata-press.com/data/r12{p_end}
{phang2}{cmd:. webuse lifeexp}

{pstd}Equivalent to above command{p_end}
{phang2}{cmd:. use http://www.stata-press.com/data/r12/lifeexp}{p_end}

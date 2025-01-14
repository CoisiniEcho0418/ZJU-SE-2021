{smcl}
{* *! version 2.1.3  10mar2011}{...}
{vieweralsosee "[R] estimates for" "mansection R estimatesfor"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] estimates" "help estimates"}{...}
{viewerjumpto "Syntax" "estimates_for##syntax"}{...}
{viewerjumpto "Description" "estimates_for##description"}{...}
{viewerjumpto "Options" "estimates_for##options"}{...}
{viewerjumpto "Example" "estimates_for##example"}{...}
{title:Title}

{p2colset 5 26 28 2}{...}
{p2col :{manlink R estimates for} {hline 2}}Repeat postestimation command across
models{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{opt est:imates} {cmd:for} {it:namelist} [{cmd:,} {it:options}]{cmd::}
{it:postestimation_command}

{phang}
where {it:namelist} is a name, a list of names, {cmd:_all}, or 
{cmd:*}.{break}
A name may be {cmd:.}, meaning the current (active) estimates.{break}
{cmd:_all} and {cmd:*} mean the same thing.

{col 9}{it:options}{col 30}Description
{col 9}{hline 50}
{col 9}{opt noh:eader}{...}
{col 30}do not display title
{...}
{col 9}{opt nos:top}{...}
{col 30}do not stop if command fails
{col 9}{hline 50}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estimates} {cmd:for} 
performs {it:postestimation_command} 
on each estimation result specified.


{marker options}{...}
{title:Options}

{phang}
{cmd:noheader}
    suppresses the display of the header as {it:postestimation_command}
    is executed each time.

{phang}
{cmd:nostop}
    specifies that execution of {it:postestimation_command} is to 
    be performed on the remaining models even if it fails on some.
    

{marker example}{...}
{title:Example}

    Setup
	{cmd:. sysuse auto}
	{cmd:. gen fwgt = foreign*weight}
	{cmd:. gen dwgt = !foreign*weight}
	{cmd:. gen gpm  = 1/mpg}

{pstd}Fit a linear regression model{p_end}
	{cmd:. regress gpm fwgt dwgt displ foreign}

{pstd}Store the results as {cmd:reg}{p_end}
	{cmd:. estimates store reg}

{pstd}Fit a quantile regression model{p_end}
	{cmd:. qreg gpm fwgt dwgt displ foreign}

{pstd}Store the results as {cmd:qreg}{p_end}
	{cmd:. estimates store qreg}

{pstd}Perform the same test on {cmd:reg} and {cmd:qreg}{p_end}
	{cmd:. estimates for reg qreg: test fwgt==dwgt}

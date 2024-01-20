{smcl}
{* *! version 2.1.2  11feb2011}{...}
{viewerdialog "estimates replay" "dialog estimates_replay"}{...}
{vieweralsosee "[R] estimates replay" "mansection R estimatesreplay"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] estimates" "help estimates"}{...}
{viewerjumpto "Syntax" "estimates_replay##syntax"}{...}
{viewerjumpto "Description" "estimates_replay##description"}{...}
{viewerjumpto "Examples" "estimates_replay##examples"}{...}
{title:Title}

{p2colset 5 29 31 2}{...}
{p2col :{manlink R estimates replay} {hline 2}}Redisplay estimation results{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{opt est:imates} {opt r:eplay} 

{p 8 12 2}
{opt est:imates} {opt r:eplay} 
{it:namelist}


{phang}
where {it:namelist} is a name, a list of names, {cmd:_all}, or 
{cmd:*}.{break}
A name may be {cmd:.}, meaning the current (active) estimates.{break}
{cmd:_all} and {cmd:*} mean the same thing.


{title:Menu}

{phang}
{bf:Statistics > Postestimation > Manage estimation results >}
      {bf:Redisplay estimation output}


{marker description}{...}
{title:Description}

{pstd}
{cmd:estimates} {cmd:replay} 
redisplays the current (active) estimation results, just as 
typing the name of the estimation command would do.

{pstd}
{cmd:estimates} {cmd:replay} {it:namelist} 
redisplays each specified estimation result.  The active 
estimation results are left unchanged.


{marker examples}{...}
{title:Examples}

    Setup
	{cmd:. sysuse auto}
	{cmd:. gen fwgt = foreign*weight}
	{cmd:. gen dwgt = !foreign*weight}
	{cmd:. gen gpm  = 1/mpg}

{pstd}Fit a regression{p_end}
	{cmd:. regress gpm fwgt dwgt displ foreign}

{pstd}Store the results as {cmd:reg}{p_end}
	{cmd:. estimates store reg}

{pstd}Fit a quantile regression{p_end}
	{cmd:. qreg gpm fwgt dwgt displ foreign}

{pstd}Store the results as {cmd:qreg}{p_end}
	{cmd:. estimates store qreg}

{pstd}Test equality of two parameters for each set of results{p_end}
	{cmd:. estimates for reg qreg: test fwgt==dwgt}

{pstd}Replay most recent results{p_end}
        {cmd:. estimates replay}

{pstd}Replay results stored as {cmd:reg}{p_end}
        {cmd:. estimates replay reg}

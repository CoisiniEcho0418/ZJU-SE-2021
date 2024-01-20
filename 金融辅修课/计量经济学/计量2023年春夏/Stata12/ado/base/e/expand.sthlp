{smcl}
{* *! version 1.2.5  11feb2011}{...}
{viewerdialog expand "dialog expand"}{...}
{vieweralsosee "[D] expand" "mansection D expand"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] contract" "help contract"}{...}
{vieweralsosee "[D] expandcl" "help expandcl"}{...}
{vieweralsosee "[D] fillin" "help fillin"}{...}
{viewerjumpto "Syntax" "expand##syntax"}{...}
{viewerjumpto "Description" "expand##description"}{...}
{viewerjumpto "Option" "expand##option"}{...}
{viewerjumpto "Examples" "expand##examples"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink D expand} {hline 2}}Duplicate observations{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:expand} [{cmd:=}]{it:{help exp}} {ifin}
[{cmd:,} {opth gen:erate(newvar)}]


{title:Menu}

{phang}
{bf:Data > Create or change data > Other variable-transformation commands}
     {bf:> Duplicate observations}


{marker description}{...}
{title:Description}

{pstd}
{cmd:expand} replaces each observation in the dataset with n
copies of the observation, where n is equal to the required expression
rounded to the nearest integer.  If the expression is less than 1 or equal to
missing, it is interpreted as if it were 1, and the observation is
retained but not duplicated.


{marker option}{...}
{title:Option}

{p 4 8 2}
{opth generate(newvar)}
    creates new variable {it:newvar} containing {cmd:0} if the observation
    originally appeared in the dataset and {cmd:1} if the observation is a 
    duplicate.
    For instance, 
    after an {cmd:expand}, you could revert to the original 
    observations by typing {cmd:keep} {cmd:if} {it:newvar}{cmd:==0}.


{marker examples}{...}
{title:Examples}

    {hline}
    Setup
{phang2}{cmd:. webuse stackxmpl}

    List the original data
{phang2}{cmd:. list}

{pstd}Replace each observation with 2 copies of the observation (original
observation is retained and 1 new observation is created){p_end}
{phang2}{cmd:. expand 2}

    List the results
{phang2}{cmd:. list}

    {hline}
    Setup
{phang2}{cmd:. webuse stackxmpl, clear}

    List the original data
{phang2}{cmd:. list}

{pstd}Replace each observation with {it:x} copies of that observation,
where {it:x} is the value of {cmd:b} for that observation{p_end}
{phang2}{cmd:. expand b}

    List the results
{phang2}{cmd:. list}{p_end}

    {hline}

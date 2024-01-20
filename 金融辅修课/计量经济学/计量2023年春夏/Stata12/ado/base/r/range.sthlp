{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog range "dialog range"}{...}
{vieweralsosee "[D] range" "mansection D range"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] egen" "help egen"}{...}
{vieweralsosee "[D] obs" "help obs"}{...}
{viewerjumpto "Syntax" "range##syntax"}{...}
{viewerjumpto "Description" "range##description"}{...}
{viewerjumpto "Example" "range##example"}{...}
{title:Title}

{p2colset 5 18 21 2}{...}
{p2col :{manlink D range} {hline 2}}Generate numerical range{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:range} {varname} {it:#first} {it:#last} [{it:#obs}]


{title:Menu}

{phang}
{bf:Data > Create or change data > Other variable-creation commands >}
    {bf:Generate numerical range}


{marker description}{...}
{title:Description}

{pstd}
{cmd:range} generates a numerical range, which is useful for evaluating and
graphing functions.


{marker example}{...}
{title:Example}

{pstd}Clear data{p_end}
{phang2}{cmd:. drop _all}

{pstd}Create 100 observations on {cmd:x} from 0 to 4*pi{p_end}
{phang2}{cmd:. range x 0 4*_pi 100}

{pstd}Create {cmd:y} = f(x){p_end}
{phang2}{cmd:. generate y = exp(-x/6)*sin(x)}

{pstd}Graph the function{p_end}
{phang2}{cmd:. line y x}{p_end}

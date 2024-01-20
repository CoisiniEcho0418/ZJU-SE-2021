{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog compare "dialog compare"}{...}
{vieweralsosee "[D] compare" "mansection D compare"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] cf" "help cf"}{...}
{vieweralsosee "[D] codebook" "help codebook"}{...}
{vieweralsosee "[D] inspect" "help inspect"}{...}
{viewerjumpto "Syntax" "compare##syntax"}{...}
{viewerjumpto "Description" "compare##description"}{...}
{viewerjumpto "Example" "compare##example"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink D compare} {hline 2}}Compare two variables{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:compare}
{it:{help varname}1}
{it:{help varname}2}
{ifin}

{pstd}
{opt by} is allowed; see {manhelp by D}.


{title:Menu}

{phang}
{bf:Data > Data utilities > Compare two variables}


{marker description}{...}
{title:Description}

{pstd}
{opt compare} reports the differences and similarities
between {it:{help varname}1} and {it:varname2}.


{marker example}{...}
{title:Example}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse fullauto}{p_end}

{pstd}Report differences between {cmd:rep77} and {cmd:rep78}{p_end}
{phang2}{cmd:. compare rep77 rep78}{p_end}

{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog fillin "dialog fillin"}{...}
{vieweralsosee "[D] fillin" "mansection D fillin"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] cross" "help cross"}{...}
{vieweralsosee "[D] expand" "help expand"}{...}
{vieweralsosee "[D] joinby" "help joinby"}{...}
{vieweralsosee "[D] save" "help save"}{...}
{viewerjumpto "Syntax" "fillin##syntax"}{...}
{viewerjumpto "Description" "fillin##description"}{...}
{viewerjumpto "Examples" "fillin##examples"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink D fillin} {hline 2}}Rectangularize dataset{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

	{cmd:fillin} {varlist}


{title:Menu}

{phang}
{bf:Data > Create or change data > Other variable-transformation commands}
     {bf:> Rectangularize dataset}


{marker description}{...}
{title:Description}

{pstd}
{opt fillin} adds observations with missing data so that all interactions
of {varlist} exist, thus making a complete rectangularization of
{it:varlist}.  {opt fillin} also adds the variable {opt _fillin} to the
dataset.  {opt _fillin} is 1 for observations created by using {opt fillin}
and 0 for previously existing observations.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse fillin1}

{pstd}List the data{p_end}
{phang2}{cmd:. list}

{pstd}Create observations with missing values for all combinations of
{cmd:sex}, {cmd:race}, and {cmd:age_group} that are in the dataset{p_end}
{phang2}{cmd:. fillin sex race age_group}

{pstd}List the data{p_end}
{phang2}{cmd:. list}{p_end}

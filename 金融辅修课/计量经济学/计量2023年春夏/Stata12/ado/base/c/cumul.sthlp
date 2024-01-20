{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog cumul "dialog cumul"}{...}
{vieweralsosee "[R] cumul" "mansection R cumul"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] diagnostic plots" "help diagnostic_plots"}{...}
{vieweralsosee "[R] kdensity" "help kdensity"}{...}
{vieweralsosee "[D] stack" "help stack"}{...}
{viewerjumpto "Syntax" "cumul##syntax"}{...}
{viewerjumpto "Description" "cumul##description"}{...}
{viewerjumpto "Options" "cumul##options"}{...}
{viewerjumpto "Examples" "cumul##examples"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink R cumul} {hline 2}}Cumulative distribution{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:cumul}
{varname}
{ifin}
{weight}
{cmd:,}
{opth g:enerate(newvar)}
[{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Main}
{p2coldent :* {opth g:enerate(newvar)}}create variable {it:newvar}{p_end}
{synopt :{opt f:req}}use frequency units for cumulative{p_end}
{synopt :{opt eq:ual}}generate equal cumulatives for tied values{p_end}
{synoptline}
{p 4 6 2}
* {opt generate(newvar)} is required.{p_end}
{p 4 6 2}
{opt by} is allowed; see {manhelp by D}.{p_end}
{p 4 6 2}
{opt fweight}s and {opt aweight}s are allowed; see {help weight}.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Summaries, tables, and tests > Distributional plots and tests}
      {bf:> Generate cumulative distribution}


{marker description}{...}
{title:Description}

{pstd}
{opt cumul} creates {newvar}, defined as the empirical cumulative
distribution function of {varname}.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opth generate(newvar)} is required.  It specifies
the name of the new variable to be created.

{phang}
{opt freq} specifies that the cumulative be in frequency units; otherwise, it
is normalized so that {newvar} is 1 for the largest value of {varname}.

{phang}
{opt equal} requests that observations with equal values in
{varname} get the same cumulative value in {newvar}.


{marker examples}{...}
{title:Examples}

{pstd}
To graph cumulative distribution:{p_end}

{phang2}{cmd:. webuse hsng}{p_end}
{phang2}{cmd:. cumul faminc, gen(cum)}{p_end}
{phang2}{cmd:. line cum faminc, sort}

{pstd}
To graph two cumulative distributions on the same graph:{p_end}

{phang2}{cmd:. sysuse citytemp, clear}{p_end}
{phang2}{cmd:. cumul tempjan, gen(cjan)}{p_end}
{phang2}{cmd:. cumul tempjuly, gen(cjuly)}{p_end}
{phang2}{cmd:. stack cjan tempjan  cjuly tempjuly, into(c temp) wide clear}{p_end}
{phang2}{cmd:. line cjan cjuly temp, sort}{p_end}

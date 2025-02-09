{smcl}
{* *! version 1.1.8  11feb2011}{...}
{viewerdialog ipolate "dialog ipolate"}{...}
{vieweralsosee "[D] ipolate" "mansection D ipolate"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] mi impute" "help mi_impute"}{...}
{vieweralsosee "[R] lowess" "help lowess"}{...}
{viewerjumpto "Syntax" "ipolate##syntax"}{...}
{viewerjumpto "Description" "ipolate##description"}{...}
{viewerjumpto "Options" "ipolate##options"}{...}
{viewerjumpto "Examples" "ipolate##examples"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink D ipolate} {hline 2}}Linearly interpolate (extrapolate)
values{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:ipolate}
{it:yvar}
{it:xvar}
{ifin}
{cmd:,}
{opth g:enerate(newvar)} [{opt e:polate}]

{phang}
{opt by} is allowed; see {manhelp by D}.


{title:Menu}

{phang}
{bf:Data > Create or change data > Other variable-creation commands >}
      {bf:Linearly interpolate/extrapolate values}


{marker description}{...}
{title:Description}

{pstd}
{opt ipolate} creates in {newvar} a linear interpolation of
{it:yvar} on {it:xvar} for missing values of {it:yvar}.

{pstd}
Because interpolation requires that {it:yvar} be a function of {it:xvar},
{it:yvar} is also interpolated for tied values of {it:xvar}.  When {it:yvar}
is not missing and {it:xvar} is neither missing nor repeated, the value of
{it:newvar} is just {it:yvar}.


{marker options}{...}
{title:Options}

{phang}{opth generate(newvar)} is required and specifies the
name of the new variable to be created.

{phang}{opt epolate} specifies that values be both interpolated and
extrapolated.  Interpolation only is the default.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse ipolxmpl1}

{pstd}List the data{p_end}
{phang2}{cmd:. list, sep(0)}

{pstd}Create {cmd:y1} containing a linear interpolation of {cmd:y} on {cmd:x}
for missing values of {cmd:y}{p_end}
{phang2}{cmd:. ipolate y x, gen(y1)}

{pstd}Create {cmd:y2} containing a linear interpolation and extrapolation of
{cmd:y} on {cmd:x} for missing values of {cmd:y}{p_end}
{phang2}{cmd:. ipolate y x, gen(y2) epolate}

{pstd}List the result{p_end}
{phang2}{cmd:. list, sep(0)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse ipolxmpl2, clear}{p_end}

{pstd}Show years for which the circulation data are missing{p_end}
{phang2}{cmd:. tabulate circ year if circ == ., missing}

{pstd}Create {cmd:icirc} containing a linear interpolation of {cmd:circ} on
{cmd:year} for missing values of {cmd:circ} and perform this calculation
separately for each {cmd:magazine}{p_end}
{phang2}{cmd:. by magazine: ipolate circ year, gen(icirc)}{p_end}
    {hline}

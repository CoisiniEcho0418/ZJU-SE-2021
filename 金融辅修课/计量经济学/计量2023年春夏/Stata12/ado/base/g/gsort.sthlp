{smcl}
{* *! version 1.1.6  08mar2011}{...}
{viewerdialog gsort "dialog gsort"}{...}
{vieweralsosee "[D] gsort" "mansection D gsort"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] sort" "help sort"}{...}
{viewerjumpto "Syntax" "gsort##syntax"}{...}
{viewerjumpto "Description" "gsort##description"}{...}
{viewerjumpto "Options" "gsort##options"}{...}
{viewerjumpto "Examples" "gsort##examples"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{manlink D gsort} {hline 2}}Ascending and descending sort{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:gsort}
[{cmd:+}|{cmd:-}]
{varname}
[[{cmd:+}|{cmd:-}]
{varname} {it:...}]
[{cmd:,}
{opth g:enerate(newvar)} {opt m:first}]


{title:Menu}

{phang}
{bf:Data > Sort > Ascending and descending sort}


{marker description}{...}
{title:Description}

{pstd}
{opt gsort} arranges observations to be in ascending or descending
order of the specified variables and so differs from {opt sort} in that
{opt sort} produces ascending-order arrangements only; see {manhelp sort D}.

{pstd}
Each {varname} can be numeric or a string.

{pstd}
The observations are placed in ascending order of {it:varname} if {opt +}
or nothing is typed in front of the name and are placed in descending order if
{opt -} is typed.


{marker options}{...}
{title:Options}

{phang}
{opth generate(newvar)} creates {it:newvar} containing 1, 2,
3, ... for each group denoted by the ordered data.  This is
useful when using the ordering in a subsequent {helpb by} operation.

{phang}
{opt mfirst} specifies that missing values be placed first in
descending orderings rather than last.


{marker examples}{...}
{title:Examples}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto}

{pstd}Place observations in ascending order of {cmd:price}{p_end}
{phang2}{cmd:. gsort price}

{pstd}Same as above command{p_end}
{phang2}{cmd:. gsort +price} 

{pstd}List the 10 lowest-priced cars in the data{p_end}
{phang2}{cmd:. list make price in 1/10}

{pstd}Place observations in descending order of {cmd:price}{p_end}
{phang2}{cmd:. gsort -price}

{pstd}List the 10 highest-priced cars in the data{p_end}
{phang2}{cmd:. list make price in 1/10}

{pstd}Place observations in alphabetical order of {cmd:make}{p_end}
{phang2}{cmd:. gsort make}

{pstd}List {cmd:make} in alphabetical order{p_end}
{phang2}{cmd:. list make}

{pstd}Place observations in reverse alphabetical order of {cmd:make}{p_end}
{phang2}{cmd:. gsort -make}

{pstd}List {cmd:make} in reverse alphabetical order{p_end}
{phang2}{cmd:. list make}

    {hline}
    Setup
{phang2}{cmd:. webuse bp3}

{pstd}Place observations in ascending order of {cmd:time} within ascending
order of {cmd:id}{p_end}
{phang2}{cmd:. gsort id time}

{pstd}List each patient's blood pressures in the order measurements were
taken{p_end}
{phang2}{cmd:. list id time bp}

{pstd}Place observations in descending order of {cmd:time} within ascending
order of {cmd:id}{p_end}
{phang2}{cmd:. gsort id -time}

{pstd}List each patient's blood pressures in reverse-time order{p_end}
{phang2}{cmd:. list id time bp}{p_end}
    {hline}

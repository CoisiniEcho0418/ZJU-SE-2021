{smcl}
{* *! version 1.1.1  11feb2011}{...}
{findalias asfrvarlists}{...}
{vieweralsosee "" "--"}{...}
{findalias asfrsyntax}{...}
{findalias asfrvarabbrev}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[U] 11.4.2 Lists of new variables (newvar)" "help newvar"}{...}
{viewerjumpto "Description" "varname##description"}{...}
{viewerjumpto "Examples" "varname##examples"}{...}
{title:Title}

    {hi:varname} (from {findalias frvarlists})


{marker description}{...}
{title:Description}

{pstd}
A {it:varname} is one variable name, such as 

{p 8 34 2}{cmd:x}{p_end}
{p 8 34 2}{cmd:myvar}{p_end}
{p 8 34 2}{cmd:Myvar}{p_end}
{p 8 34 2}{cmd:inc92}{p_end}
{p 8 34 2}{cmd:reciprocal_of_miles_per_gallon}{p_end}
{p 8 34 2}{cmd:_odd}{p_end}
{p 8 34 2}{cmd:_1994}{p_end}

{pstd}
Variable names may be 1 to 32 characters long and must start with 
{cmd:a}-{cmd:z}, {cmd:A}-{cmd:Z}, or {cmd:_}, and the remaining 
characters may be 
{cmd:a}-{cmd:z}, {cmd:A}-{cmd:Z}, {cmd:_}, or {cmd:0}-{cmd:9}.

{pstd}
When we use the term varname, we usually mean an existing varname -- a
variable that already exists in the dataset.  The alternative would be a
{it:{help newvar}}.

{pstd} 
When referring to an existing varname, we can abbreviate -- use only some of
the leading characters -- as long as we specify enough to uniquely identify 
the variable:

{pin}
{cmd:Myv} might be a unique abbreviation for {cmd:Myvar}.

{pin}
{cmd:reciprocal} might be a unique abbreviation for
{cmd:reciprocal_of_miles_per_gallon}.

{pstd}
Sometimes we can use the full {it:{help varlist}} notation, but 
it must identify one variable:

{pin}
{cmd:my*r} might uniquely identify {cmd:myvar}

{pin}
{cmd:r*gallon} might uniquely identify
{cmd:reciprocal_of_miles_per_gallon}.

{pstd}
In the varlist notation, 
{cmd:*} means that zero or more characters go here.

{pstd}
Varnames are often specified inside options, and then sometimes 
the varlist notation is allowed and sometimes it is not.  Abbreviations
are always allowed, however, assuming that you have not turned them off; 
see {helpb set varabbrev}.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. sysuse auto}{p_end}
{phang}{cmd:. list gear_ratio in 1/10}{p_end}
{phang}{cmd:. generate weightSquared = weight^2}{p_end}
{phang}{cmd:. list we* in 1/10}{p_end}
{phang}{cmd:. format weightS %12.0gc}{p_end}
{phang}{cmd:. rename rep78 repair_record_of_cars_in_1978}{p_end}
{phang}{cmd:. describe rep, fullnames}{p_end}

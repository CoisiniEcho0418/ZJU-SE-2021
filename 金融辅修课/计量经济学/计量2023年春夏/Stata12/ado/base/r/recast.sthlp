{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[D] recast" "mansection D recast"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] compress" "help compress"}{...}
{vieweralsosee "[D] data types" "help data_types"}{...}
{vieweralsosee "[D] destring" "help destring"}{...}
{viewerjumpto "Syntax" "recast##syntax"}{...}
{viewerjumpto "Description" "recast##description"}{...}
{viewerjumpto "Options" "recast##options"}{...}
{viewerjumpto "Examples" "recast##examples"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink D recast} {hline 2}}Change storage type of variable{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 15 2}{cmd:recast} {it:{help data types:type}} {varlist}
           [{cmd:,} {opt force}]

{p 4 6 2}
where {it:type} is {cmd:byte}, {cmd:int}, {cmd:long}, {cmd:float},
{cmd:double}, or {cmd:str1}, {cmd:str2}, ..., {cmd:str244}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:recast} changes the storage type of the variables identified in
{varlist} to {it:{help data types:type}}.


{marker options}{...}
{title:Options}

{phang}
{cmd:force} makes {cmd:recast} unsafe by causing the variables
to be given the new storage type even if that will cause a loss of precision,
introduction of missing values, or, for a string variables, the
truncation of strings.

{pmore}
{cmd:force} should be used with caution.  {cmd:force} is for those
instances where you have a variable saved as a {cmd:double} but would now be
satisfied to have the variable stored as a {cmd:float}, even though that would
lead to a slight rounding of its values.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse auto}

{pstd}Describe the variable {cmd:mpg}{p_end}
{phang2}{cmd:. describe mpg}

{pstd}Change the storage type of {cmd:mpg} from {cmd:int} to {cmd:byte}{p_end}
{phang2}{cmd:. recast byte mpg}

{pstd}Describe the variable {cmd:mpg}{p_end}
{phang2}{cmd:. describe mpg}

{pstd}Describe the variable {cmd:headroom}{p_end}
{phang2}{cmd:. describe headroom}

{pstd}Try to change the storage type of {cmd:headroom} from {cmd:float} to
{cmd:int}{p_end}
{phang2}{cmd:. recast int headroom}

{pstd}Describe the variable {cmd:headroom}{p_end}
{phang2}{cmd:. describe headroom}

{pstd}Describe the variable {cmd:make}{p_end}
{phang2}{cmd:. describe make}

{pstd}Try to change the storage type of {cmd:make} from {cmd:str18} to
{cmd:str16}{p_end}
{phang2}{cmd:. recast str16 make}

{pstd}Change the storage type of {cmd:make} from {cmd:str18} to
{cmd:str20}{p_end}
{phang2}{cmd:. recast str20 make}

{pstd}Describe the variable {cmd:make}{p_end}
{phang2}{cmd:. describe make}{p_end}

{smcl}
{* *! version 1.0.4  11feb2011}{...}
{vieweralsosee "[P] fvexpand" "mansection P fvexpand"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[U] 11.4.3 Factor variables" "help fvvarlist"}{...}
{viewerjumpto "Syntax" "fvexpand##syntax"}{...}
{viewerjumpto "Description" "fvexpand##description"}{...}
{viewerjumpto "Remarks" "fvexpand##remarks"}{...}
{viewerjumpto "Saved results" "fvexpand##saved_results"}{...}
{title:Title}

{p2colset 4 17 20 2}{...}
{p2col:{manlink P fvexpand}}{hline 2} Expand factor varlists


{marker syntax}{...}
{title:Syntax}

{phang2}
{cmd:fvexpand} [{varlist}] {ifin}

{phang}
{it:varlist} may contain factor variables and time-series operators; see
{help fvvarlist} and {help tsvarlist}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:fvexpand} expands a factor varlist to the corresponding expanded,
specific varlist.  {varlist} may be general or specific and even may
already be expanded.


{marker remarks}{...}
{title:Remarks}

{pstd}
An example of a general factor varlist is {cmd:mpg} {cmd:i.foreign}.  The
corresponding specific factor varlist would be {cmd:mpg}
{cmd:i(0 1)b0.foreign} if {cmd:foreign} took on the values 0 and 1 in the
data.

{pstd}
A specific factor varlist is specific with respect to a given problem, which
is to say, a given dataset and subsample.  The specific varlist identifies the
values taken on by factor variables and the base.

{pstd}
Factor varlist {cmd:mpg} {cmd:i(0 1)b0.foreign} is specific.  The
same varlist could be written as {cmd:mpg} {cmd:i0b.foreign} {cmd:i1.foreign},
so that is specific, too.  The first is unexpanded and specific.  The second
is expanded and specific.

{pstd}
{cmd:fvexpand} takes a general or specific (expanded or unexpanded) factor
varlist, along with an optional {cmd:if} or {cmd:in}, and returns a fully
expanded, specific varlist.


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:fvexpand} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 25 29 2: Macros}{p_end}
{synopt:{cmd:r(varlist)}}the expanded, specific varlist{p_end}

{smcl}
{* *! version 1.0.2  11feb2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix rownames" "help matrix_rownames"}{...}
{viewerjumpto "Syntax" "_ms_build_info##syntax"}{...}
{viewerjumpto "Description" "_ms_build_info##description"}{...}
{viewerjumpto "Option" "_ms_build_info##option"}{...}
{viewerjumpto "Saved results" "_ms_build_info##saved_results"}{...}
{title:Title}

{p2colset 4 26 28 2}{...}
{p2col:{hi:[P] _ms_build_info} {hline 2}}Building extra factor-variables information into column stripes
{p_end}


{marker syntax}{...}
{title:Syntax}

{phang2}
{cmd:_ms_build_info} {it:matrix_name} {ifin} {weight} [{cmd:,} {opt row}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:_ms_build_info} builds some factor-variables information from the dataset
and stores it with the column stripe for {it:matrix_name}.  This information
identifies empty cells in factors and interactions in the column stripe.


{marker option}{...}
{title:Option}

{phang}
{opt row} specifies that the information come from the row stripe.  The
default is the column stripe.


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:_ms_build_info} stores its results directly in the stripe information
associated with {it:matrix_name}.
{p_end}

{smcl}
{* *! version 1.0.2  11feb2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix rownames" "help matrix_rownames"}{...}
{viewerjumpto "Syntax" "_ms_empty_info##syntax"}{...}
{viewerjumpto "Description" "_ms_empty_info##description"}{...}
{viewerjumpto "Saved results" "_ms_empty_info##saved_results"}{...}
{title:Title}

{p2colset 4 23 26 2}{...}
{p2col:{hi:[P] _ms_empty_info}}{hline 2} Matrix stripe information on elements
flagged as empty cells


{marker syntax}{...}
{title:Syntax}

{phang2}
{cmd:_ms_empty_info} {it:matrix_name}


{marker description}{...}
{title:Description}

{pstd}
{cmd:_ms_empty_info} returns a matrix that identifies which elements of
{it:matrix_name} are flagged as empty cells.


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:_ms_empty_info} saves the following in {cmd:r()}:

{pstd}Scalars{p_end}
{p2colset 9 20 20 2}{...}
{p2col: {cmd:r(k_empty)}}number of elements flagged as empty{p_end}

{pstd}Matrices{p_end}
{p2colset 9 20 20 2}{...}
{p2col: {cmd:r(empty)}}the
	elements of {it:matrix_name} that are flagged as empty{p_end}

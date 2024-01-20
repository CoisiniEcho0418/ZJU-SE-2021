{smcl}
{* *! version 1.0.1  11feb2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix rownames" "help matrix_rownames"}{...}
{viewerjumpto "Syntax" "_ms_omit_info##syntax"}{...}
{viewerjumpto "Description" "_ms_omit_info##description"}{...}
{viewerjumpto "Saved results" "_ms_omit_info##saved_results"}{...}
{title:Title}

{p2colset 4 22 25 2}{...}
{p2col:{hi:[P] _ms_omit_info}}{hline 2} Matrix stripe information on elements
flagged as omitted because of collinearity


{marker syntax}{...}
{title:Syntax}

{phang2}
{cmd:_ms_omit_info} {it:matrix_name}


{marker description}{...}
{title:Description}

{pstd}
{cmd:_ms_omit_info} returns a matrix that identifies which elements of
{it:matrix_name} are flagged as omitted because of collinearity.


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:_ms_omit_info} saves the following in {cmd:r()}:

{pstd}Scalars{p_end}
{p2colset 9 20 20 2}{...}
{p2col: {cmd:r(k_omit)}}number of elements flagged as omitted{p_end}

{pstd}Matrices{p_end}
{p2colset 9 20 20 2}{...}
{p2col: {cmd:r(omit)}}indicates
	which elements of {it:matrix_name} are flagged as omitted{p_end}

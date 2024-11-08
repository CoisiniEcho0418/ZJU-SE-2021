{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix rownames" "help matrix_rownames"}{...}
{viewerjumpto "Syntax" "_ms_element_info##syntax"}{...}
{viewerjumpto "Description" "_ms_element_info##description"}{...}
{viewerjumpto "Options" "_ms_element_info##options"}{...}
{viewerjumpto "Saved results" "_ms_element_info##saved_results"}{...}
{title:Title}

{pstd}
{hi:[P] _ms_element_info} {hline 2} Matrix stripe element information


{marker syntax}{...}
{title:Syntax}

{phang2}
{cmd:_ms_element_info} {cmd:,}
	{opt el:ement(#)}
	[{opt mat:rix(name)}
		{opt row}
		{opt eq:uation(eqid)}
		{opt w:idth(#)}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:_ms_element_info} returns information about the specified element in the
column stripe on {cmd:e(b)}.  The resulting strings can be used to build row
titles for a coefficient table.


{marker options}{...}
{title:Options}

{phang}
{opt element(#)} specifies that the information come from the {it:#}th element
in the first equation.

{phang}
{opt matrix(name)} specifies that {cmd:_ms_eq_info} report information from the
column stripe associated with the named matrix.  The default matrix is
{cmd:e(b)}.

{phang}
{opt row} specifies that the information come from the row stripe.  The
default is the column stripe.

{phang}
{opt equation(eqid)} specifies that {opt element(#)} refers to the {it:#}th
element within the identified equation.  The default is the first equation.

{phang}
{opt width(#)} affects how the returned strings are split/abbreviated.  The
default is {cmd:width(12)}.


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:_ms_element_info} saves the following in {cmd:r()}:

{pstd}Scalars{p_end}
{p2colset 9 24 28 2}{...}
{p2col: {cmd:r(k)}}number of level values in {cmd:r(level)}{p_end}
{p2col: {cmd:r(k_term)}}number
	of macros that split/abbreviate {cmd:r(term)}{p_end}
{p2col: {cmd:r(k_operator)}}number
	of macros that split {cmd:r(operator)}{p_end}
{p2col: {cmd:r(k_level)}}number
	of macros that split {cmd:r(level)}{p_end}

{pstd}Macros{p_end}
{p2col: {cmd:r(type)}}element type:  {cmd:variable}, {cmd:factor}, {cmd:interaction}{p_end}
{p2col: {cmd:r(term)}}term associated with the element{p_end}
{p2col: {cmd:r(term}{it:#}{cmd:)}}{it:#}th split/abbreviated piece of
          {cmd:r(term)}{p_end}
{p2col: {cmd:r(operator)}}time-series operator if specified element is
        a time-series operated standard variable{p_end}
{p2col: {cmd:r(operator}{it:#}{cmd:)}}{it:#}th split piece of {cmd:r(operator)}
{p_end}
{p2col: {cmd:r(level)}}factor levels that identify the element within the term
{p_end}
{p2col: {cmd:r(level}{it:#}{cmd:)}}{it:#}th split piece of {cmd:r(level)}{p_end}
{p2col: {cmd:r(note)}}"", {cmd:(base)}, {cmd:(empty)}, {cmd:(omitted)}{p_end}

{smcl}
{* *! version 1.0.4  11feb2011}{...}
{vieweralsosee undocumented "help undocumented"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] st_matrix()" "help mf_st_matrix"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] matrix rownames" "help matrix_rownames"}{...}
{vieweralsosee "[P] _ms_element_info" "help _ms_element_info"}{...}
{vieweralsosee "[P] _ms_eq_info" "help _ms_eq_info"}{...}
{viewerjumpto "Syntax" "mf_st_ms_utils##syntax"}{...}
{viewerjumpto "Description" "mf_st_ms_utils##description"}{...}
{viewerjumpto "Conformability" "mf_st_ms_utils##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_st_ms_utils##diagnostics"}{...}
{viewerjumpto "Source code" "mf_st_ms_utils##source"}{...}
{title:Title}

{phang}
{cmd:[M-5] st_ms_utils()} {hline 2} Matrix stripe utilities


{marker syntax}{...}
{title:Syntax}

{phang2}
{it:string matrix}
{cmd:st_matrixrowstripe_split(}{it:name}{cmd:,}
	{it:width}{cmd:,} {it:colon}{cmd:)}

{phang2}
{it:string matrix}
{cmd:st_matrixcolstripe_split(}{it:name}{cmd:,}
	{it:width}{cmd:,} {it:colon}{cmd:)}

{phang2}
{it:real matrix}{space 2}
{cmd:st_matrixrowstripe_fvinfo(}{it:name}{cmd:)}

{phang2}
{it:real matrix}{space 2}
{cmd:st_matrixcolstripe_fvinfo(}{it:name}{cmd:)}

{phang2}
{it:void}{space 9}
{cmd:st_matrixrowstripe_fvinfo(}{it:name}{cmd:,} {it:info}{cmd:)}

{phang2}
{it:void}{space 9}
{cmd:st_matrixcolstripe_fvinfo(}{it:name}{cmd:,} {it:info}{cmd:)}

{pstd}
where

	  {it:name}:  {it:string scalar}
	 {it:width}:  {it:real   scalar}
	 {it:colon}:  {it:real   scalar}  (optional)
	  {it:info}:  {it:real   matrix}


{marker description}{...}
{title:Description}

{pstd}
{cmd:st_matrixrowstripe_split(}{it:name}{cmd:,} {it:width}{cmd:)}
returns a string matrix, {it:S}, whose elements are made up of the row
stripes of the Stata matrix {it:name}.  The first column of {it:S} contains
the equation names; the remaining columns are split according to standard
splitting rules for factor variables, interactions, and time-series operators.
{it:width} specifies the maximum number of characters that each element of
{it:S} is allowed to contain.
{cmd:st_matrixrowstripe_split(}{it:name}{cmd:,} {it:width}{cmd:,} {cmd:0}{cmd:)}
will suppress the colon from the equation names in the first column of {it:S};
the default is to append a colon to the nonempty equation names in the first
column of {it:S}.

{pstd}
{cmd:st_matrixcolstripe_split(}{it:name}{cmd:,} {it:width}{cmd:)}
returns a string matrix, {it:S}, whose elements are made up of the column
names of the Stata matrix {it:name}.  The columns are split according to
standard splitting rules for factor variables, interactions, and time-series
operators.  {it:width} specifies the maximum number of characters that each
element of {it:S} is allowed to contain.
{cmd:st_matrixcolstripe_split(}{it:name}{cmd:,} {it:width}{cmd:,} {cmd:0}{cmd:)}
will suppress the colon from the equation names in the first column of {it:S};
the default is to append a colon to the nonempty equation names in the first
column of {it:S}.

{pstd}
{cmd:st_matrixrowstripe_fvinfo(}{it:name}{cmd:)} returns factor-variables
information hidden in the row stripe of Stata matrix {it:name}.

{pstd}
{cmd:st_matrixcolstripe_fvinfo(}{it:name}{cmd:)} returns factor-variables
information hidden in the column stripe of Stata matrix {it:name}.

{pstd}
{cmd:st_matrixrowstripe_fvinfo(}{it:name}{cmd:,} {it:info}{cmd:)} sets the
hidden factor-variables information for the row stripe of Stata matrix
{it:name}.

{pstd}
{cmd:st_matrixcolstripe_fvinfo(}{it:name}{cmd:,} {it:info}{cmd:)} sets the
hidden factor-variables information for the column stripe of Stata matrix
{it:name}.


{marker conformability}{...}
{title:Conformability}

    {cmd:st_matrixrowstripe_split(}{it:name}{cmd:,} {it:width}{cmd:,} {it:colon}{cmd:)}:
	     {it:name}:  1 {it:x} 1
	    {it:width}:  1 {it:x} 1
	    {it:colon}:  1 {it:x} 1  (optional)
	   {it:result}:  {it:n x m}  (0 {it:x} 2 if not found)

    {cmd:st_matrixcolstripe_split(}{it:name}{cmd:,} {it:width}{cmd:,} {it:colon}{cmd:)}:
	     {it:name}:  1 {it:x} 1
	    {it:width}:  1 {it:x} 1
	    {it:colon}:  1 {it:x} 1  (optional)
	   {it:result}:  {it:n x m}  (0 {it:x} 2 if not found)

    {cmd:st_matrixrowstripe_fvinfo(}{it:name}{cmd:)}:
	     {it:name}:  1 {it:x} 1
	   {it:result}:  {it:n x} 2  (0 {it:x} 2 if not found)

    {cmd:st_matrixcolstripe_fvinfo(}{it:name}{cmd:)}:
	     {it:name}:  1 {it:x} 1
	   {it:result}:  {it:n x} 2  (0 {it:x} 2 if not found)

    {cmd:st_matrixrowstripe_fvinfo(}{it:name}{cmd:,} {it:info}{cmd:)}:
	     {it:name}:  1 {it:x} 1
	     {it:info}:  {it:n x} 2
	   {it:result}:  {it:void}

    {cmd:st_matrixcolstripe_fvinfo(}{it:name}{cmd:,} {it:info}{cmd:)}:
	     {it:name}:  1 {it:x} 1
	     {it:info}:  {it:n x} 2
	   {it:result}:  {it:void}


{marker diagnostics}{...}
{title:Diagnostics}

{pstd}
{cmd:st_matrixrowstripe_split(}{it:name}{cmd:,} {it:width}{cmd:,} {it:colon}{cmd:)} and
{cmd:st_matrixcolstripe_split(}{it:name}{cmd:,} {it:width}{cmd:,} {it:colon}{cmd:)}
abort with error if any of the arguments is malformed.  These functions
return {cmd:J(0,2,"")} if Stata matrix {it:name} does not exist.  {it:width}
is assumed to be 12 if {it:width}<5 or missing.  {it:colon} indicates whether
to include a colon in the equation name; the default is {it:colon}={cmd:1}.

{pstd}
{cmd:st_matrixrowstripe_fvinfo(}{it:name}{cmd:)} and
{cmd:st_matrixcolstripe_fvinfo(}{it:name}{cmd:)}
abort with error if {it:name} is malformed.  These functions
return {cmd:J(0,2,.)} if Stata matrix {it:name} does not exist.

{pstd}
{cmd:st_matrixrowstripe_fvinfo(}{it:name}{cmd:,} {it:info}{cmd:)} and
{cmd:st_matrixcolstripe_fvinfo(}{it:name}{cmd:,} {it:info}{cmd:)}
abort with error if any of the arguments is malformed.  These functions also
abort with error if {it:info} is not conformable with the corresponding
stripe's dimension.


{marker source}{...}
{title:Source code}

{pstd}
Functions are built in.
{p_end}

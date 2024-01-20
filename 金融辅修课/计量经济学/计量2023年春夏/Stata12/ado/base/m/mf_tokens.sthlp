{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] tokens()" "mansection M-5 tokens()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] invtokens()" "help mf_invtokens"}{...}
{vieweralsosee "[M-5] tokenget()" "help mf_tokenget"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_tokens##syntax"}{...}
{viewerjumpto "Description" "mf_tokens##description"}{...}
{viewerjumpto "Remarks" "mf_tokens##remarks"}{...}
{viewerjumpto "Conformability" "mf_tokens##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_tokens##diagnostics"}{...}
{viewerjumpto "Source code" "mf_tokens##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 tokens()} {hline 2} Obtain tokens from string


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:string rowvector}
{cmd:tokens(}{it:string scalar s}{cmd:)}

{p 8 12 2}
{it:string rowvector}
{cmd:tokens(}{it:string scalar s}{cmd:,}
{it:string scalar parsechars}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:tokens(}{it:s}{cmd:)} returns the contents of {it:s}, split into words.

{p 4 4 2}
{cmd:tokens(}{it:s}{cmd:,} {it:parsechars}{cmd:)}
returns the contents of {it:s} split into tokens based on {it:parsechars}.

{p 4 4 2}
{cmd:tokens(}{it:s}{cmd:)} 
is equivalent to {cmd:tokens(}{it:s}{cmd:, " ")}.

{p 4 4 2}
If you need more advanced parsing,
see {bf:{help mf_tokenget:[M-5] tokenget()}}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:tokens()} is commonly used to split a string 
containing a sequence of variable names into a 
row vector, each element of which contains one variable name:

	{cmd:tokens("mpg weight displacement") = ("mpg", "weight", "displacement")}

{p 4 4 2}
Some Stata interface functions require that variable names be specified
in this form.  This is required, for instance, by 
{bf:{help mf_st_varindex:[M-5] st_varindex()}}.
If you had a string scalar {cmd:vars} containing one or more variable 
names, you could obtain their variable indices by coding 

	{cmd:indices = st_varindex(tokens(vars))}


{marker conformability}{...}
{title:Conformability}

    {cmd:tokens(}{it:s}{cmd:,} {it:parsechars}{cmd:)}
		 {it:s}:  1 {it:x} 1
	{it:parsechars}:  1 {it:x} 1    (optional)
	    {it:result}:  1 {it:x w}, {it:w} = number of words (tokens) in {it:s}.


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
    If {it:s} contains "", {cmd:tokens()} returns {cmd:J(1,0,"")}.

{p 4 4 2}
    If {it:s} contains double-quoted or compound-double-quoted material,
    the quotes are stripped and that material is returned as one token.
    For example,

	{cmd:tokens(`"this "is an" example"') = ("this", "is an", "example")}

{p 4 4 2}
    If {it:s} contains quoted material and the quotes do not match, results 
    are as if the appropriate number of close quotes were added to the 
    end of {it:s}.  For example,

	{cmd:tokens(`"this "is an example"') = ("this", "is an example")}


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}

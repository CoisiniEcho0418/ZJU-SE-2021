{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] c()" "mansection M-5 c()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] programming" "help m4_programming"}{...}
{viewerjumpto "Syntax" "mf_c_lc##syntax"}{...}
{viewerjumpto "Description" "mf_c_lc##description"}{...}
{viewerjumpto "Remarks" "mf_c_lc##remarks"}{...}
{viewerjumpto "Conformability" "mf_c_lc##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_c_lc##diagnostics"}{...}
{viewerjumpto "Source code" "mf_c_lc##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 c()} {hline 2} Access c() value


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{it:scalar}
{cmd:c(}{it:string scalar name}{cmd:)}


{p 4 4 2}
returned is either a real or string scalar, depending on the value of 
{it:name}.


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:c(}{it:name}{cmd:)} returns Stata's 
c-class value; see {bf:{help creturn:[P] creturn}}.

{p 4 4 2}
Do not confuse {cmd:c()} with {cmd:C()}, which makes complex out of 
real arguments; see {bf:{help mf_c:[M-5] C()}}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
See 
{bf:{help creturn:[P] creturn}} or, in Stata, type 

	{cmd:. creturn list}

{p 4 4 2}
to see what is stored in {cmd:c()}.  Among the especially useful 
{cmd:c()} values are 

		{it:string} {cmd:c("current_date")}
		{it:string} {cmd:c("current_time")}
		{it:string} {cmd:c("os")}
		{it:string} {cmd:c("dirsep")}


{marker conformability}{...}
{title:Conformability}

    {cmd:c(}{it:name}{cmd:)}:
	    {it:name}:  1 {it:x} 1
	   {it:result}: 1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:c(}{it:name}{cmd:)}
returns a string or real depending on the particular {cmd:c()} value
requested.  If {it:name} is an invalid name or contains a name for which no
{cmd:c()} value is defined, returned is "".


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}

{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[M-5] corr()" "mansection M-5 corr()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] mean()" "help mf_mean"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] statistical" "help m4_statistical"}{...}
{viewerjumpto "Syntax" "mf_corr##syntax"}{...}
{viewerjumpto "Description" "mf_corr##description"}{...}
{viewerjumpto "Remarks" "mf_corr##remarks"}{...}
{viewerjumpto "Conformability" "mf_corr##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_corr##diagnostics"}{...}
{viewerjumpto "Source code" "mf_corr##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 corr()} {hline 2} Make correlation matrix from variance matrix


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}
{cmd:corr(}{it:real matrix V}{cmd:)}

{p 8 12 2}
{it:void}{bind:      }
{cmd:_corr(}{it:real matrix V}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:corr(}{it:V}{cmd:)} returns the correlation matrix corresponding 
to variance matrix {it:V}.

{p 4 4 2}
{cmd:_corr(}{it:V}{cmd:)} changes the contents of {it:V} from being a 
variance matrix to being a correlation matrix.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
See function {cmd:variance()} in 
{bf:{help mf_mean:[M-5] mean()}}
for obtaining a variance matrix from data.


{marker conformability}{...}
{title:Conformability}

    {cmd:corr(}{it:V}{cmd:)}:
	{it:input:}
		{it:V}:  {it:k x k}
	   {it:result}:  {it:k x k}

    {cmd:_corr(}{it:V}{cmd:)}:
	{it:input:}
		{it:V}:  {it:k x k}
	{it:output:}
		{it:V}:  {it:k x k}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:corr()} and {cmd:_corr()} abort with error if {it:V} is not square.
{it:V} should also be symmetric, but this is not checked.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view corr.mata, adopath asis:corr.mata},
{view _corr.mata, adopath asis:_corr.mata}
{p_end}

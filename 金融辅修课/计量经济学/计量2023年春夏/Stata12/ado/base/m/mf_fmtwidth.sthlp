{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-5] fmtwidth()" "mansection M-5 fmtwidth()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] strlen()" "help mf_strlen"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] string" "help m4_string"}{...}
{viewerjumpto "Syntax" "mf_fmtwidth##syntax"}{...}
{viewerjumpto "Description" "mf_fmtwidth##description"}{...}
{viewerjumpto "Remarks" "mf_fmtwidth##remarks"}{...}
{viewerjumpto "Conformability" "mf_fmtwidth##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_fmtwidth##diagnostics"}{...}
{viewerjumpto "Source code" "mf_fmtwidth##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 fmtwidth()} {hline 2} Width of %fmt


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} {cmd:fmtwidth(}{it:string matrix f}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:fmtwidth(}{it:f}{cmd:)} returns the width of the
{helpb format:{bf:%}{it:fmt}} contained in {it:f}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:fmtwidth("%9.2f")} returns 9.

{p 4 4 2}
{cmd:fmtwidth("%20s")} returns 20.

{p 4 4 2}
{cmd:fmtwidth("%tc")} returns 18.

{p 4 4 2}
{cmd:fmtwidth("%tcDay_Mon_DD_hh:mm:ss_!C!D!T_CCYY")} returns 28.

{p 4 4 2}
{cmd:fmtwidth("not a format")} returns {cmd:.} (missing).


{marker conformability}{...}
{title:Conformability}

    {cmd:fmtwidth(}{it:f}{cmd:)}:
             {it:f}:  {it:r x c}
        {it:result}:  {it:r x c}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:fmtwidth(}{it:f}{cmd:)}
returns {cmd:.} (missing) when {it:f} does not contain a valid 
Stata format.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Function is built in.
{p_end}

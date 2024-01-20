{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] displayflush()" "mansection M-5 displayflush()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] display()" "help mf_display"}{...}
{vieweralsosee "[M-5] printf()" "help mf_printf"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] io" "help m4_io"}{...}
{viewerjumpto "Syntax" "mf_displayflush##syntax"}{...}
{viewerjumpto "Description" "mf_displayflush##description"}{...}
{viewerjumpto "Remarks" "mf_displayflush##remarks"}{...}
{viewerjumpto "Diagnostics" "mf_displayflush##diagnostics"}{...}
{viewerjumpto "Source code" "mf_displayflush##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 displayflush()} {hline 2} Flush terminal-output buffer


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:displayflush()}


{marker description}{...}
{title:Description}

{p 4 4 2}
To achieve better performance, Stata buffers terminal output, so, 
within a program, output may not appear when a {helpb mf_display:display()} or 
{helpb mf_printf:printf()} command is executed.  The output might be held in a
buffer and displayed later.

{p 4 4 2}
{cmd:displayflush()} forces Stata to display all pending output at the 
terminal.  {cmd:displayflush()} is rarely used.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
See {bf:{help mf_printf:[M-5] printf()}} for an
{help mf_printf##force:example} of the use of {cmd:displayflush()}.

{p 4 4 2}
Use of {cmd:displayflush()} slows execution.  Use {cmd:displayflush()} 
only when it is important that output be displayed at the terminal 
now, such as when providing messages indicating what your program is 
doing.


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
None.


{marker source}{...}
{title:Source code}

{pstd}
Function is built in.
{p_end}

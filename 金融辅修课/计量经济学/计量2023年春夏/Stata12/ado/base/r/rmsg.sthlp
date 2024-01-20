{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[P] rmsg" "mansection P rmsg"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] profiler" "help profiler"}{...}
{vieweralsosee "[R] set" "help set"}{...}
{vieweralsosee "[P] timer" "help timer"}{...}
{viewerjumpto "Syntax" "rmsg##syntax"}{...}
{viewerjumpto "Description" "rmsg##description"}{...}
{viewerjumpto "Option" "rmsg##option"}{...}
{viewerjumpto "Remarks" "rmsg##remarks"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink P rmsg} {hline 2}}Return messages{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}{cmd:set} {cmdab:r:msg} {c -(} {cmd:on} | {cmd:off} {c )-}
	[{cmd:,} {cmdab:perm:anently}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:set rmsg} determines whether the return message is to be displayed at
the completion of each command.  The initial setting is {cmd:off}.
The return message shows how long the command took to execute and what time
it completed execution.


{marker option}{...}
{title:Option}

{phang}
{cmd:permanently} specifies that, in addition to making the change right now,
    the {cmd:rmsg} setting be remembered and become the default setting when
    you invoke Stata.


{marker remarks}{...}
{title:Remarks}

{pstd}
See {findalias frrc} for a description of return messages and for use of this
command.
{p_end}

{smcl}
{* *! version 1.1.3  11feb2011}{...}
{viewerdialog do "dialog do_dlg"}{...}
{vieweralsosee "[R] do" "mansection R do"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] doedit" "help doedit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] include" "help include"}{...}
{viewerjumpto "Syntax" "do##syntax"}{...}
{viewerjumpto "Description" "do##description"}{...}
{viewerjumpto "Option" "do##option"}{...}
{title:Title}

{p2colset 5 15 17 2}{...}
{p2col :{manlink R do} {hline 2}}Execute commands from a file{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang2}
{{cmd:do}|{cmdab:ru:n}}
{it:{help filename}}
[{it:arguments}] 
[{cmd:,} {opt nostop}
]


{title:Menu}

{phang}
{bf:File > Do...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:do} and {cmd:run} cause Stata to execute the commands stored in
{it:{help filename}} just as if they were entered from the keyboard.  {cmd:do}
echoes the commands as it executes them, whereas {cmd:run} is silent.  If
{it:filename} is specified without an extension, {cmd:.do} is assumed.


{marker option}{...}
{title:Option}

{phang}
{opt nostop} allows the do-file to continue executing even if an error occurs.
Normally, Stata stops executing the do-file when it detects an error (nonzero
return code).
{p_end}

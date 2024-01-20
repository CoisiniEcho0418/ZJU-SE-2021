{smcl}
{* *! version 1.2.1  27jun2011}{...}
{vieweralsosee "[R] exit" "mansection R exit"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] capture" "help capture"}{...}
{vieweralsosee "[P] class exit" "help class_exit"}{...}
{vieweralsosee "[P] continue" "help continue"}{...}
{vieweralsosee "[P] error" "help error"}{...}
{vieweralsosee "[P] exit" "help exit_program"}{...}
{viewerjumpto "Syntax" "exit##syntax"}{...}
{viewerjumpto "Description" "exit##description"}{...}
{viewerjumpto "Option" "exit##option"}{...}
{viewerjumpto "Examples" "exit##examples"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink R exit} {hline 2}}Exit Stata{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 13 2}{cmdab:e:xit} [{cmd:,} {cmd:clear}]


{marker description}{...}
{title:Description}

{pstd}
Typing {cmd:exit} causes Stata to stop processing and return control to the
operating system.  If the dataset in memory has changed since the last
{cmd:save} command, you must specify the {opt clear} option before Stata will
let you exit.

{pstd}
{cmd:exit} may also be used for exiting do-files or programs; see
{helpb exit_program:[P] exit}.

{pstd}
Stata for Windows users may also exit Stata by clicking on the {bf:Close}
button or by pressing {bf:Alt}+{bf:F4}.

{pstd}
Stata for Mac users may also exit Stata by pressing {bf:Command}+{bf:Q}.

{pstd}Stata(GUI) users may also exit Stata by clicking on the {bf:Close}
button.


{marker option}{...}
{title:Option}

{phang}{opt clear} permits you to exit, even if the current dataset has not
been saved.


{marker examples}{...}
{title:Examples}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. regress price mpg rep78 foreign}{p_end}

    Exit Stata
{phang2}{cmd:. exit}

    {hline}
    Setup
{phang2}{cmd:. sysuse auto}{p_end}
{phang2}{cmd:. drop if rep78==.}{p_end}

{pstd}Exit Stata even though dataset has changed and has not been saved{p_end}
{phang2}{cmd:. exit, clear}{p_end}
    {hline}

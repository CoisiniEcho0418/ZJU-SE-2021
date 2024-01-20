{smcl}
{* *! version 1.1.6  09jun2011}{...}
{viewerdialog help "help_d"}{...}
{vieweralsosee "[R] help" "mansection R help"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "contents" "help contents"}{...}
{vieweralsosee "[R] hsearch" "help hsearch"}{...}
{vieweralsosee "[R] net search" "help net_search"}{...}
{vieweralsosee "[R] search" "help search"}{...}
{viewerjumpto "Syntax" "help##syntax"}{...}
{viewerjumpto "Description" "help##description"}{...}
{viewerjumpto "Options" "help##options"}{...}
{viewerjumpto "Remarks" "help##remarks"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink R help} {hline 2}}Display online help{p_end}
{p2colreset}{...}

{hline}

{title:Stata's help system}

{pstd}
There are several kinds of help available to the Stata user. For more
information, see {help help_advice:Advice on getting help}.
The information below is technical details about Stata's {cmd:help} command.

{hline}


{marker syntax}{...}
{title:Syntax}

{phang}Display help information in Viewer

{p 8 14 2}
{cmdab:h:elp} [{it:command_or_topic_name}] [{cmd:,}
{opt non:ew}
{opt name(viewername)}
{opt mark:er(markername)}]


{phang}Display help information in Results window

{p 8 14 2}
{cmdab:ch:elp} [{it:command_or_topic_name}]


{title:Menu}

{phang}
{bf:Help > Stata Command...}


{marker description}{...}
{title:Description}

{pstd}
The {cmd:help} command displays help information about the specified command
or topic.

{phang}Stata for Mac, Stata for Unix(GUI), and Stata for Windows:{break}
   {cmd:help} launches a new Viewer to display help for the specified command or
   topic.  If {cmd:help} is not followed by a command or a topic name, Stata
   launches the Viewer and displays {cmd:help contents}, the table of contents
   for the online help.

{pmore}Help may be accessed either by selecting {hi:Help > Stata Command...} and
filling in the desired command name or by typing {cmd:help} followed by a
command or topic name.

{pmore}{cmd:chelp} will display help in the Results window.

{phang}Stata for Unix(console):{break}
   Typing {cmd:help} followed by a command name or a topic name will display
   help on the console.

{pmore}If {cmd:help} is not followed by a command or a topic name, a
description of how to use the {cmd:help} system is displayed.

{phang}Stata for Unix(both GUI and console):{break}
  {cmd:man} is a synonym for {cmd:chelp}.


{marker options}{...}
{title:Options}

{phang}
{opt nonew} specifies that a new Viewer window not be opened for the help
topic if a Viewer window is already open.  The default is for a new Viewer
window to be opened each time {cmd:help} is typed so that multiple help files
may be viewed at once.  {cmd:nonew} causes the help file to be displayed in
the topmost open Viewer.

{phang}
{opt name(viewername)} specifies that help be displayed in a Viewer window
named {it:viewername}.  If the named window already exists, its contents
will be replaced.  If the named window does not exist, it will be created.

{phang}
{opt marker(markername)} specifies that the help file be opened to the
position of {it:markername} within the help file.


{marker remarks}{...}
{title:Remarks}

{pstd}
To obtain help for any Stata command, type {cmd:help} {it:command} or
select {bf:Help > Stata Command...} and fill in {it:command}.

{pstd}
{cmd:help} is best explained by examples.

{p2colset 11 47 49 2}{...}
{p2col 9 45 49 2: To obtain help for ...}type{p_end}
{p2col: {cmd:regress}}{cmd:help regress}{p_end}
{p2col: postestimation tools for {cmd:regress}}{cmd:help regress postestimation}{p_end}
{p2col:}or{space 2} {cmd:help regress post}{p_end}
{p2col: graph option {cmd:xlabel()}}{cmd:help graph xlabel()}{p_end}
{p2col: Stata function {cmd:strpos()}}{cmd:help strpos()}{p_end}
{p2col: Mata function {cmd:optimize()}}{cmd:help mata optimize()}{p_end}
{p2colreset}{...}

{pstd}
Tips:

{phang2}
o {cmd:help} displays a subject table of contents for the online help.

{phang2}
o {cmd:help guide} displays a table of contents for basic Stata concepts.

{phang2}
o {cmd:help estimation commands} displays an alphabetical listing of all Stata
estimation commands.

{phang2}
o {cmd:help functions} displays help on Stata functions by category.

{phang2}
o {cmd:help mata functions} displays a subject table of contents for Mata's
functions.

{phang2}
o {cmd:help ts glossary} displays the glossary for the time-series manual,
and similarly for the other Stata specialty manuals.

{pstd}
See {findalias frhelp} for a complete
description of how to use {cmd:help}.


{hline}

{title:What to do when you see  {hline 2}more{hline 2}}

{pstd}
Stata pauses and displays the characters {cmd:{hline 2}more{hline 2}} at the
bottom of the results window whenever the output from a command is about to
scroll off the screen.

{col 13}Action{col 49}Result
{col 5}{hline 23}{col 32}{hline 40}
{col 5}Press {hi:Enter} or {hi:Return}{col 32}One more line of text is displayed

{col 5}Press {hi:b}{col 32}The previous screen of text is displayed

{col 5}Press {hi:Ctrl-K}{col 32}{hline 2}more{hline 2} condition is cleared and output stops 

{col 5}Press {hi:q}{col 32}{hline 2}more{hline 2} condition is cleared and output stops

{col 5}Press any other key{col 32}The next screen of text is displayed
{col 9}(such as space bar)

{col 5}PCs:
{col 9}Press {hi:Ctrl-Break}{col 32}Stata stops processing the command ASAP

{col 5}Mac:
{col 9}Press {hi:Command-.}{col 34}"     "       "       "     "     "

{col 5}Unix(Console):
{col 9}Press {hi:Ctrl-C}{col 34}"     "       "       "     "     "

{col 5}Unix(GUI):
{col 9}Press {hi:Ctrl-Break}{col 34}"     "       "       "     "     "


{pstd}
{hline 2}more{hline 2} happens all the time, not just in {cmd:chelp}, because 
Stata does not scroll information off the screen without your permission.

{pstd}
These same keystrokes will work in response to a {hline 2}more{hline 2}
given by other commands, except that pressing {hi:b} works only with
{cmd:chelp}.  You cannot press {hi:b} to back up to the previous screen with
other commands.


{title:Interrupting Stata commands}

{pstd}
You can press {hi:Ctrl-Break} (or {hi:Command-.} or {hi:Ctrl-C}) at any
time to interrupt any command in Stata, not just in response to
{hline 2}more{hline 2}.
{p_end}

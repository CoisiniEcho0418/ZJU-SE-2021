{smcl}
{* *! version 1.2.4  05may2011}{...}
{viewerdialog view "view_d"}{...}
{vieweralsosee "[R] view" "mansection R view"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{vieweralsosee "[R] net" "help net"}{...}
{vieweralsosee "[R] news" "help news"}{...}
{vieweralsosee "[R] search" "help search"}{...}
{vieweralsosee "[D] type" "help type"}{...}
{vieweralsosee "[R] update" "help update"}{...}
{viewerjumpto "Syntax" "view##syntax"}{...}
{viewerjumpto "Description" "view##description"}{...}
{viewerjumpto "Options" "view##options"}{...}
{viewerjumpto "Remarks" "view##remarks"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink R view} {hline 2}}View files and logs{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Display file in Viewer

{p 8 15 2}
{cmd:view} [{cmd:file}] [{cmd:"}]{it:{help filename}}[{cmd:"}] 
   [{cmd:,} {cmd:asis adopath}]


{phang}
Bring up browser pointed to specified URL

{p 8 15 2}
{cmd:view} {cmd:browse} [{cmd:"}]{it:url}[{cmd:"}]


{phang}
Display help results in Viewer

{p 8 15 2}
{cmd:view} {cmd:help} [{it:topic_or_command_name}]


{phang}
Display search results in Viewer

{p 8 15 2}
{cmd:view} {cmd:search} {it:keywords}


{phang}
Display news results in Viewer

{p 8 15 2}
{cmd:view} {cmd:news}


{phang}
Display net results in Viewer

{p 8 15 2}
{cmd:view} {cmd:net} [{it:netcmd}]


{phang}
Display ado-results in Viewer

{p 8 15 2}
{cmd:view} {cmd:ado} [{it:adocmd}]


{phang}
Display update results in Viewer

{p 8 15 2}
{cmd:view} {cmd:update} [{it:updatecmd}]


{phang}
Programmer's analog to view file and view browse

{p 8 15 2}
{cmd:view} {cmd:view_d}


{phang}
Programmer's analog to view help

{p 8 15 2}
{cmd:view} {cmd:help_d}


{phang}
Programmer's analog to view search

{p 8 15 2}
{cmd:view} {cmd:search_d}


{phang}
Programmer's analog to view net

{p 8 15 2}
{cmd:view} {cmd:net_d}


{phang}
Programmer's analog to view ado

{p 8 15 2}
{cmd:view} {cmd:ado_d}


{phang}
Programmer's analog to view update

{p 8 15 2}
{cmd:view} {cmd:update_d}


{title:Menu}

{phang}
{bf:File > View...}


{marker description}{...}
{title:Description}

{phang}
{cmd:view} displays file contents in the Viewer; see
{help viewer##viewer:viewer}.

{phang}
{cmd:view} {cmd:file} displays the specified file.  {cmd:file} is optional, so
if you had a SMCL session log created by typing {bind:{cmd:log using mylog}},
you could view it by typing {bind:{cmd:view mylog.smcl}}.  
{bind:{cmd:view} {cmd:file}} can properly display {hi:.smcl} files (logs and
the like), {hi:.sthlp} files, and text files.  
{bind:{cmd:view} {cmd:file}}'s {opt asis} option specifies that the file be
displayed as plain text, regardless of the {it:filename}'s extension.

{phang}
{cmd:view} {cmd:browse} opens your browser pointed to {it:url}.  Typing
{bind:{cmd:view} {cmd:browse} {cmd:http://www.stata.com}} would bring up your
browser pointed to the http://www.stata.com website.

{phang}
{cmd:view} {cmd:help} does the same as the {helpb help} command but displays
the result in the Viewer.  For example, to review the help for Stata's
{cmd:print} command, you could type {bind:{cmd:view help print}}.

{phang}
{cmd:view} {cmd:search} does the same as the {helpb search} command but
displays the result in the Viewer.  For instance, to search the online help
for information on robust regression, you could type 
{bind:{cmd:view search robust regression}}.

{phang}
{cmd:view} {cmd:news} does the same as the {helpb news} command but displays
the results in the Viewer.  ({cmd:news} displays the latest news from
http//www.stata.com.)

{phang}
{cmd:view} {cmd:net} does the same as the {helpb net} command but displays
the result in the Viewer.  For instance, typing
{bind:{cmd:view net search hausman test}} would search the Internet for
additions to Stata related to the Hausman test.  Typing
{bind:{cmd:view net from http://www.stata.com}} would go to the Stata download
site at http://www.stata.com.

{phang}
{cmd:view} {cmd:ado} does the same as the {helpb ado} command but displays
the result in the Viewer.  For instance, typing {bind:{cmd:view ado dir}}
would show a list of files you have installed.

{phang}
{cmd:view} {cmd:update} does the same as the {helpb update} command but
displays the result in the Viewer.  Typing {bind:{cmd:view update}} would show
the dates of what you have installed, and from there you could click to
compare those dates to the latest updates available.  Typing 
{bind:{cmd:view update query}} would skip the first step and show the
comparison.

{phang}
The {cmd:view} {cmd:*_d} commands are more useful in programming contexts than
they are interactively.

{phang}
{cmd:view} {cmd:view_d} displays a dialog box from which you may type the name
of a file or a URL to be displayed in the Viewer.

{phang}
{cmd:view} {cmd:help_d} displays a help dialog box from which you may obtain
interactive help on any Stata command.

{phang}
{cmd:view} {cmd:search_d} displays a search dialog box from which you may
obtain interactive help based on keywords.

{phang}
{cmd:view} {cmd:net_d} displays a search dialog box from which you may search
the Internet for additions to Stata (which you could then install).

{phang}
{cmd:view} {cmd:ado_d} displays a dialog box from which you may search the
user-written routines you have previously installed.

{phang}
{cmd:view} {cmd:update_d} displays an update dialog box in which you may type
the source from which updates are to be obtained.


{marker options}{...}
{title:Options}

{phang}
{opt asis}, allowed with {cmd:view} {cmd:file}, specifies that the file be
displayed as text, regardless of the {it:filename}'s extension.
{cmd:view} {cmd:file}'s default action is to display files ending in {hi:.smcl}
and {hi:.sthlp} as SMCL; see {manhelp smcl P}.

{phang}
{opt adopath}, allowed with {cmd:view} {cmd:file}, specifies that Stata search 
the S_ADO path for {it:filename} and display it, if found.


{marker remarks}{...}
{title:Remarks}

{pstd}
Most users access the Viewer by selecting {hi:File > View...} and proceeding
from there.  The {cmd:view} command allows you to skip that step.  Some common
interactive uses of {cmd:view} are

	{cmd:. view mysession.smcl}
	{cmd:. view mysession.log}

	{cmd:. view help print}
	{cmd:. view help regress}

	{cmd:. view news}
	{cmd:. view browse http://www.stata.com}

	{cmd:. view net search hausman test}

	{cmd:. view net}
	{cmd:. view ado}

	{cmd:. view update query}

{pstd}
Also, programmers find {cmd:view} useful for creating special effects.
{p_end}

{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[R] db" "mansection R db"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] query" "help query"}{...}
{viewerjumpto "Syntax" "db##syntax"}{...}
{viewerjumpto "Description" "db##description"}{...}
{viewerjumpto "Options" "db##options"}{...}
{viewerjumpto "Remarks" "db##remarks"}{...}
{title:Title}

{p2colset 5 15 17 2}{...}
{p2col :{manlink R db} {hline 2}}Launch dialog{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}Syntax for db

{phang2}
{cmd:db}
{it:commandname}


{phang}For programmers

{phang2}
{cmd:db}
{it:commandname}
[{cmd:,}
{opth message:(strings:string)}
{opt debug}
{opt dryrun}
]


{phang}Set system parameter

{p 8 19 2}
{cmd:set} {cmd:maxdb}
{it:#}
[{cmd:,}
{opt perm:anently}
]


{pstd}where {it:#} must be between 5 and 1,000.


{marker description}{...}
{title:Description}

{pstd}
{cmd:db} is the command-line way to launch a dialog for a Stata command.

{pstd}
The second syntax (which is the same but includes options) is for use by
programmers.

{pstd}
If you wish to allow the launching of dialogs from a help file, see
{manhelp smcl P} for information on the {cmd:dialog} SMCL directive.

{pstd}
{cmd:set} {cmd:maxdb} sets the maximum number of dialog boxes whose contents
are remembered from one invocation to the next during a session.  The default
value of {cmd:maxdb} is 50.


{marker options}{...}
{title:Options}

{phang}
{opth message:(strings:string)} specifies that {it:string} be passed to the 
    dialog box, where it can be referred to from the {cmd:__MESSAGE} 
    {cmd:STRING} property.

{phang}
{opt debug} specifies that the underlying dialog box be loaded with debug
    messaging turned on.

{phang}
{opt dryrun} specifies that, rather than launching the dialog, {cmd:db} 
    show the commands it would issue to launch the dialog.

{phang}
{opt permanently} specifies that, in addition to making the change right now,
    the {cmd:maxdb} setting be remembered and become the default setting when 
    you invoke Stata.


{marker remarks}{...}
{title:Remarks}

{pstd}
The usual way to launch a dialog is to pull down the {hi:Data}, {hi:Graphics},
or {hi:Statistics} menu and to make your selection from there.  When you know
the name of the command that you want to run, however, {cmd:db} provides a way
to invoke the dialog from the command line.

{pstd}
{cmd:db} follows the same abbreviation rules that Stata's command-line
interface follows.  So, to launch the dialog for {cmd:regress}, you can
type

	{cmd:. db regress}

{pstd}
or

	{cmd:. db reg}

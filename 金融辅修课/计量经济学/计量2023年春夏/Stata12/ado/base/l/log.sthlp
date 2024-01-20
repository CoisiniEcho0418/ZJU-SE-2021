{smcl}
{* *! version 1.2.8  10may2011}{...}
{viewerdialog log "dialog log_dlg"}{...}
{vieweralsosee "[R] log" "mansection R log"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] query" "help query"}{...}
{vieweralsosee "[R] translate" "help translate"}{...}
{viewerjumpto "Syntax" "log##syntax"}{...}
{viewerjumpto "Description" "log##description"}{...}
{viewerjumpto "Options for use with both log and cmdlog" "log##options_both"}{...}
{viewerjumpto "Options for use with log" "log##options_log"}{...}
{viewerjumpto "Option for use with set logtype" "log##option_set_logtype"}{...}
{viewerjumpto "Examples" "log##examples"}{...}
{viewerjumpto "Saved results" "log##saved_results"}{...}
{title:Title}

{p2colset 5 16 18 2}{...}
{p2col :{manlink R log} {hline 2}}Echo copy of session to file{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Report status of log file

{p 8 13 2}
{opt log}

{p 8 13 2}
{opt log} {cmd:query} [{it:logname} | {cmd:_all}]


{phang}
Open log file

{p 8 13 2}
{opt log} {cmd:using} {it:{help filename}} [{cmd:,} {cmd:append}
{cmd:replace} [{opt t:ext}{c |}{opt s:mcl}] {opt name(logname)}]


{phang}
Close log

{p 8 13 2}
{opt log} {opt c:lose} [{it:logname} | {cmd:_all}]


{phang}
Temporarily suspend logging or resume logging

{p 8 13 2}
{opt log} {c -(}{opt of:f}{c |}{opt on}{c )-} [{it:logname}]


{phang}
Report status of command log file

{p 8 16 2}
{cmd:cmdlog}


{phang}
Open command log file

{p 8 16 2}
{cmd:cmdlog} {cmd:using} {it:{help filename}} [{cmd:,} {cmd:append}
       {cmd:replace}]


{phang}
Close command log, temporarily suspend logging, or resume logging

{p 8 16 2}
{cmd:cmdlog} {c -(}{opt c:lose}{c |}{opt on}{c |}{opt of:f}{c )-}


{phang}
Set default format for logs

{p 8 16 2}
{cmd:set logtype} {c -(}{opt t:ext}{c |}{opt s:mcl}{c )-}
[{cmd:,} {opt perm:anently}]


{phang}
Specify screen width

{p 8 16 2}
{ul:{cmd:set}} {opt li:nesize} {it:#}


{phang}
In addition to using the {cmd:log} command, you may access the capabilities of
{cmd:log} by selecting {bf:File > Log} from the menu and choosing one of the
options in the list.


{title:Menu}

{phang}
{bf:File > Log}


{marker description}{...}
{title:Description}

{pstd}
{cmd:log} allows you to make a full record of your Stata session.  A log is
a file containing what you type and Stata's output.  You may start
multiple log files at the same time, and you may refer to them with
a {it:logname}.  If you do not specify a {it:logname}, Stata will use
the name {cmd:<unnamed>}.

{pstd}
{cmd:cmdlog} allows you to make a record of what you type during your Stata
session.  A command log contains only what you type, so it is a subset of a
full log.

{pstd}
You can make full logs, command logs, or both simultaneously.
Neither is produced until you tell Stata to start logging.

{pstd}
Command logs are always text files, making them easy to convert
into do-files.  (In this respect, it would make more sense if the default
extension of a command log file was {cmd:.do} because command logs are
do-files.  The default is {cmd:.txt}, not {cmd:.do}, however, to keep you from
accidentally overwriting your important do-files.)

{pstd}
Full logs are recorded in one of two formats: Stata Markup and Control
Language (SMCL) or plain text.  The default is SMCL, but you can use
{cmd:set logtype} to change that, or you can specify an option to state the
format you wish.  We recommend SMCL because it preserves fonts and colors.
SMCL logs can be converted to text or to other formats by using the
{cmd:translate} command; see {manhelp translate R}.  You can also use
{cmd:translate} to produce printable versions of SMCL logs.  SMCL logs can be
viewed and printed from the Viewer, as can any text file; see {manhelp view R}.

{pstd}
When using multiple log files, you may have up to five SMCL logs and
five text logs open at the same time.

{pstd}
{cmd:log} or {cmd:cmdlog}, typed without arguments, reports the status of
logging.  {cmd:log query}, when passed an optional {it:logname}, reports
the status of that log.

{pstd}
{cmd:log using} and {cmd:cmdlog using} open a log file.  {cmd:log close}
and {cmd:cmdlog close} close the file.  Between times, {cmd:log off} and
{cmd:cmdlog off}, and {cmd:log on} and {cmd:cmdlog on}, can temporarily
suspend and resume logging.

{pstd}
If {it:{help filename}} is specified without an extension, one of the suffixes
{cmd:.smcl}, {cmd:.log}, or {cmd:.txt} is added.  The extension {cmd:.smcl} or
{cmd:.log} is added by {cmd:log}, depending on whether the file format is SMCL
or text.  The extension {cmd:.txt} is added by {cmd:cmdlog}.
If {it:filename} contains embedded spaces, remember to enclose it in
double quotes. 

{pstd}
{cmd:set logtype} specifies the default format in which full logs are to be
recorded.  Initially, full logs are recorded in SMCL format.

{pstd}
{cmd:set linesize} specifies the maximum width, in characters, of Stata
output.  Most commands in Stata do not respect {cmd:linesize}, because it is
not important for most commands.  Most users never need to {cmd:set linesize},
because it will automatically be reset if you resize your Results window.
This is also why there is no {cmd:permanently} option allowed with
{cmd:set linesize}.  {cmd:set linesize} is for use with commands such as
{cmd:list} and {cmd:display} and is typically used by programmers who
wish the output of those commands to be wider or narrower than the
current width of the Results window.


{marker options_both}{...}
{title:Options for use with both log and cmdlog}

{phang}
{opt append} specifies that results be appended to an existing
file.  If the file does not already exist, a new file is created.

{phang}
{opt replace} specifies that {it:{help filename}}, if it already exists, be
overwritten.  When you do not specify either {opt replace} or {opt append},
the file is assumed to be new.  If the specified file already exists, an error
message is issued and logging is not started.


{marker options_log}{...}
{title:Options for use with log}

{phang}
{opt text} and {opt smcl} specify the format in which the log is to be
recorded.  The default is complicated to describe but is what you would
expect:

{pmore}
If you specify the file as {it:{help filename}}{cmd:.smcl}, the default is to
write the log in SMCL format (regardless of the value of {cmd:set logtype}).

{pmore}
If you specify the file as {it:filename}{cmd:.log}, the default is to write
the log in text format (regardless of the value of the {cmd:set logtype}).

{pmore}
If you type {it:filename} without an extension and specify neither the
{opt smcl} option nor the {opt text} option, the default is to write the file
according to the value of {cmd:set logtype}.  If you have not
{cmd:set logtype}, then the default is SMCL.  Also, the {it:filename}
you specified will be fixed to read {it:filename}{cmd:.smcl} if a SMCL log is
being created or {it:filename}{cmd:.log} if a text log is being created.

{pmore}
If you specify either of the options {cmd:text} or {cmd:smcl}, then
what you specify determines how the log is written.  If {it:filename} was
specified without an extension, the appropriate extension is added for you.

{pmore}
If you open multiple log files, you may choose a
different format for each file.

{phang}
{opt name(logname)} specifies an optional name you may use to refer
to the log while it is open.  You can start multiple log files,
give each a different {it:logname}, and then close, temporarily
suspend, or resume them each individually.


{marker option_set_logtype}{...}
{title:Option for use with set logtype}

{phang}
{opt permanently} specifies that, in addition to making the change right now,
the {cmd:logtype} setting be remembered and become the default setting 
when you invoke Stata.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. log using mylog}

{phang}{cmd:. log close}

{phang}{cmd:. log using mylog, append}

{phang}{cmd:. log close}

{phang}{cmd:. log using "filename containing spaces"}

{phang}{cmd:. log using firstfile, name(log1) text}

{phang}{cmd:. log using secondfile, name(log2) smcl}

{phang}{cmd:. log using thirdfile, name(log3) smcl}

{phang}{cmd:. log query _all}

{phang}{cmd:. log close log1}

{phang}{cmd:. log close _all}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:log} and {cmd:cmdlog} save the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(name)}}{it:logname}{p_end}
{synopt:{cmd:r(filename)}}name of file{p_end}
{synopt:{cmd:r(status)}}{cmd:on} or {cmd:off}{p_end}
{synopt:{cmd:r(type)}}{cmd:smcl} or {cmd:text}{p_end}
{p2colreset}{...}

{pstd}
{cmd:log} {cmd:query} {cmd:_all} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(numlogs)}}number of open log files{p_end}

{pstd}
For each open log file, {cmd:log} {cmd:query} {cmd:_all} also saves

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(name}{it:#}{cmd:)}}{it:logname}{p_end}
{synopt:{cmd:r(filename}{it:#}{cmd:)}}name of file{p_end}
{synopt:{cmd:r(status}{it:#}{cmd:)}}{cmd:on} or {cmd:off}{p_end}
{synopt:{cmd:r(type}{it:#}{cmd:)}}{cmd:smcl} or {cmd:text}{p_end}
{p2colreset}{...}

{pstd}
where {it:#} varies between {cmd:1} and the value of {cmd:r(numlogs)}.
Be aware that {it:#} will not necessarily represent the order in which
the log files were first opened, nor will it necessarily remain constant
for a given log file upon multiple calls to {cmd:log} {cmd:query}.
{p_end}

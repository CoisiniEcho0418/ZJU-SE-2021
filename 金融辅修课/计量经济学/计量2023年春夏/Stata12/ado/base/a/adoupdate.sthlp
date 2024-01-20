{smcl}
{* *! version 1.2.5  11feb2011}{...}
{viewerdialog adoupdate "dialog adoupdate"}{...}
{vieweralsosee "[R] adoupdate" "mansection R adoupdate"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] net" "help net"}{...}
{vieweralsosee "[R] search" "help search"}{...}
{vieweralsosee "[R] ssc" "help ssc"}{...}
{vieweralsosee "[R] update" "help update"}{...}
{viewerjumpto "Syntax" "adoupdate##syntax"}{...}
{viewerjumpto "Description" "adoupdate##description"}{...}
{viewerjumpto "Options" "adoupdate##options"}{...}
{viewerjumpto "Remarks" "adoupdate##remarks"}{...}
{viewerjumpto "Examples" "adoupdate##examples"}{...}
{viewerjumpto "Saved results" "adoupdate##saved_results"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col:{manlink R adoupdate} {hline 2}}Update user-written ado-files{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:adoupdate}
[{it:pkglist}]
[{cmd:,}
{it:options}]

{synoptset 10}{...}
{synopthdr}
{synoptline}
{synopt:{cmd:update}}perform update; default is to list packages that have
	updates, but not to update them{p_end}
{synopt:{cmd:all}}include packages that might have updates; default is to list
	or update only packages that are known to have updates{p_end}
{synopt:{cmdab:ssc:only}}check only packages obtained from SSC; default is to
	check all installed packages{p_end}
{synopt:{cmd:dir(}{it:dir}{cmd:)}}check packages installed in {it:dir};
	default is to check those installed in {help sysdir:PLUS}{p_end}
{synopt:{cmd:verbose}}provide output to assist in debugging network
	problems{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
User-written additions to Stata are called packages.
These packages can add remarkable abilities to Stata.
Packages are found and installed by using {helpb ssc},
{helpb findit}, and {helpb net}.

{pstd}
User-written packages are updated by their developers, just as official
Stata software is updated by StataCorp.

{pstd}
To determine whether your official Stata software is up to date, and to
update it if it is not, you use {helpb update}.

{pstd}
To determine whether your user-written additions are up to date, and to
update them if they are not, you use {cmd:adoupdate}.


{marker options}{...}
{title:Options}

{phang}
{cmd:update} specifies that packages with updates be updated.
    The default is simply to list the packages that could be updated
    without actually performing the update.

{pmore}
    The first time you {cmd:adoupdate}, do not specify this option.  Once you
    see {cmd:adoupdate} work, you will be more comfortable with it.  Then
    type

		. {cmd:adoupdate, update}

{pmore}
    The packages that can be updated will be listed and updated.

{phang}
{cmd:all} is rarely specified.  Sometimes, {cmd:adoupdate} cannot determine
    whether a package you previously installed has been updated.
    {cmd:adoupdate} can determine that the package is still available over the
    web but is unsure whether the package has changed.  Usually, the package has
    not changed, but if you want to be certain that you are using the latest
    version, reinstall from the source.

{pmore}
    Specifying {cmd:all} does this.  Typing 

		. {cmd:adoupdate, all}
    
{pmore}
    adds such packages to the displayed list as needing updating but
    does not update them.  Typing

		. {cmd:adoupdate, update all}

{pmore}
    lists such packages and updates them.
    
{phang}
{cmd:ssconly} is a popular option.  Many packages are available from the
    Statistical Software Components (SSC) archive -- often called the Boston
    College Archive -- which is provided at {browse "http://www.repec.org"}.
    Many users find most of what they want there. See {manhelp ssc R} for more
    information on the SSC.

{pmore}
    {cmd:ssconly} specifies that {cmd:adoupdate} check only packages obtained
    from that source.  Specifying this option is popular because SSC always
    provides distribution dates, and so {cmd:adoupdate} can be certain whether
    an update exists.  

{phang}
{cmd:dir(}{it:dir}{cmd:)}
     specifies which installed packages be checked.  The default 
     is {cmd:dir(PLUS)}, and that is probably correct.  If you are 
     responsible for maintaining a large system, however, you may 
     have previously installed packages in {cmd:dir(SITE)}, where they 
     are shared across users.  See {manhelp sysdir P} for an explanation of
     these directory codewords.  You may also specify an actual directory
     name, such as {cmd:C:\mydir}.

{phang}
{cmd:verbose} is specified when you suspect network problems.  It provides
    more detailed output that may help you diagnose the problem.


{marker remarks}{...}
{title:Remarks}

{pstd}
Do not confuse {cmd:adoupdate} with {cmd:update}.  Use {cmd:adoupdate} to 
update user-written files.  Use {cmd:update} to update the components 
(including ado-files) of the official Stata software.
To use either command, you must be connected to the Internet.

{pstd}
Remarks are presented under the following headings:

	{help adoupdate##using:Using adoupdate}
	{help adoupdate##firsttime:Possible problem the first time you run adoupdate and the solution}
	{help adoupdate##devnotes:Notes for developers}


{marker using}{...}
{title:Using adoupdate}

{pstd}
The first time you try {cmd:adoupdate}, type 

	. {cmd:adoupdate}

{pstd}
That is, do not specify the {cmd:update} option.  {cmd:adoupdate} without 
{cmd:update} produces a report but does not update any files.  The first time
you run {cmd:adoupdate}, you may see messages such as 

	. {cmd:adoupdate}
	  (note:  package utx was installed more than once; older copy removed)
	  {it:(remaining output omitted)}

{pstd}
Having the same packages installed multiple times is common; {cmd:adoupdate}
cleans that up.

{pstd}
The second time you run {cmd:adoupdate}, pick one package to update.  Suppose
that the report indicates that package st0008 has an update available.  Type

	. {cmd:adoupdate st0008, update}

{pstd}
You can specify one or many packages after the {cmd:adoupdate} command.
You can even use wildcards such as {cmd:st*} to mean all packages that 
start with st or {cmd:st*8} to mean all packages that start with st and 
end with 8.  You can do that with or without the {cmd:update} option.

{pstd}
Finally, you can let {cmd:adoupdate} update all your user-written additions:

	. {cmd:adoupdate, update}


{marker firsttime}{...}
{title:Possible problem the first time you run adoupdate and the solution}

{pstd}
The first time you run {cmd:adoupdate}, you might get many duplicate
messages:

	. {cmd:adoupdate}
	  (note: package ___ installed more than once; older copy removed)
	  (note: package ___ installed more than once; older copy removed)
	  (note: package ___ installed more than once; older copy removed)
	  ...
	  (note: package ___ installed more than once; older copy removed)
	  {it:(remaining output omitted)}

{pstd}
Some users have hundreds of duplicates.  You might even see the same package
name repeated more than once:

	  (note: package stylus installed more than once; older copy removed)
	  (note: package stylus installed more than once; older copy removed)

{pstd} 
That means that the package was duplicated twice.

{pstd} 
Stata tolerates duplicates, and you did nothing wrong when you previously
installed and updated packages.  {cmd:adoupdate}, however, needs the
duplicates removed, mainly so that it does not keep checking the same files.

The solution is to just let {cmd:adoupdate} run.  {cmd:adoupdate} will run
faster next time, when there are no (or just a few) duplicates.


{marker devnotes}{...}
{title:Notes for developers}

{pstd}
{cmd:adoupdate} reports whether an installed package is up to date by
comparing its distribution date with that of the package available over the
web.

{pstd}
If you are distributing software, include the line

	{cmd:d Distribution-Date:}  {it:date}

{pstd}
somewhere in your {cmd:.pkg} file.  The capitalization of
{cmd:Distribution-Date} does not matter, but include the hyphen and the colon
as shown.  Code the date in either of two formats:

	   all numeric:  {it:yyyymmdd},  for example, {cmd:20110701}

	Stata standard:  {it:ddMONyyyy}, for example, {cmd:01jul2011}


{marker examples}{...}
{title:Examples}

{pstd}Remove duplicates of installed user-written packages; report on whether
user-written packages are up to date{p_end}
{phang2}{cmd:. adoupdate}

{pstd}Remove duplicates of package {cmd:st0008}; report on whether {cmd:st0008}
is up to date{p_end}
{phang2}{cmd:. adoupdate st0008}

{pstd}Remove duplicates of package {cmd:st0008}; install update of {cmd:st0008}
if installed package is not up to date{p_end}
{phang2}{cmd:. adoupdate st0008, update}

{pstd}Remove duplicates of all packages; update all packages that are not up
to date{p_end}
{phang2}{cmd:. adoupdate, update}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:adoupdate} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2:Macros}{p_end}
{synopt:{cmd:r(pkglist)}}a space-separated list of package names that need
updating ({cmd:update} not specified) or that were updated ({cmd:update}
specified){p_end}
{p2colreset}{...}

{smcl}
{* *! version 1.4.6  28apr2011}{...}
{viewerdialog creturn "dialog creturn"}{...}
{vieweralsosee "[P] creturn" "mansection P creturn"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] query" "help query"}{...}
{vieweralsosee "[R] set" "help set"}{...}
{vieweralsosee "[P] return" "help return"}{...}
{vieweralsosee "[U] 13.4 System variables (_variables)" "help _variables"}{...}
{viewerjumpto "Syntax" "creturn##syntax"}{...}
{viewerjumpto "Description" "creturn##description"}{...}
{viewerjumpto "Remarks" "creturn##remarks"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink P creturn} {hline 2}}Return c-class values{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

	{cmdab:cret:urn} {cmdab:l:ist}


{title:Menu}

{phang}
{bf:Data > Other utilities > List constants and system parameters}


{marker description}{...}
{title:Description}

{pstd}
Stata's c-class, {cmd:c()}, contains the values of system parameters and
settings, along with certain constants such as the value of pi.  {cmd:c()}
values may be referred to but may not be assigned.


{marker remarks}{...}
{title:Remarks}

        {help creturn##values:System values}
	{help creturn##directories:Directories and paths}
	{help creturn##limits:System limits}
	{help creturn##numerical:Numerical and string limits}
	{help creturn##currentdta:Current dataset}
	{help creturn##memory:Memory settings}
	{help creturn##output:Output settings}
	{help creturn##interface:Interface settings}
	{help creturn##graphics:Graphics settings}
	{help creturn##efficiency:Efficiency settings}
	{help creturn##network:Network settings}
	{help creturn##update:Update settings}
	{help creturn##trace:Trace (program debugging) settings}
	{help creturn##mata:Mata settings}
	{help creturn##other:Other settings}
	{help creturn##misc:Other}


{marker values}{...}
{title:System values}

{phang}
{cmd:c(current_date)} returns the current date as a string in the format
    {bind:"{it:dd Mon yyyy}"}, where {it:dd} is the day of the month (if day
    is less than 10, a space and one digit are used); {it:Mon}
    is one of {cmd:Jan}, {cmd:Feb}, {cmd:Mar}, {cmd:Apr}, {cmd:May}, {cmd:Jun},
    {cmd:Jul}, {cmd:Aug}, {cmd:Sep}, {cmd:Oct}, {cmd:Nov}, or {cmd:Dec}; and
    {it:yyyy} is the four-digit year.

{phang2}
    Examples:{break}
	{cmd: 1 Jan 2003}{break}
	{cmd:26 Mar 2007}{break}
	{cmd:{ccl current_date}}

{phang}
{cmd:c(current_time)} returns the current time as a string in the format
    {bind:"{it:hh}{cmd::}{it:mm}{cmd::}{it:ss}"}, where {it:hh} is the hour 00
    through 23, {it:mm} is the minute 00 through 59, and {it:ss} is the second
    00 through 59.

{phang2}
    Examples:{break}
	{cmd:09:42:55}{break}
	{cmd:13:02:01}{break}
	{cmd:{ccl current_time}}

{phang}
{cmd:c(rmsg_time)} returns a numeric scalar equal to the elapsed time last
reported as a result of {cmd:set rmsg on}; see {manhelp rmsg P}.

{phang}
{cmd:c(stata_version)} returns a numeric scalar equal to the version of Stata
    that you are running.  In Stata {ccl stata_version}, this number is 
    {ccl stata_version}; in Stata {ccl stata_version}.1, 
    {ccl stata_version}.1; and in Stata 13, 13.  This is the version of Stata
    that you are running, not the version being mimicked by the {cmd:version}
    command.

{phang}
{cmd:c(version)} returns a numeric scalar equal to the version currently
    set by the {cmd:version} command; see {manhelp version P}.

{phang}
{cmd:c(born_date)} returns a string in the same format as
    {cmd:c(current_date)} containing the date of the Stata executable
    you are running; see {manhelp update R}.

{phang}
{cmd:c(flavor)} returns a string containing {cmd:"Small"} or
    {cmd:"IC"} according to the version of Stata that you are
    running.  {cmd:c(flavor)}={cmd:"IC"} for
    {help statamp:Stata/MP} and
    {help SpecialEdition:Stata/SE}, as well as for
    {help stataic:Stata/IC}.

{phang}
{cmd:c(bit)} returns a numeric scalar equal to {cmd:64} if you are using
    a 64-bit version of Stata and {cmd:32} if you are using a 32-bit version
    of Stata.

{phang}
{cmd:c(SE)} returns a numeric scalar equal to {cmd:1} if you are running
    {help SpecialEdition:Stata/SE} and {cmd:0} otherwise.

{phang}
{cmd:c(MP)} returns a numeric scalar equal to {cmd:1} if you are running
    {help statamp:Stata/MP} and {cmd:0} otherwise.

{phang}
{cmd:c(processors)} returns a numeric scalar equal to the number of
    processors/cores that Stata/MP is currently set to use.  It returns 
    {cmd:1} if you are not running Stata/MP.

{phang}
{cmd:c(processors_lic)} returns a numeric scalar equal to the number of
    processors/cores that your Stata/MP license allows.  It returns {cmd:1}
    if you are not running Stata/MP.

{phang}
{cmd:c(processors_mach)} returns a numeric scalar equal to the number of
    processors/cores that your computer has if you are running Stata/MP.
    It returns missing value ({cmd:.}) if you are not running Stata/MP.

{phang}
{cmd:c(processors_max)} returns a numeric scalar equal to the maximum 
     number of processors/cores that Stata/MP could use, which is equal to
     the minimum of {cmd:c(processors_lic)} and 
     {cmd:c(processors_mach)}.  It returns {cmd:1} if you are not running 
     Stata/MP.

{phang}
{cmd:c(mode)} returns a string containing {cmd:""} or {cmd:"batch"}, depending
on whether Stata was invoked in interactive mode (the usual case) or batch mode
(using, perhaps, the {cmd:-b} option of Stata for Unix).

{phang}
{cmd:c(console)} returns a string containing {cmd:""} or {cmd:"console"},
depending on whether you are running a windowed version of Stata or
Stata(console).

{phang}
{cmd:c(os)} returns a string containing {cmd:"MacOSX"}, {cmd:"Unix"}, or
    {cmd:"Windows"}, depending on the operating system that you are using.
    The list of alternatives, although complete as of the date of this writing,
    may not be complete.

{phang}
{cmd:c(osdtl)} returns an additional string, depending on the operating
    system, that provides the release number or other details about the
    operating system.  {cmd:c(osdtl)} is often "".

{* this is Macintosh, not Mac}{...}
{phang}
{cmd:c(machine_type)} returns a string that describes the hardware platform,
    such as {cmd:"PC"}, {cmd:"PC (64-bit x86-64)"}, {cmd:"Macintosh (Intel)"},
    or {cmd:"Oracle Solaris"}.

{phang}
{cmd:c(byteorder)} returns a string containing {cmd:"lohi"} or {cmd:"hilo"},
    depending on the byte order of the hardware.  Consider a two-byte integer.
    On some computers, the most-significant byte is written first, so x'0001'
    (meaning the byte 00 followed by 01) would mean the number 1.  Such
    computers are designated {cmd:"hilo"}.  Other computers write the
    least-significant byte first, so x`0001' would be 256, and 1 would be
    x'0100'.  Such computers are designated {cmd:"lohi"}.

{phang}
{cmd:c(username)} returns the user ID (provided by the operating
    system) of the user currently using Stata.


{marker directories}{...}
{title:Directories and paths}

{pstd}
Note:  The directory paths returned below usually end in a directory
separator, so if you wish to construct the full path name of file
{cmd:abc.def} in directory {cmd:c(}...{cmd:)}, you code

	...{cmd:`c(}...{cmd:)'abc.def}...

{pstd}and not

	...{cmd:`c(}...{cmd:)'/abc.def}...

{pstd}
If {cmd:c(}...{cmd:)} returns a directory name that does not end in a directory
separator, a special note of the fact is made.


{phang}
{cmd:c(sysdir_stata)} returns a string containing the name of the directory
    in which Stata is installed.  More technically,
    {cmd:c(sysdir_stata)} returns the STATA directory as defined by
    {cmd:sysdir}; see {manhelp sysdir P}.

{pin2}
    Example:  {cmd:{ccl sysdir_stata}}

{phang}
{cmd:c(sysdir_updates)} returns a string containing the name of the directory
    in which Stata is to find the official ado-file updates.  More
    technically, {cmd:c(sysdir_updates)} returns the UPDATES directory as
    defined by {cmd:sysdir}; see {manhelp sysdir P}.

{pin2}
    Example:  {cmd:{ccl sysdir_updates}}

{phang}
{cmd:c(sysdir_base)} returns a string containing the name of the directory
    in which the original official ado-files that were shipped with
    Stata were installed.

{pin2}
    Example:  {cmd:{ccl sysdir_base}}

{phang}
{cmd:c(sysdir_site)} returns a string containing the name of the directory
    in which user-written additions may be installed for sitewide
    use.  More technically, {cmd:c(sysdir_site)} returns the SITE directory as
    defined by {cmd:sysdir}; see {manhelp sysdir P}.

{pin2}
    Example:  {cmd:{ccl sysdir_site}}


{phang}
{cmd:c(sysdir_plus)} returns a string containing the name of the directory
    in which additions written by others may be installed for
    personal use.  More technically, {cmd:c(sysdir_plus)} returns the PLUS
    directory, as defined by {cmd:sysdir}; see {manhelp sysdir P}.

{pin2}
    Example:  {cmd:{ccl sysdir_plus}}

{phang}
{cmd:c(sysdir_personal)} returns a string containing the name of the directory
    in which additions written by you may be installed.
    More technically, {cmd:c(sysdir_personal)} returns the PERSONAL
    directory, as defined by {cmd:sysdir}; see {manhelp sysdir P}.

{pin2}
    Example:  {cmd:{ccl sysdir_personal}}

{phang}
{cmd:c(sysdir_oldplace)} identifies another directory in which user-written
    ado-files might be installed.  {cmd:c(sysdir_oldplace)} maintains 
    compatibility with very ancient versions of Stata.

{phang}
{cmd:c(tmpdir)} returns a string containing the name of the directory
    used by Stata for temporary files.

{pin2}
    Example:  {cmd:{ccl tmpdir}}

{phang}
{cmd:c(adopath)} returns a string containing the directories that are to be
    searched when Stata attempts to locate an ado-file.  The path elements are
    separated by a semicolon ({cmd:;}), and the elements themselves may be
    directory names, {cmd:"."} to indicate the current directory, or
    {helpb sysdir} references.

{pin2}
    Example:  {cmd:{ccl adopath}}

{phang}
{cmd:c(pwd)} returns a string containing the current (working) directory.

{pin2}
    Example:  {cmd:{ccl pwd}}

{pin2}
    Notice that {cmd:c(pwd)} does not end in a directory separator, so in a
    program, to save the name of the file {cmd:abc.def} prefixed by the current
    directory (for example, because you were about to change directories and
    still wanted to refer to the file), you would code

	    {cmd:local file "`c(pwd)'/abc.def"}
	or
	    {cmd:local file "`c(pwd)'`c(dirsep)'abc.def"}

{pin2}
    The second form is preferred if you want to construct "pretty" filenames,
    but the first form is acceptable because Stata understands a forward
    slash ({cmd:/}) as a directory separator.

{phang}
{cmd:c(dirsep)} returns a string containing {cmd:"/"}.

{pin2}
    Example:  {cmd:{ccl dirsep}}

{pin2}
    For Windows operating systems, a forward slash ({cmd:/}) is
    returned rather than a backslash ({cmd:\}).  Stata for Windows understands
    both, but in programs, use of the forward slash is recommended because the 
    backslash can interfere with Stata's interpretation of macro expansion
    characters.  Do not be concerned if the result of your code is a mix
    of backslash and forward slash characters, such as {cmd:\a\b/myfile.dta};
    Stata will understand it just as it would understand {cmd:/a/b/myfile.dta}
    or {cmd:\a\b\myfile.dta}.


{marker limits}{...}
{title:System limits}

{phang}
{cmd:c(max_N_theory)} returns a numeric scalar
    reporting the maximum number of observations allowed.

{pin2}
    {cmd:c(max_N_theory)} reports the maximum number of observations that Stata
    can process if it has enough memory.  This is usually 2,147,483,647.

{phang}
{cmd:c(max_k_theory)} returns a numeric scalar
    reporting the maximum number of variables allowed.  If you have
    Stata/MP or Stata/SE, you can change this number with {cmd:set maxvar};
    see {helpb memory:[D] memory}.

{phang}
    {cmd:c(max_width_theory)} returns the theoretical maximum width allowed.
    The width of a dataset is defined as 
    the sum of the byte lengths of its individual variables.  If you had a
    dataset with two {help int} variables, three {help float}s, one
    {help double}, and a {help data types:str20} variable, the width of the
    dataset would be 2*2 + 3*4 + 8 + 20 = 44 bytes.

{phang}
{cmd:c(max_matsize)} and {cmd:c(min_matsize)} each return a numeric scalar
    reporting the maximum and minimum values to which {help matsize} may be
    set.  If the version of Stata you are running does not allow the setting
    of {help matsize}, the two values will be equal.  {cmd:c(matsize)},
    documented under {it:{help creturn##memory:Memory settings}} below,
    returns the current value of {help matsize}.

{phang}
{cmd:c(max_macrolen)} and {cmd:c(macrolen)} each return a numeric scalar
    reporting the maximum length of macros.  {cmd:c(max_macrolen)} and
    {cmd:c(macrolen)} may not be equal under Stata/SE and will be equal
    otherwise.  For {help SpecialEdition:Stata/SE}, {cmd:macrolen} is set
    according to {help maxvar}:  the length is long enough to hold a macro
    referring to every variable in the dataset.

{phang}
{cmd:c(max_cmdlen)} and {cmd:c(cmdlen)} each return a numeric scalar
    reporting the maximum length of a Stata command.  {cmd:c(max_cmdlen)} and
    {cmd:c(cmdlen)} may not be equal in Stata/SE and will be equal otherwise.
    For {help SpecialEdition:Stata/SE}, {cmd:cmdlen} is set according to
    {help maxvar}:  the length is long enough to hold a command referring to
    every variable in the dataset.

{phang}
{cmd:c(namelen)} returns a numeric scalar equal to {ccl namelen}, which is the
    current length of names in Stata.

{phang}
{cmd:c(eqlen)} returns the maximum length that Stata allows for equation
      names.


{marker numerical}{...}
{title:Numerical and string limits}

{phang}
{cmd:c(mindouble)}, {cmd:c(maxdouble)}, and {cmd:c(epsdouble)} each return a
    numeric scalar.  {cmd:c(mindouble)} is the largest negative number that can
    be stored in the 8-byte {help double} storage type.  {cmd:c(maxdouble)} is
    the largest positive number that can be stored in a {help double}.
    {cmd:c(epsdouble)} is the smallest nonzero, positive number (epsilon) that,
    when added to 1 and stored as a {help double}, does not equal 1.

{phang}
{cmd:c(smallestdouble)} returns a numeric scalar containing the smallest
    full-precision {help double}
    that is bigger than zero.  There are smaller positive values
    that can be stored; these are denormalized numbers.  Denormalized numbers
    do not have full precision.

{phang}
{cmd:c(minfloat)}, {cmd:c(maxfloat)}, and {cmd:c(epsfloat)} each return a
    numeric scalar that reports for the 4-byte {help float} storage type what
    {cmd:c(mindouble)}, {cmd:c(maxdouble)}, and {cmd:c(epsdouble)} report for
    {help double}.

{phang}
{cmd:c(minlong)} and {cmd:c(maxlong)} return scalars reporting the largest
    negative number and the largest positive number that can be stored in the
    4-byte, integer {help long} storage type.  There is no {cmd:c(epslong)},
    but if there were, it would return 1.

{phang}
{cmd:c(minint)} and {cmd:c(maxint)} return scalars reporting the largest
    negative number and the largest positive number that can be stored in the
    2-byte, integer {help int} storage type.

{phang}
{cmd:c(minbyte)} and {cmd:c(maxbyte)} return scalars reporting the largest
    negative number and the largest positive number that can be stored in the
    1-byte, integer {help byte} storage type.

{phang}
{cmd:c(maxstrvarlen)} returns the longest {help data types:str}{it:#}
    storage type allowed, which is 244.  Do not confuse {cmd:c(maxstrvarlen)}
    with {cmd:c(macrolen)}.  {cmd:c(maxstrvarlen)} corresponds to string
    variables stored in the data.


{marker currentdta}{...}
{title:Current dataset}

{phang}
{cmd:c(N)} returns a numeric scalar equal to {cmd:_N}, the number of
    observations in the dataset in memory.  In an expression, it makes no
    difference whether you refer to {cmd:_N} or {cmd:c(N)}.  However, 
    when used in expressions with the {cmd:by} prefix, {cmd:c(N)} does not
    change with the by-group like {cmd:_N}.

{pmore}
  The advantage of {cmd:c(N)} is in nonexpression contexts.  Say that you are
  calling a subroutine, {cmd:mysub}, which takes as an argument the number of
  observations in the dataset.  Then you could code

	    {cmd:local nobs = _N}
	    {cmd:mysub `nobs'}
	or
	    {cmd:mysub `c(N)'}

{pin2}
    The second requires less typing.

{phang}
{cmd:c(k)} returns a numeric scalar equal to the number of variables
    in the dataset in memory.
    {cmd:c(k)} is equal to {cmd:r(k)}, which is  returned by {helpb describe}.

{phang}
{cmd:c(width)} returns a numeric scalar equal to the width, in bytes,
    of the dataset in memory.
    If you had a dataset with two {help int} variables, three
    {help float}s, one {help double}, and a {help data types:str20} variable,
    the width of the dataset would be 2*2 + 3*4 + 8 + 20 = 44 bytes.
    {cmd:c(width)} is equal to {cmd:r(width)}, which is returned by
    {helpb describe}.

{phang}
{cmd:c(changed)} returns a numeric scalar equal to {cmd:0} if the dataset in
memory has not changed since it was last saved and {cmd:1} otherwise.
{cmd:c(changed)} is equal to {cmd:r(changed)}, which is  returned by
{helpb describe}.

{phang}
{cmd:c(filename)} returns a string containing the filename last specified with
    a {helpb use} or {helpb save}, such as
    {cmd:"C:\Data\auto.dta"}.  {cmd:c(filename)} is
    equal to {cmd:$S_FN}.

{phang}
{cmd:c(filedate)} returns a string containing the date and time the file in
    {cmd:c(filename)} was last saved, such as {cmd:"7 Jul 2011 13:51"}.
    {cmd:c(filedate)} is equal to {cmd:$S_FNDATE}.


{marker memory}{...}
{title:Memory settings}

{phang}
{cmd:c(memory)} returns a numeric scalar reporting the amount of memory, in
    bytes, currently allocated by Stata.

{phang}
{cmd:c(maxvar)} returns a numeric scalar reporting the maximum number of
    variables currently allowed in a dataset, as set by
    {helpb maxvar:set maxvar} if you are running
    {help SpecialEdition:Stata/SE}.  Otherwise, {cmd:c(maxvar)} is a constant.

{phang}
{cmd:c(matsize)} returns a numeric scalar reporting the current value of
    {help matsize}, as set by {helpb matsize:set matsize}.

{phang}
{cmd:c(niceness)} returns a numeric scalar recording how soon Stata gives back
unused segments to the operating system.

{phang}
{cmd:c(min_memory)} returns a numeric scalar recording the minimum value to
which memory can be reduced when its memory is unused.

{phang}
{cmd:c(max_memory)} returns a numeric scalar recording the maximum amount of
memory that Stata may allocate.

{phang}
{cmd:c(segmentsize)} returns a numeric scalar recording the size of the
segments in which memory is allocated.


{marker output}{...}
{title:Output settings}

{phang}
{cmd:c(more)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb more:set more} setting.

{phang}
{cmd:c(rmsg)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb rmsg:set rmsg} setting.

{phang}
{cmd:c(dp)} returns a string containing {cmd:"period"} or {cmd:"comma"},
    according to the current {helpb dp:set dp} setting.

{phang}
{cmd:c(linesize)} returns a numeric scalar equal to the current
    {helpb linesize:set linesize} setting.

{phang}
{cmd:c(pagesize)} returns a numeric scalar equal to the current
    {helpb pagesize:set pagesize} setting.

{phang}
{cmd:c(logtype)} returns a string containing {cmd:"smcl"} or {cmd:"text"},
    according to the current {helpb logtype:set logtype} setting.

{phang}
{cmd:c(noisily)} returns a numeric scalar equal to {cmd:0} if output is
    being suppressed and {cmd:1} if output is being displayed;
    see {helpb quietly:[P] quietly}.

{phang}
{cmd:c(eolchar)} (Mac only) returns a string containing {cmd:"mac"} or
{cmd:"unix"}, according to the current {helpb eolchar:set eolchar} setting.

{phang}
{cmd:c(notifyuser)} (Mac only) returns a string containing {cmd:"on"}
or {cmd:"off"}, according to the current {helpb notifyuser:set notifyuser}
setting.

{phang}
{cmd:c(playsnd)} (Mac only) returns a string containing {cmd:"on"}
or {cmd:"off"}, according to the current {helpb playsnd:set playsnd}
setting.

{phang}
{cmd:c(include_bitmap)} (Mac only) returns a string containing {cmd:"on"}
or {cmd:"off"}, according to the current
{helpb include_bitmap:set include_bitmap} setting.

{phang}
{cmd:c(level)} returns a numeric scalar equal to the current
    {helpb level:set level} setting.

{phang}
{cmd:c(showbaselevels)} returns a string containing
    {cmd:""}, {cmd:"on"}, {cmd:"off"}, or {cmd:"all"},
    according to the current
    {helpb set showbaselevels} setting.

{phang}
{cmd:c(showemptycells)} returns a string containing
    {cmd:""}, {cmd:"on"}, or {cmd:"off"}, according to the current
    {helpb set showemptycells} setting.

{phang}
{cmd:c(showomitted)} returns a string containing
    {cmd:""}, {cmd:"on"}, or {cmd:"off"}, according to the current
    {helpb set showomitted} setting.

{phang}
{cmd:c(lstretch)} returns a string containing
    {cmd:""}, {cmd:"on"}, or {cmd:"off"}, according to the current
    {helpb set lstretch} setting.

{phang}
{cmd:c(cformat)} returns a string containing the
    current {helpb set cformat} setting.

{phang}
{cmd:c(sformat)} returns a string containing the
    current {helpb set sformat} setting.

{phang}
{cmd:c(pformat)} returns a string containing the
    current {helpb set pformat} setting.


{marker interface}{...}
{title:Interface settings}

{phang}
{cmd:c(dockable)} (Windows only) returns a string containing {cmd:"on"} or
    {cmd:"off"}, according to the current {helpb dockable:set dockable} setting.

{phang}
{cmd:c(dockingguides)} (Windows only) returns a string containing {cmd:"on"} or
    {cmd:"off"}, according to the current
    {helpb dockingguides:set dockingguides} setting.

{phang}
{cmd:c(locksplitters)} (Windows only) returns a string containing {cmd:"on"} or
    {cmd:"off"}, according to the current
    {helpb locksplitters:set locksplitters} setting.

{phang}
{cmd:c(pinnable)} (Windows only) returns a string containing 
  {cmd:"on"} or {cmd:"off"}, according to the current
  {helpb pinnable:set pinnable} setting.

{phang}
{cmd:c(doublebuffer)} (Windows only) returns a string containing
  {cmd:"on"} or {cmd:"off"}, according to the current
  {helpb doublebuffer:set doublebuffer} setting.

{phang}
{cmd:c(reventries)} returns a numeric scalar
    containing the maximum number of commands stored by the Review window; see
    {helpb reventries}.

{phang}
{cmd:c(fastscroll)} (Mac and Unix only) returns a string containing {cmd:"on"}
or {cmd:"off"}, according to the current {helpb fastscroll:set fastscroll}
setting.

{phang}
{cmd:c(revkeyboard)} (Mac only) returns a string containing {cmd:"on"}
or {cmd:"off"}, according to the current {helpb revkeyboard:set revkeyboard}
settings.

{phang}
{cmd:c(varkeyboard)} (Mac only) returns a string containing {cmd:"on"}
or {cmd:"off"}, according to the current {helpb varkeyboard:set varkeyboard}
settings.

{phang}
{cmd:c(smoothfonts)} (Mac only) returns a string containing {cmd:"on"}
or {cmd:"off"}, according to the current {helpb smoothfonts:set smoothfonts}
setting.

{phang}
{cmd:c(linegap)} returns a numeric scalar equal to the current
    {helpb linegap:set linegap} setting.  If {cmd:set linegap} is
    irrelevant under the version of Stata that you are running,
    {cmd:c(linegap)} returns a system missing value.

{phang}
{cmd:c(scrollbufsize)} returns a numeric scalar equal to the current
    {helpb scrollbufsize:set scrollbufsize} setting.  If
    {cmd:set scrollbufsize} is irrelevant under the version of Stata that you
    are running, {cmd:c(scrollbufsize)} returns a system missing value.

{phang}
{cmd:c(maxdb)} returns a numeric scalar containing the maximum number of
    dialog boxes whose contents are remembered from one invocation to the
    next during a session; see {manhelp db R}.


{marker graphics}{...}
{title:Graphics settings}

{phang}
{cmd:c(graphics)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb set_graphics:set graphics} setting.

{phang}
{cmd:c(autotabgraphs)} (Windows only) returns a string containing {cmd:"on"}
or {cmd:"off"}, according to the current
{helpb autotabgraphs:set autotabgraphs} setting.

{phang}
{cmd:c(scheme)} returns the name of the current {helpb set scheme}.

{phang}
{cmd:c(printcolor)} returns {cmd:"automatic"}, {cmd:"asis"},
    {cmd:"gs1"}, {cmd:"gs2"}, or {cmd:"gs3"}, according to the current
    {helpb set printcolor} setting.

{phang}
{cmd:c(copycolor)} (Mac and Windows only) returns {cmd:"automatic"},
{cmd:"asis"}, {cmd:"gs1"}, {cmd:"gs2"}, or {cmd:"gs3"}, according to the current
{helpb set printcolor:set copycolor} setting.


{marker efficiency}{...}
{title:Efficiency settings}

{phang}
{cmd:c(adosize)} returns a numeric scalar equal to the current
    {helpb adosize:set adosize} setting.


{marker network}{...}
{title:Network settings}

{phang}
{cmd:c(checksum)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb checksum:set checksum} setting.

{phang}
{cmd:c(timeout1)} returns a numeric scalar equal to the current
    {helpb timeout1:set timeout1} setting.

{phang}
{cmd:c(timeout2)} returns a numeric scalar equal to the current
    {helpb timeout2:set timeout2} setting.

{phang}
{cmd:c(httpproxy)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb httpproxy:set httpproxy} setting.

{phang}
{cmd:c(httpproxyhost)} returns a string containing the name of the
    proxy host or {cmd:""} if no proxy host is set.
    {cmd:c(httpproxyhost)} is relevant only if {cmd:c(httpproxy)}={cmd:"on"}.

{phang}
{cmd:c(httpproxyport)} returns a numeric scalar equal to the proxy port number.
    {cmd:c(httpproxyport)} is relevant only if {cmd:c(httpproxy)}={cmd:"on"}.

{phang}
{cmd:c(httpproxyauth)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb httpproxy:set httpproxyauth} setting.
    {cmd:c(httpproxyauth)} is relevant only if {cmd:c(httpproxy)}={cmd:"on"}.

{phang}
{cmd:c(httpproxyuser)} returns a string containing the name of the proxy
    user, if one is set, or {cmd:""} otherwise.
    {cmd:c(httpproxyuser)} is relevant only if
    {cmd:c(httpproxyauth)}={cmd:"on"} and {cmd:c(httpproxy)}={cmd:"on"}.

{phang}
{cmd:c(httpproxypw)} returns a string containing {cmd:"*"} if a password
    is set or {cmd:""} otherwise.
    {cmd:c(httpproxypw)} is relevant only if
    {cmd:c(httpproxyauth)}={cmd:"on"} and {cmd:c(httpproxy)}={cmd:"on"}.


{marker update}{...}
{title:Update settings}

{phang}
{cmd:c(update_query)} (Mac and Windows only) returns a string containing
    {cmd:"on"} or {cmd:"off"}, according to the current
    {helpb update_query:set update_query} setting.

{phang}
{cmd:c(update_interval)} (Mac and Windows only) returns a numeric scalar
    containing the current {helpb update_interval:set update_interval} setting.

{phang}
{cmd:c(update_prompt)} (Mac and Windows only) returns a string containing
    {cmd:"on"} or {cmd:"off"}, according to the current
    {helpb update_prompt:set update_prompt} setting.


{marker trace}{...}
{title:Trace (program debugging) settings}

{phang}
{cmd:c(trace)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb trace:set trace} setting.

{phang}
{cmd:c(tracedepth)} returns a numeric scalar reporting the current
    {helpb trace:set tracedepth} setting.

{phang}
{cmd:c(tracesep)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb trace:set tracesep} setting.

{phang}
{cmd:c(traceindent)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb trace:set traceindent} setting.

{phang}
{cmd:c(traceexpand)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb trace:set traceexpand} setting.

{phang}
{cmd:c(tracenumber)} returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb trace:set tracenumber} setting.

{phang}
{cmd:c(tracehilite)} returns a string containing {it:"pattern"},
    according to the current {helpb trace:set tracehilite} setting.


{marker mata}{...}
{title:Mata settings}

{phang}
{cmd:c(matastrict)}
 returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb matastrict:set matastrict} setting.

{phang}
{cmd:c(matalnum)}
 returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb matalnum:set matalnum} setting.

{phang}
{cmd:c(mataoptimize)}
 returns a string containing {cmd:"on}" or {cmd:"off"},
    according to the current {helpb mataoptimize:set mataoptimize} setting.

{phang}
{cmd:c(matafavor)}
 returns a string containing {cmd:"space"} or {cmd:"speed"},
    according to the current {helpb matafavor:set matafavor} setting.

{phang}
{cmd:c(matacache)}
 returns a numeric scalar containing the maximum amount of memory, in
 kilobytes, that may be consumed before Mata starts looking to drop autoloaded
 functions that are not currently being used.

{phang}
{cmd:c(matalibs)}
 returns a string containing the names and order of the {cmd:.mlib} libraries
 to be searched; see {help m1_how:[M-1] how}.

{phang}
{cmd:c(matamofirst)}
 returns a string containing {cmd:"on"} or {cmd:"off"},
    according to the current {helpb matamofirst:set matamofirst} setting.


{marker other}{...}
{title:Other settings}

{phang}
{cmd:c(type)} returns a string containing {cmd:"float"} or {cmd:"double"},
    according to the current {helpb generate:set type} setting.

{phang}
{cmd:c(maxiter)} returns a numeric scalar equal to the current 
{helpb maxiter:set maxiter} setting.

{phang}
{cmd:c(searchdefault)} returns a string containing {cmd:"local"}, {cmd:"net"},
    or {cmd:"all"}, according to the current {helpb search:set searchdefault}
    setting.

{phang}
{cmd:c(seed)} returns a string containing the current {helpb seed:set seed}
    setting.  This records the current state of the random-number generator
    {helpb random:runiform()}.

{phang}
{cmd:c(version_rng)} returns the version number currently in effect for
    random-number generators.  See {helpb version:[P] version}.

{phang}
{cmd:c(varabbrev)} returns a string containing {cmd:"on"} or {cmd:"off"},
according to the current {helpb varabbrev:set varabbrev} setting.

{phang}
{cmd:c(emptycells)} returns a string containing {cmd:"keep"} or {cmd:"drop"},
according to the current {helpb set emptycells:set emptycells} setting.

{phang}
{cmd:c(odbcmgr)} returns a string containing {cmd:"iodbc"} or {cmd:"unixodbc"},
according to the current {helpb odbc:set odbcmgr} setting.


{marker misc}{...}
{title:Other}

{phang}
{cmd:c(pi)} returns a numeric scalar equal to {cmd:_pi}, the value of the
    ratio of the circumference to the diameter of a circle.  In an expression,
    it makes no difference whether you use {cmd:c(pi)} or {cmd:_pi}.
    {cmd:c(pi)}, however, may be used (enclosed in single quotes) in other
    contexts.

{phang}
{cmd:c(alpha)} returns a string containing the space-separated list of
    lowercase letters.

{phang}
{cmd:c(ALPHA)} returns a string containing the space-separated list of
    uppercase letters.

{phang}
{cmd:c(Mons)} returns a string containing the space-separated list of month
    names abbreviated to three characters.

{phang}
{cmd:c(Months)} returns a string containing the space-separated list of month
    names.

{phang}
{cmd:c(Wdays)} returns a string containing the space-separated list of weekday
    names abbreviated to three characters.

{phang}
{cmd:c(Weekdays)} returns a string containing the space-separated list of
    weekday names.

{phang}
{cmd:c(rc)} returns a numeric scalar equal to {cmd:_rc}, the value set by
    the {helpb capture} command.  In an expression, it makes no difference
    whether you use {cmd:c(rc)} or {cmd:_rc}.  {cmd:c(rc)}, however, may be
    used (enclosed in single quotes) in other contexts.  This is less important
    than it sounds because you could just as easily type {cmd:`=_rc'}.
{p_end}

{smcl}
{* *! version 1.5.5  24aug2011}{...}
{findalias asfrwhatsnew}{...}
{findalias asfrres}{...}
{findalias asfrwww}{...}
{findalias asfrstatapress}{...}
{findalias asfrstatalist}{...}
{findalias asfrstb}{...}
{findalias asfrweb}{...}
{findalias asfroffinstall}{...}
{findalias asfrupdate}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] net" "help net"}{...}
{vieweralsosee "[R] sj" "help sj"}{...}
{vieweralsosee "stb" "help stb"}{...}
{vieweralsosee "[R] update" "help update"}{...}
{title:Title}

{phang}
{hi:Additions to Stata since release 12.0}


{title:Description}

    Update history:

            {hi:Stata 12.0 base    25jul2011}
            {hi:updated to         24aug2011}

{pstd}
This file records the additions and fixes made to Stata since the release of
version 12.0.  The end of this file provides links for earlier additions and
fixes.

{pstd}
Updates are available for free over the Internet.
{update "from http://www.stata.com":Click here} to obtain the latest update,
or see {help updates} for detailed instructions.

{pstd}
The most recent changes are listed first.


{hline 8} {hi:update 24aug2011} {hline}

{p 5 9 2}
1.  {helpb blogit} did not allow option
    {cmd:vce(cluster} {it:clustvar}{cmd:)}.  This has been fixed.

{p 5 9 2}
2.  {help datetime business calendars creation:Business calendars} with month
    or weekday names containing capital letters would fail to load.  This has
    been fixed.

{p 5 9 2}
3.  {helpb marginsplot} now recognizes {helpb margins} results in {cmd:e()}
    when {cmd:r()} no longer contains results from {cmd:margins}.
    {cmd:margins} will post its results to {cmd:e()} when option {opt post}
    is used.

{p 5 9 2}
4.  Mata's {helpb mf_optimize:optimize()} with the Nelder-Mead technique and
    constraints would error-out with a Mata trace log.  This has been fixed.

{p 5 9 2}
5.  {helpb query} now displays the setting {helpb coeftabresults} as an output
    setting.  This setting controls whether coefficient table results are
    stored in {cmd:r()}.

{p 5 9 2}
6.  {helpb roctab} with option {opt detail} produced unaligned tables when the
    classification variable had long value labels.  These labels are now
    abbreviated if needed, and a new option, {opt nolabel}, has been added to
    suppress displaying the value labels.

{p 5 9 2}
7.  {helpb sspace}, when time-series operators were combined with the
    {cmd:e.} error operator on the dependent variable in an {it:obs_efeq}
    equation, produced an error message.  This has been fixed.

{p 5 9 2}
8.  {helpb svy}{cmd:} {helpb ivregress} reported an invalid operator error
    when factor-variables notation was used in the list of instrumental
    variables ({it:varlist_iv}) but not in the list of exogenous variables
    ({it:varlist1}).  This has been fixed.

{p 5 9 2}
9.  When pasting data into the Data Editor, sequential delimiters were treated
    as one delimiter, causing missing cells to be omitted.  This has been
    fixed.

{p 4 9 2}
10.  (Windows) Updating Stata over a network share failed with error r(695),
     leaving the Stata installation unchanged.  This has been fixed.

{p 4 9 2}
11.  (Mac) When resizing the main Stata window, the Results view will now
     always be the main view that gets resized regardless of its location in
     the main Stata window.

{p 4 9 2}
12.  (Mac) The keyboard shortcut for "Do to Bottom" for the Do-file Editor has
     been changed to Ctrl-Cmd-D because the previous keyboard shortcut
     conflicted with the system keyboard shortcut for hiding/showing the Dock.

{p 4 9 2}
13.  (Mac) If tabbed windowing for the Do-file Editor is turned off and there
     are multiple Do-file Editor windows, Stata could be confused as to which
     Do-file Editor is active and perform menu and toolbar operations on the
     wrong window.  This has been fixed.

{p 4 9 2}
14.  (Mac) Translating SMCL to PDF has been reenabled.

{p 4 9 2}
15.  (Mac) Translating SMCL to PS could cause Stata to crash.  This has been
     fixed.

{p 4 9 2}
16.  (Unix) Shift-clicking objects in the {help sembuilder:SEM Builder} would
     not properly enable/disable items in the Object > Align menu.  This has
     been fixed.


{hline 8} {hi:update 08aug2011} {hline}

{p 5 9 2}
1.  {helpb compress} and commands that internally used {cmd:compress} could
    fail, causing future commands to issue a "{err:variable not found}" error.
    This has been fixed.


{hline 8} {hi:update 05aug2011} {hline}

{p 5 9 2}
1.  A serious memory management bug has been fixed.  The bug was unlikely to
    occur.  If it occurred, it usually caused a crash.  It could, however,
    cause data to be corrupted.  We had only four reports, all involving
    crashes.  If a dataset was below 32 MB on 64-bit computers or 16 MB on
    32-bit computers, the bug could not occur.

{p 5 9 2}
2.  {helpb stcox} using options {cmd:efron} and {cmd:vce(robust)} could take a
    long time to compute for large datasets with many tied failure times.
    This has been fixed.

{p 5 9 2}
3.  (Mac) Changing the results color for the Results window had no effect.
    This has been fixed.

{p 5 9 2}
4.  (Mac) The keyboard shortcuts for Shift Left and Shift Right in the Do-file
    Editor's contextual menu did not match the main menu's keyboard shortcuts
    (which take precedence).  This has been fixed.

{p 5 9 2}
5.  (Mac) Graphs drawn using polygons would render with thick lines when
    exported to PDF or a bitmap format.  This has been fixed.

{p 5 9 2}
6.  (Windows) Some tooltips for copying to the Clipboard could incorrectly
    show up as "Copy Diagram".  This has been fixed.

{p 5 9 2}
7.  (Windows) On some international keyboards, characters that required
    the right-side Alt key to be pressed, such as { and } on German
    keyboards, could not be typed in the Command window or the Do-file Editor.
    This has been fixed.

{p 5 9 2}
8.  (64-bit Windows) {helpb query memory} displayed an extra letter "{cmd:c}"
    when reporting memory sizes.  This has been fixed.


{hline 8} {hi:update 26jul2011} {hline}

{p 5 9 2}
1.  Online help and the search index have been brought up to date for
    {help sj:Stata Journal} 11(2).

{p 5 9 2}
2.  The {help whatsnew11:19jul2011 Stata 11.2 update} items 2, 3, 4, 6, 7, 11,
    12, 13, 14, 15, 17, and 21 have now been applied to Stata 12.  The other
    items from that update were applied to Stata 12 prior to its initial
    release.

{p 5 9 2}
3.  {helpb margins} with options {cmd:vce(unconditional)} and
    {opt noestimcheck} reported a "{err:varlist required}" error if a factor
    variable was also specified in one of the marginal effects options
    ({opt dydx()}, {opt dyex()}, {opt eydx()}, or {opt eyex()}).  This has
    been fixed.

{p 5 9 2}
4.  ({help statamp:Stata/MP}) {helpb mlmatbysum} produced wrong results if the
    global macro {cmd:$ML_w} was empty.  This has been fixed.

{p 5 9 2}
5.  {cmd:notes search} issued an r(111) error if the search string in question
    was not found in a note.  This has been fixed.

{p 5 9 2}
6.  The new {help sembuilder:SEM Builder} has enhancements and bug fixes, such
    as the following: settings affecting appearance are now remembered between
    Stata sessions (enhancement), and paths connecting error variables now join
    better with the containing circle (bug fix).

{p 9 9 2}
    The thirty-two enhancements/fixes are not enumerated here because they
    were made on the date of release.

{p 5 9 2}
7.  {helpb sem} has the following fixes:

{p 9 13 2}
    a.  {cmd:sem} would sometimes report structural equations out of the order
        in which they were specified.  This has been fixed.

{p 9 13 2}
    b.  {cmd:sem} with a {helpb svy} prefix or with options
        {cmd:vce(bootstrap)} or {cmd:vce(jackknife)} failed to report the
        standardized model parameters when option {opt standardized} was
        specified.  This has been fixed.

{p 5 9 2}
8.  (Mac) In a tabbed Viewer window, dragging the last tab out of the window
    now destroys the empty window.  Previously, the empty window wasn't
    destroyed, which could cause problems when a new Viewer was created.

{p 5 9 2}
9.  (Mac) The Do-file Editor automatically saves backups of unsaved do-files.
    If Stata crashes, then the next time Stata is launched, the backup is
    automatically opened in the Do-file Editor.  Previously, if the backup was
    closed without saving changes, the backup would be opened every time Stata
    was launched.  This has been fixed; Stata now removes the backup file.

{p 4 9 2}
10.  (Unix) The Stata GUI issued GTK warnings if your dataset contained
     extended ASCII characters.  This has been fixed.


{hline 8} {hi:previous updates} {hline}

{pstd}
See {help whatsnew11to12}.

    {c TLC}{hline 63}{c TRC}
    {c |} Help file        Contents                     Years           {c |}
    {c LT}{hline 63}{c RT}
    {c |} {bf:this file}        Stata 12.0                   2011 to present {c |}
    {c |} {help whatsnew11to12}   Stata 12.0 new release       2011            {c |}
    {c |} {help whatsnew11}       Stata 11.0, 11.1, and 11.2   2009 to 2011    {c |}
    {c |} {help whatsnew10to11}   Stata 11.0 new release       2009            {c |}
    {c |} {help whatsnew10}       Stata 10.0 and 10.1          2007 to 2009    {c |}
    {c |} {help whatsnew9to10}    Stata 10.0 new release       2007            {c |}
    {c |} {help whatsnew9}        Stata  9.0, 9.1, and 9.2     2005 to 2007    {c |}
    {c |} {help whatsnew8to9}     Stata  9.0 new release       2005            {c |}
    {c |} {help whatsnew8}        Stata  8.0, 8.1, and 8.2     2003 to 2005    {c |}
    {c |} {help whatsnew7to8}     Stata  8.0 new release       2003            {c |}
    {c |} {help whatsnew7}        Stata  7.0                   2001 to 2002    {c |}
    {c |} {help whatsnew6to7}     Stata  7.0 new release       2000            {c |}
    {c |} {help whatsnew6}        Stata  6.0                   1999 to 2000    {c |}
    {c BLC}{hline 63}{c BRC}
{hline}

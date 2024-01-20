{smcl}
{* *! version 1.1.5  14apr2011}{...}
{viewerdialog rolling "dialog rolling"}{...}
{vieweralsosee "[TS] rolling" "mansection TS rolling"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] statsby" "help statsby"}{...}
{viewerjumpto "Syntax" "rolling##syntax"}{...}
{viewerjumpto "Description" "rolling##description"}{...}
{viewerjumpto "Options" "rolling##options"}{...}
{viewerjumpto "Examples" "rolling##examples"}{...}
{viewerjumpto "Saved results" "rolling##saved_results"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col:{manlink TS rolling} {hline 2}}Rolling-window and recursive estimation
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:rolling}
	[{it:{help exp_list}}]
	{ifin}
	[{cmd:,} {it:options}]
	{cmd::}
	{it:command}


{synoptset 26 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{p2coldent:* {opt w:indow(#)}}number of consecutive data points in each sample{p_end}
{synopt:{opt r:ecursive}}use recursive samples{p_end}
{synopt:{opt rr:ecursive}}use reverse recursive samples{p_end}

{syntab:Options}
{synopt:{opt clear}}replace data in memory with results{p_end}
{synopt:{help prefix_saving_option:{bf:{ul:sa}ving(}{it:filename}{bf:, ...)}}}save results to {it:filename}; save
statistics in double precision; save results to {it:filename} every {it:#}
replications{p_end}
{synopt:{opt step:size(#)}}number of periods to advance window{p_end}
{synopt:{opt st:art(time_constant)}}period at which rolling is to start{p_end}
{synopt:{opt e:nd(time_constant)}}period at which rolling is to end{p_end}
{synopt:{cmdab:k:eep(}{varname}[{cmd:,} {opt start}]{cmd:)}}save {it:varname} along with results; optionally, use value at left edge of window{p_end}

{syntab:Reporting}
{synopt:{opt nodots}}suppress replication dots{p_end}
{synopt:{opt noi:sily}}display any output from {it:command}{p_end}
{synopt:{opt tr:ace}}trace {it:command}'s execution{p_end}

{syntab:Advanced}
{synopt:{opth reject(exp)}}identify invalid results{p_end}
{synoptline}
{p 4 6 2}
{it:*} {opt window(#)} {it:is required.}
{p_end}
{p 4 6 2}
You must {cmd:tsset} your data before using {opt rolling}; see 
{helpb tsset:[TS] tsset}. {p_end}
{p 4 6 2}
{opt aweight}s are allowed in {it:command} if {it:command} accepts
{cmd:aweight}s; see {help weight}.
{p_end}


{title:Menu}

{phang}
{bf:Statistics > Time series > Rolling-window and recursive estimation}


{marker description}{...}
{title:Description}

{pstd}
{opt rolling} is a moving sampler that collects statistics from {it:command} by
executing {it:command} on subsets of the data in memory.  Typing

{pin}
{cmd:. rolling} {it:exp_list}{cmd:, window(50) clear:} {it:command}

{pstd}
executes {it:command} on sample windows of span 50.  That is, {opt rolling}
will first execute {it:command} by using periods 1-50 of the dataset, and
then using periods 2-51, 3-52, and so on.  {opt rolling} can
also perform recursive and reverse recursive analyses, in which the starting
or ending period is held fixed and the window size grows.

{pstd}
{it:command} defines the statistical command to be executed.  Most Stata
commands and user-written programs can be used with {opt rolling}, as long as
they follow {help language:standard Stata syntax} and allow the {helpb if}
qualifier.  The {opt by} prefix cannot be part of {it:command}.

{pstd}
{it:exp_list} specifies the statistics to be collected after the execution of
{it:command}.  If no expressions are given, {it:exp_list} assumes a default of
{opt _b} if {it:command} stores results in {opt e()} and of all the scalars if
{it:command} stores results in {opt r()} and not in {opt e()}.  Otherwise, not
specifying an expression in {it:exp_list} is an error.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt window(#)} defines the window size used each time {it:command} is executed.
   The window size refers to calendar periods, not the number of
   observations.  If there are missing data (for example, because of weekends),
   the actual number of observations used by {it:command} may be less than
   {opt window(#)}.  {opt window(#)} is required.

{phang}
{opt recursive} specifies that a recursive analysis be done.  The starting
   period is held fixed, the ending period advances, and the window
   size grows.

{phang}
{opt rrecursive} specifies that a reverse recursive analysis be done.
   Here the ending period is held fixed, the starting period
   advances, and the window size shrinks.

{dlgtab:Options}

{phang}
{opt clear} specifies that Stata replace the data in memory
   with the collected statistics even though the current data in memory have
   not been saved to disk.

INCLUDE help prefix_saving_option

{phang2}
   {opt double} specifies that the results for each replication be stored as
   {opt double}s, meaning 8-byte reals.  By default, they are stored as
   {opt float}s, meaning 4-byte reals.

{phang2}
   {opt every(#)} specifies that results be written to disk every {it:#}th
   replication.  {opt every()} should be specified only in conjunction with
   {opt saving()} when {it:command} takes a long time for each replication.
   This will allow recovery of partial results should your computer crash.
   See {helpb post:[P] postfile}.

{phang}
{opt stepsize(#)} specifies the number of periods the window is to be advanced
   each time {it:command} is executed.

{phang}
{opt start(time_constant)} specifies the date on which {opt rolling} is to start.
   {opt start()} may be specified as an integer or as a date literal.

{phang}
{opt end(time_constant)} specifies the date on which {opt rolling} is to end.
   {opt end()} may be specified as an integer or as a date literal.

{phang}
{opt keep}{cmd:(}{varname}[{cmd:, start}]{cmd:)} specifies a variable to be
   posted along with the results.  The value posted is the value that
   corresponds to the right edge of the window.  Specifying the {opt start()}
   option requests that the value corresponding to the left edge of the window
   be posted instead.  This option is often used to record calendar dates.

{dlgtab:Reporting}

{phang}
{opt nodots} suppresses the display of the replication dot for each window on which
{it:command} is executed.  By default, one dot character is printed for
each window.  A red `x' is printed if {it:command} returns with
an error or if any value in {it:exp_list} is missing.

{phang}
{opt noisily} causes the output of {it:command} to be displayed for each
   window on which {it:command} is executed.  This option implies the
   {opt nodots} option.

{phang}
{opt trace} causes a trace of the execution of {it:command} to be displayed.
This option implies the {opt noisily} and {opt nodots} options.

{dlgtab:Advanced}

{phang}
{opth reject(exp)} identifies an expression that indicates when results should
   be rejected.  When {it:exp} is true, the saved statistics are set to
   missing values.


{marker examples}{...}
{title:Example: Collecting coefficients}

{phang2}{cmd:. webuse lutkepohl2}{p_end}
{phang2}{cmd:. tsset qtr}{p_end}
{phang2}{cmd:. rolling _b, window(30): regress dln_inv dln_inc dln_consump}
{p_end}

{pstd}Same as above, {cmd:_b} is default for e-class commands{p_end}
{phang2}{cmd:. webuse lutkepohl2, clear}{p_end}
{phang2}{cmd:. tsset qtr}{p_end}
{phang2}{cmd:. rolling, window(30): regress dln_inv dln_inc dln_consump}
{p_end}
{phang2}{cmd:. list in 1/10, abbrev(14)}


{title:Example: Collecting standard errors}

{phang2}{cmd:. webuse lutkepohl2, clear}{p_end}
{phang2}{cmd:. tsset qtr}{p_end}
{phang2}{cmd:. rolling _se, window(10): regress dln_inv dln_inc dln_consump}
{p_end}
{phang2}{cmd:. list in 1/10, abbrev(14)}


{title:Example: Collecting saved results}

{phang2}{cmd:. webuse lutkepohl2, clear}{p_end}
{phang2}{cmd:. tsset qtr}{p_end}
{phang2}{cmd:. rolling mean=r(mean) median=r(p50), window(10): summarize inc,}
                {cmd:detail}{p_end}
{phang2}{cmd:. list in 1/10}

{phang2}{cmd:. webuse lutkepohl2, clear}{p_end}
{phang2}{cmd:. tsset qtr}{p_end}
{phang2}{cmd:. rolling ratio=(r(mean)/r(p50)), window(10): summarize inc,}
                {cmd:detail}{p_end}
{phang2}{cmd:. list in 1/10}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:rolling} sets no r- or e-class macros. The results from the
command used with {cmd:rolling}, depending on the last window of data used,
are available after {cmd:rolling} has finished.
{p_end}

{smcl}
{* *! version 1.2.1  14apr2011}{...}
{vieweralsosee "[P] discard" "mansection P discard"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] clear" "help clear"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] class" "help class"}{...}
{vieweralsosee "[P] classutil" "help classutil"}{...}
{vieweralsosee "[P] dialog programming" "help dialog_programming"}{...}
{viewerjumpto "Syntax" "discard##syntax"}{...}
{viewerjumpto "Description" "discard##description"}{...}
{viewerjumpto "Remarks" "discard##remarks"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink P discard} {hline 2}}Drop automatically loaded programs{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

	{cmd:discard}


{marker description}{...}
{title:Description}

{pstd}
{cmd:discard} drops all automatically loaded programs (see
{findalias fradowhat}); clears {cmd:e()}, {cmd:r()}, and
{cmd:s()} saved results (see {manhelp return P}); eliminates information
stored by the most recent estimation command and any other saved estimation
results (see {manhelp ereturn P}); closes any open graphs and drops all sersets
(see {manhelp serset P}); clears all class definitions and instances (see
{manhelp classutil P});
clears all business calendars (see
{bf:{help datetime_business_calendars:[D] datetime business calendars}});
and closes all dialogs and clears their remembered
contents (see {manhelp dialog_programming P:dialog programming}).

{pstd}
In short, {cmd:discard} causes Stata to forget everything current without
forgetting anything important, such as the data in memory.


{marker remarks}{...}
{title:Remarks}

{pstd}
Use {cmd:discard} to debug ado-files.  Making a change to an ado-file
will not cause Stata to update its internal copy of the changed program.
{cmd:discard} clears all automatically loaded programs from memory, forcing
Stata to refresh its internal copies with the versions residing on disk.

{pstd}
Also all of Stata's estimation commands can display 
their previous output when the command is typed without arguments.  They achieve
this by storing information on the problem in memory. {helpb predict} calculates
various statistics (predictions, residuals, influence statistics, etc.),
{helpb estat vce} shows the covariance matrix, {helpb lincom} calculates linear
combinations of estimated coefficients, and {helpb test} and {helpb testnl}
perform hypotheses tests, all using that stored information. {cmd:discard}
eliminates that information, making it appear as if you never fit the
model.
{p_end}

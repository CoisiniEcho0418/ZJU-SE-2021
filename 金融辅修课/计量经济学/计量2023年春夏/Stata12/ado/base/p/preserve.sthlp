{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[P] preserve" "mansection P preserve"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] nopreserve" "help nopreserve"}{...}
{vieweralsosee "[D] snapshot" "help snapshot"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] macro" "help tempfile"}{...}
{viewerjumpto "Syntax" "preserve##syntax"}{...}
{viewerjumpto "Description" "preserve##description"}{...}
{viewerjumpto "Options" "preserve##options"}{...}
{viewerjumpto "Remarks" "preserve##remarks"}{...}
{viewerjumpto "Technical note" "preserve##technote"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink P preserve} {hline 2}}Preserve and restore data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

    Preserve data

{p 8 17 2}{cmd:preserve} [{cmd:,} {cmdab:ch:anged}]


    Restore data

{p 8 16 2}{cmd:restore} [{cmd:,} {cmd:not} {cmdab:pres:erve}]


{marker description}{...}
{title:Description}

{pstd}
{cmd:preserve} preserves the data, guaranteeing that data will be restored
after program termination.

{pstd}
{cmd:restore} forces a restore of the data now.


{marker options}{...}
{title:Options}

{phang}{cmd:changed} instructs {cmd:preserve} to preserve only the
flag indicating that the data have changed since the last save.  Use of this
option is strongly discouraged; see the 
{it:{help preserve##technote:technical note}}.

{phang}{cmd:not} instructs {cmd:restore} to cancel the previous
{cmd:preserve}.

{phang}{cmd:preserve} instructs {cmd:restore} to restore the data now, but not
to cancel the restoration of the data again at program conclusion.  If
{cmd:preserve} is not specified, the scheduled restoration at program
conclusion is canceled.


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:preserve} and {cmd:restore} deal with the programming problem where the
user's data must be changed to achieve the desired result but, when the
program concludes, the programmer wishes to undo the damage done to the data.
When {cmd:preserve} is issued, the user's data are preserved.  The data
in memory remain unchanged.  When the program or do-file concludes, the user's
data are automatically restored.

{pstd}
After a {cmd:preserve}, the programmer can also instruct Stata to
restore the data now with the {cmd:restore} command.  This is useful when the
programmer needs the original data back and knows that no more damage will be
done to the data.  {cmd:restore,} {cmd:preserve} can be used when the
programmer needs the data back but plans further damage.  {cmd:restore,}
{cmd:not} can be used when the programmer wishes to cancel the previous
{cmd:preserve} and to have the data currently in memory returned to the user.


{marker technote}{...}
{title:Technical note}

{pstd}
{cmd:preserve,} {cmd:changed} is best avoided, although it is very
fast.  {cmd:preserve,} {cmd:changed} does not preserve the data; it merely
records whether the data have changed since the data were last saved (as
mentioned by {cmd:describe} and as checked by {cmd:exit} and {cmd:use} when
the user does not also say {cmd:clear}) and restores the flag at the
conclusion of the program.  The programmer must ensure that the data really
have not changed.

{pstd}
As long as your programs use temporary variables, as created by {cmd:tempvar}
(see {helpb macro:[P] macro}), the changed-since-last-saved flag would not be
changed anyway -- Stata can track such temporary changes to the data that it
will, itself, be able to undo.  In fact, we cannot think of one use for
{cmd:preserve,} {cmd:changed}, and included it only to preserve the happiness
of our more imaginative users.
{p_end}

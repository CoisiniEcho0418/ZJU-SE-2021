{smcl}
{* *! version 1.0.4  06jun2011}{...}
{viewerdialog bcal "dialog bcal"}{...}
{vieweralsosee "[D] bcal" "mansection D bcal"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] datetime business calendars" "help datetime_business_calendars"}{...}
{vieweralsosee "[D] datetime business calendars creation" "help datetime_business calendars creation"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[D] datetime" "help datetime"}{...}
{viewerjumpto "Syntax" "bcal##syntax"}{...}
{viewerjumpto "Description" "bcal##description"}{...}
{viewerjumpto "Option" "bcal##option"}{...}
{viewerjumpto "Remarks" "bcal##remarks"}{...}
{viewerjumpto "Saved results" "bcal##saved_results"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{manlink D bcal} {hline 2}}Business calendar file manipulation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}
List business calendars used by the data currently in memory

{p 8 25 2}
{cmd:bcal} {cmdab:c:heck} [{it:{help bcal##varlist:varlist}}] [{cmd:, rc0}]


{pstd}
List filenames and directories of available business calendars

{p 8 25 2}
{cmd:bcal} {cmd:dir} [{it:{help bcal##pattern:pattern}}]


{pstd}
Describe the specified business calendar

{p 8 25 2}
{cmd:bcal} {cmdab:d:escribe} {it:{help bcal##calname:calname}}


{pstd}
Load the business calendar

{p 8 25 2}
{cmd:bcal} {cmd:load} {it:{help bcal##calname:calname}}


{marker varlist}{...}
{marker pattern}{...}
{marker calname}{...}
{p 4 4 2}
where

{p 8 12 2}
{it:varlist} is a list of variable names to be checked for whether they use
business calendars.  If not specified, all variables are checked.

{p 8 12 2}
{it:pattern} is the name of a business calendar possibly containing
wildcards {cmd:*} and {cmd:?}.  If {it:pattern} is not specified, all
available business calendar names are listed.

{p 8 12 2}
{it:calname} is the name of a business calendar either as a name or as a
datetime format; for example, {it:calname} could be {cmd:simple} or
{cmd:%tbsimple}.


{title:Menu}

{phang}
{bf:Data > Other utilities > Business calendar utilities}

{phang}
{bf:Data > Variables Manager}


{marker description}{...}
{title:Description}

{pstd}
See {bf:{help datetime_business_calendars:[D] datetime business calendars}}
for an introduction to business calendars and dates.

{pstd}
{cmd:bcal} {cmd:check} lists the business calendars used by the data 
currently in memory, if any. 

{pstd}
{cmd:bcal} {cmd:dir} {it:pattern} lists filenames and directories of all
available business calendars matching {it:pattern}, or all business 
calendars if {it:pattern} is not specified.

{pstd}
{cmd:bcal} {cmd:describe} {it:calname} presents a description of the 
specified business calendar.

{pstd}
{cmd:bcal} {cmd:load} {it:calname} loads the specified business calendar.
Business calendars load automatically when needed, and thus use of {cmd:bcal}
{cmd:load} is never required.  {cmd:bcal} {cmd:load} is used by programmers
writing their own business calendars.  {cmd:bcal} {cmd:load} {it:calname}
forces immediate loading of a business calendar and displays output, including
any error messages due to improper calendar construction.


{marker option}{...}
{title:Option}

{dlgtab:Main}

{p 4 8 2}
{cmd:rc0} 
    specifies that {cmd:bcal} {cmd:check} is to exit without error (return 0)
    even if some calendars do not exist or have errors.  Programmers can 
    then access the results {cmd:bcal} {cmd:check} saves in {cmd:r()} 
    to get even more details about the problems.  If you wish to suppress 
    {cmd:bcal} {cmd:dir}, precede the {cmd:bcal} {cmd:check} command with
    {cmd:capture} and specify the {cmd:rc0} option if you wish to access the
    {cmd:r()} results.
    

{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:bcal} {cmd:check} reports on any {cmd:%tb} formats used by the 
data currently in memory:

        {cmd}. bcal check
        {res}{txt}
               {res}%tbsimple:  {txt}defined, {txt}used by variable
                           mydate

{pstd}
{cmd:bcal} {cmd:dir} reports on business calendars available:

        {cmd}. bcal dir
        {res}{txt}  1 calendar file found:
          simple:  C:\Program Files\Stata12\ado\base\s\simple.stbcal

{pstd}
{cmd:bcal} {cmd:describe} reports on an individual calendar.

        {cmd}. bcal describe simple

        {txt}  Business calendar {res}simple{txt} (format {res}%tbsimple{txt}):

            purpose:  {res}Example for manual

        {txt}      range:  {res}01nov2011  30nov2011
        {txt}             {res}    18932      18961{txt}{col 46}in %td units
                     {res}        0         19{txt}{col 46}in %tbsimple units

             center:  {res}01nov2011
        {txt}             {res}    18932{txt}{col 46}in %td units
                     {res}        0{txt}{col 46}in %tbsimple units

            omitted: {res}       10{txt}{col 46}days
                     {res}      121.8{txt}{col 46}approx. days/year

           included: {res}       20{txt}{col 46}days
                     {res}      243.5{txt}{col 46}approx. days/year{txt}

{pstd}
{cmd:bcal} {cmd:load} is used by programmers writing new stbcal-files.
See 
{bf:{help datetime_business_calendars_creation:[D] datetime_business_calendars_creation}}.


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:bcal} {cmd:check} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(defined)}}business calendars used, stbcal-file exists, and file contains no errors{p_end}
{synopt:{cmd:r(undefined)}}business calendars used, but no stbcal-files exist for them{p_end}
{p2colreset}{...}

{pstd}
Warning to programmers:
    Specify the {cmd:rc0} option to access these returned results. 
    By default, {cmd:bcal} {cmd:check} returns code 459 if a business
    calendar does not exist or if a business calendar exists but has errors;
    in such cases, the results are not saved.


{pstd}
{cmd:bcal describe} saves the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(min_date_td)}}calendar's minimum date in {cmd:%td} units{p_end}
{synopt:{cmd:r(max_date_td)}}calendar's maximum date in {cmd:%td} units{p_end}
{synopt:{cmd:r(ctr_date_td)}}calendar's zero date    in {cmd:%td} units{p_end}
{synopt:{cmd:r(min_date_tb)}}calendar's minimum date in {cmd:%tb} units{p_end}
{synopt:{cmd:r(max_date_tb)}}calendar's maximum date in {cmd:%tb} units{p_end}
{synopt:{cmd:r(omitted)}}total number of days omitted from calendar{p_end}
{synopt:{cmd:r(included)}}total number of days included in calendar{p_end}

{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(name)}}pure calendar name (for example, {cmd:nyse}){p_end}
{synopt:{cmd:r(purpose)}}short description of calendar's purpose{p_end}
{p2colreset}{...}

{pstd}
{cmd:bcal load} saves the same results in {cmd:r()} as {cmd:bcal describe},
except it does not save {cmd:r(omitted)} and {cmd:r(included)}.
{p_end}

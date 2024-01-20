{smcl}
{* *! version 1.1.4  11feb2011}{...}
{viewerdialog ctset "dialog ctset"}{...}
{vieweralsosee "[ST] ctset" "mansection ST ctset"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[ST] ct" "help ct"}{...}
{vieweralsosee "[ST] cttost" "help cttost"}{...}
{viewerjumpto "Syntax" "ctset##syntax"}{...}
{viewerjumpto "Description" "ctset##description"}{...}
{viewerjumpto "Options" "ctset##options"}{...}
{viewerjumpto "Remarks" "ctset##remarks"}{...}
{viewerjumpto "Examples" "ctset##examples"}{...}
{title:Title}

{p2colset 5 19 21 2}{...}
{p2col :{manlink ST ctset} {hline 2}}Declare data to be count-time data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Declare data in memory to be count-time data and run checks on data

{p 8 14 2}{cmd:ctset} {it:timevar} {it:nfailvar} [{it:ncensvar} [{it:nentvar}]]
	[{cmd:,} {opth by(varlist)} {opt nos:how} ]


{phang}
Specify whether to display identities of key ct variables

{p 8 14 2}{cmd:ctset,} {{opt s:how} | {opt nos:how}}


{phang}
Clear ct setting

{p 8 14 2}{cmd:ctset, clear}


{phang}
Display identity of key ct variables and rerun checks on data

{p 8 14 2}{{cmd:ctset} | {cmd:ct}}


{pstd}where {it:timevar} refers to the time of failure, censoring, or entry.
It should contain times >= 0.

{pstd}{it:nfailvar} records the number failing at time {it:timevar}.

{pstd}{it:ncensvar} records the number censored at time {it:timevar}.

{pstd}{it:nentvar} records the number entering at time {it:timevar}.

{pstd}Stata sequences events at the same time as

{p 13 32 2}at {it:timevar} {space 7} {it:nfailvar} failures occurred,{p_end}
{p 7 32 2}then at {it:timevar}+0 {space 5} {it:ncensvar} censorings occurred,{p_end}
{p 5 32 2}finally at {it:timevar}+0+0 {space 4} {it:nentvar} subjects entered the data.


{title:Menu}

{phang}
{bf:Statistics > Survival analysis > Setup and utilities >}
     {bf:Declare data to be count-time data}


{marker description}{...}
{title:Description}

{pstd}
ct refers to count-time data and is described here and in {help ct}.  Do not
confuse count-time data with counting-process data, which can be analyzed using
the st commands, see {manhelp st ST}.

{pstd}
In the first syntax, {cmd:ctset} declares the data in memory to be ct data,
informing Stata of the key variables.  When you {cmd:ctset} your data, 
{cmd:ctset} also checks that what you have declared makes sense.

{pstd}
In the second syntax, {cmd:ctset} changes the value of
{cmd:show}/{cmd:noshow}.  In {opt show} mode -- the default -- the other ct
commands display the identities of the key ct variables before their normal
output.  If you type {cmd:ctset, noshow}, they will not do this.  If you type
{cmd:ctset, noshow} and then wish to restore the default behavior, type
{cmd:ctset, show}.

{pstd}
In the third syntax, {cmd:ctset, clear} causes Stata to no longer consider the
data to be ct data.  The data itself remains unchanged.  It is not necessary to
type {cmd:ctset, clear} before doing another {cmd:ctset}.  {cmd:ctset, clear}
is used mostly by programmers.  

{pstd}
In the fourth syntax, {cmd:ctset} -- which can be abbreviated {cmd:ct}
here -- displays the identities of the key ct variables and reruns the
checks on your data.  Thus {cmd:ct} can remind you of what you have {cmd:ctset}
(especially if you have {cmd:ctset, noshow}) and reverify your data if you 
make changes to the data.


{marker options}{...}
{title:Options}

{phang}
{opth by(varlist)} indicates that counts are provided by group.  For instance, 
consider data containing records such as

	  t    fail   cens    sex    agecat
	  5      10      2      0         1
	  5       6      1      1         1
	  5      12      0      0         2

{pmore}
These data indicate that, in the category {cmd:sex}=0 and {cmd:agecat}=1, 10
failed and 2 were censored at time 5; for {cmd:sex}=1, 1 was censored and 6
failed; and so on.

{pmore}
The above data would be declared

{pmore2}{cmd:. ctset t fail cens, by(sex agecat)}

{pmore}
The order of the records is not important, nor is it important that there be a 
record at every time for every group or that there be only one record for
a time and group.  However, the data must contain the full table of events.

{phang}
{opt show} and {opt noshow} specify whether the identities of the key ct
variables are to be displayed at the start of every ct command.  Some users find
the report reassuring; others find it repetitive.  In any case, you can set 
and unset {opt show}, and you can always type {cmd:ct} to see the summary.

{phang}
{opt clear} makes Stata no longer consider the data to be ct data.


{marker remarks}{...}
{title:Remarks}

{pstd}
An observation in a ct dataset records the number of events occurring:

{pstd}
More typically, the dataset also contains categorical variables:

	sex      t    failed   censored
	 1      10      2          1

{pstd}
This observation records that in the group sex==1, 2 failed and 1 was
censored at time 10.  These data would be {cmd:ctset} by typing

{phang2}{cmd:. ctset t failed censored, by(sex)}

{pstd}
There can be multiple categorical variables.  Our data might be

	agegrp    sex      t    failed   censored
	   2       1      10      2          1

{pstd}
so that now the 10 and 2 refer to the category agegrp==2 and sex==1. These
data would be {cmd:ctset} by typing

{phang2}{cmd:. ctset t failed censored, by(sex agegrp)}{p_end}
    or
{phang2}{cmd:. ctset t failed censored, by(agegrp sex)}

{pstd}
It does not matter in what order we specify the categorical variables.

{pstd}
Once our data are {cmd:ctset}, we can convert it to survival-time data:

	{cmd:. cttost}

{pstd}
You can see {manhelp cttost ST}, but it is not necessary.  Once the data are
converted to st, you can use any of the st commands to analyze it; see
{manhelp st ST}.


{marker examples}{...}
{title:Examples}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse ctset1}

{pstd}List the data{p_end}
{phang2}{cmd:. list}

{pstd}{cmd:ctset} simple ct data{p_end}
{phang2}{cmd:. ctset failtime fail}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse ctset2}

{pstd}List the data{p_end}
{phang2}{cmd:. list, sepby(bearings)}

{pstd}{cmd:ctset} simple ct data, but where counts are provided by
groups{p_end}
{phang2}{cmd:. ctset failtime fail, by(bearings)}

    {hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse ctset3}

{pstd}List the data{p_end}
{phang2}{cmd:. list}

{pstd}{cmd:ctset} ct data with censoring{p_end}
{phang2}{cmd:. ctset failtime fail censored, by(bearings)}{p_end}
    {hline}

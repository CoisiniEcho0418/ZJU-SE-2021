{smcl}
{* *! version 1.1.3  11feb2011}{...}
{viewerdialog pkshape "dialog pkshape"}{...}
{vieweralsosee "[R] pkshape" "mansection R pkshape"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] pk" "help pk"}{...}
{viewerjumpto "Syntax" "pkshape##syntax"}{...}
{viewerjumpto "Description" "pkshape##description"}{...}
{viewerjumpto "Options" "pkshape##options"}{...}
{viewerjumpto "Remarks" "pkshape##remarks"}{...}
{viewerjumpto "Examples" "pkshape##examples"}{...}
{title:Title}

{p2colset 5 20 22 2}{...}
{p2col :{manlink R pkshape} {hline 2}}Reshape (pharmacokinetic) Latin-square data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:pkshape} {it:id sequence period1 period2} [{it:period list}]
[{cmd:,} {it:options}]

{synoptset 19}{...}
{synopthdr}
{synoptline}
{synopt :{opth o:rder(strings:string)}}apply treatments in specified order{p_end}
{synopt :{opth out:come(newvar)}}name for outcome variable; default is
{cmd:outcome(outcome)}{p_end}
{synopt :{opth tr:eatment(newvar)}}name for treatment variable; default is
{cmd:treatment(treat)}{p_end}
{synopt :{opth car:ryover(newvar)}}name for carryover variable; default is
{cmd:carryover(carry)}{p_end}
{synopt :{opth seq:uence(newvar)}}name for sequence variable; default is
{cmd:sequence(sequence)}{p_end}
{synopt :{opth per:iod(newvar)}}name for period variable; default is
{cmd:period(period)}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Epidemiology and related > Other >}
     {bf:Reshape pharmacokinetic latin-square data}


{marker description}{...}
{title:Description}

{pstd}
{cmd:pkshape} reshapes the data for use with {helpb anova}, {helpb pkcross},
and {helpb pkequiv}.  Latin-square and crossover data are often organized in a
manner that cannot be analyzed easily with Stata.  {cmd:pkshape} reorganizes
the data in memory for use in Stata.

{pstd}
{cmd:pkshape} is one of the pk commands.  Please read {helpb pk} before reading
this entry.


{marker options}{...}
{title:Options}

{phang}
{opth order:(strings:string)} specifies the order in which treatments were
applied.  If the {opt sequence()} specifier is a string variable that specifies
the order, this option is not necessary.  Otherwise, {opt order()} specifies
how to generate the treatment and carryover variables.  Any string variable can
be used to specify the order.  For crossover designs, any washout periods can
be indicated with the number 0.

{phang}
{opth outcome(newvar)} specifies the name for the outcome variable in the
reorganized data.  By default, {cmd:outcome(outcome)} is used.

{phang}
{opth treatment(newvar)} specifies the name for the treatment variable in the
reorganized data.  By default, {cmd:treatment(treat)} is used.

{phang}
{opth carryover(newvar)} specifies the name for the carryover variable in the
reorganized data.  By default, {cmd:carryover(carry)} is used.

{phang}
{opth sequence(newvar)} specifies the name for the sequence variable in the
reorganized data.  By default, {cmd:sequence(sequence)} is used.

{phang}
{opth period(newvar)} specifies the name for the period variable in the
reorganized data.  By default, {cmd:period(period)} is used.


{marker remarks}{...}
{title:Remarks}

{pstd}
Often, data from a Latin-square experiment are naturally organized in a
manner that Stata cannot manage easily.  {cmd:pkshape} reorganizes
Latin-square data so that they can be used with {helpb anova}
or any {helpb pk} command.  This reorganization includes the classic 2 x 2
crossover design commonly used in pharmaceutical research, as well as many
other Latin-square designs.


{marker examples}{...}
{title:Examples}

    {hline}
{phang}{cmd:. webuse chowliu}{p_end}
{phang}{cmd:. pkshape id seq period1 period2, order(ab ba)}{p_end}
    {hline}
{phang}{cmd:. webuse music, clear}{p_end}
{phang}{cmd:. pkshape id seq day1 day2 day3 day4 day5}{p_end}
{phang}{cmd:. anova outcome seq period treat}{p_end}
    {hline}
{phang}{cmd:. webuse applesales, clear}{p_end}
{phang}{cmd:. pkshape id seq p1 p2 p3, order(bca abc cab) seq(pattern) period(order) treat(displays)}{p_end}
{phang}{cmd:. anova outcome pattern order display id|pattern}{p_end}
    {hline}

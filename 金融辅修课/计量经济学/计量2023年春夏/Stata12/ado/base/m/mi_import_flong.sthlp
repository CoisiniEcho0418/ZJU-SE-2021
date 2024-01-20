{smcl}
{* *! version 1.0.10  31mar2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] mi import flong" "mansection MI miimportflong"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] intro" "help mi"}{...}
{vieweralsosee "[MI] mi import" "help mi_import"}{...}
{viewerjumpto "Syntax" "mi_import_flong##syntax"}{...}
{viewerjumpto "Description" "mi_import_flong##description"}{...}
{viewerjumpto "Options" "mi_import_flong##options"}{...}
{viewerjumpto "Remarks" "mi_import_flong##remarks"}{...}
{title:Title}

{p2colset 5 29 31 2}{...}
{p2col :{manlink MI mi import flong} {hline 2}}Import flong-like data into mi
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:mi import flong}{cmd:,}
{it:required_options}
[{it:true_options}]

{synoptset 20}{...}
{synopthdr:required_options}
{synoptline}
{synopt:{cmd:m(}{varname}{cmd:)}}name of variable containing {it:m}{p_end}
{synopt:{cmd:id(}{varlist}{cmd:)}}identifying variable(s){p_end}
{synoptline}

{synopthdr:true_options}
{synoptline}
{synopt:{cmdab:imp:uted(}{varlist}{cmd:)}}imputed variables to be registered
{p_end}
{synopt:{cmdab:pas:sive(}{varlist}{cmd:)}}passive variables to be registered
{p_end}
{synopt:{cmd:clear}}okay to replace unsaved data in memory{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Multiple imputation}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mi} {cmd:import} {cmd:flong} imports flong-like data, that is, data in
which {it:m}=0, {it:m}=1, ..., {it:m}={it:M} are all recorded in one {cmd:.dta}
dataset.  

{p 4 4 2}
{cmd:mi} {cmd:import} {cmd:flong} converts the data to {cmd:mi} flong style.
The data are {cmd:mi} {cmd:set}.


{marker options}{...}
{title:Options}

{p 4 8 2}
{cmd:m(}{varname}{cmd:)} and {cmd:id(}{varlist}{cmd:)} are required.{break}
    {cmd:m(}{it:varname}{cmd:)} specifies the variable that takes on values 0,
    1, ..., {it:M}, the variable that identifies observations corresponding to 
    {it:m}=0, {it:m}=1, ..., {it:m}={it:M}.  {it:varname}=0 identifies
    the original data, {it:varname}=1 identifies {it:m}=1, and so on.

{p 8 8 2}
    {cmd:id(}{it:varlist}{cmd:)} specifies the variable or variables that 
    uniquely identify observations within {cmd:m()}.

{p 4 8 2}
{cmd:imputed(}{varlist}{cmd:)} and {cmd:passive(}{it:varlist}{cmd:)}
    are truly optional options, although it would be unusual if
    {cmd:imputed()} were not specified.

{p 8 8 2}
    {cmd:imputed(}{it:varlist}{cmd:)} specifies the names of the 
    imputed variables.
    
{p 8 8 2}
    {cmd:passive(}{it:varlist}{cmd:)} specifies the names of the 
    passive variables, if any.

{p 4 8 2}
{cmd:clear}
    specifies that it is okay to replace the data in memory even if they 
    have changed since they were saved to disk.  Remember, 
    {cmd:mi} {cmd:import} {cmd:flong} starts with flong-like data in 
    memory and ends with {cmd:mi} flong data in memory.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
The procedure to convert flong-like data to {cmd:mi} flong is this:

{p 8 12 2}
1.  {cmd:use} the unset data.

{p 8 12 2}
2.  Issue the {cmd:mi} {cmd:import} {cmd:flong} command.

{p 8 12 2}
3.  Perform the checks outlined in 
    {it:{help mi_import##warning:Using mi import nhanes1, ice, flong, and flongsep}}
    of {bf:{help mi_import:[MI] mi import}}.

{p 8 12 2}
4.  Use {bf:{help mi_convert:mi convert}} to convert the data to a more 
    convenient style, such as wide or mlong.

{p 4 4 2}
For instance, you have the following unset data:

{* -----------------------------------------------------junk1.smcl ---}{...}
{* edited to add use statement}{...}
	. {cmd:use ourunsetdata}

        . {cmd:list, separator(2)}
        {txt}
             {c TLC}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c TRC}
             {c |} {res}m   subject   a     b     c {txt}{c |}
             {c LT}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c RT}
          1. {c |} {res}0       101   1     2     3 {txt}{c |}
          2. {c |} {res}0       102   4     .     . {txt}{c |}
             {c LT}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c RT}
          3. {c |} {res}1       101   1     2     3 {txt}{c |}
          4. {c |} {res}1       102   4   4.5   8.5 {txt}{c |}
             {c LT}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c RT}
          5. {c |} {res}2       101   1     2     3 {txt}{c |}
          6. {c |} {res}2       102   4   5.5   9.5 {txt}{c |}
             {c BLC}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c BRC}
{* -----------------------------------------------------junk1.smcl ---}{...}

{p 4 4 2}
You are told that these data contain the original data ({cmd:m}=0) and 
two imputations ({cmd:m}=1 and {cmd:m}=2), that variable {cmd:b} 
is imputed, and that variable {cmd:c} is passive and in fact equal to 
{cmd:a}+{cmd:b}.
These are the same data discussed in {bf:{help mi_styles:[MI] styles}}
but in unset form.

{p 4 4 2}
The fact that these data are nicely sorted is irrelevant.  To import these
data, type

{* -----------------------------------------------------junk2.smcl ---}{...}
	. {cmd:mi import flong, m(m) id(subject) imputed(b) passive(c)} 
{* -----------------------------------------------------junk2.smcl ---}{...}

{p 4 4 2}
These data are short enough that we can list the result:

{* -----------------------------------------------------junk3.smcl ---}{...}
        . {cmd:list, separator(2)}

             {c TLC}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 7}{c -}{hline 8}{c -}{hline 10}{c TRC}
             {c |} {res}m   subject   a     b     c   _mi_m   _mi_id   _mi_miss {txt}{c |}
             {c LT}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 7}{c -}{hline 8}{c -}{hline 10}{c RT}
          1. {c |} {res}0       101   1     2     3       0        1          0 {txt}{c |}
          2. {c |} {res}0       102   4     .     .       0        2          0 {txt}{c |}
             {c LT}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 7}{c -}{hline 8}{c -}{hline 10}{c RT}
          3. {c |} {res}1       101   1     2     3       1        1          . {txt}{c |}
          4. {c |} {res}1       102   4   4.5   8.5       1        2          . {txt}{c |}
             {c LT}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 7}{c -}{hline 8}{c -}{hline 10}{c RT}
          5. {c |} {res}2       101   1     2     3       2        1          . {txt}{c |}
          6. {c |} {res}2       102   4   5.5   9.5       2        2          . {txt}{c |}
             {c BLC}{hline 3}{c -}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 7}{c -}{hline 8}{c -}{hline 10}{c BRC}
{* -----------------------------------------------------junk3.smcl ---}{...}

{p 4 4 2}
We will now perform the checks outlined in 
{it:{help mi_import##warning:Using mi import nhanes1, ice, flong, and flongsep}}
of {bf:{help mi_import:[MI] mi import}}, 
which are to run 
{cmd:mi} {cmd:describe}
and 
{cmd:mi} {cmd:varying}
to verify that variables are registered correctly:

{* -----------------------------------------------------junk4.smcl ---}{...}
	. {cmd:mi describe}

{txt}{p 10 18 1}
Style:
{res:flong}{break}
{break}last {bf:mi update} 25jan2011 11:54:58,
0 seconds ago

          Obs.:   complete  {res}          1
{txt}{col 19}incomplete{res}          1{txt}  ({it:M} = {res:2} imputations)
{col 19}{hline 21}
{col 19}total     {res}          2

{txt}{p 10 28 1}
Vars.:  imputed:  1;
b({res:1})
{p_end}

{p 18 28 1}
passive: 1;
c({res:1})
{p_end}

{p 18 28 1}
regular: 0
{p_end}

{p 18 28 1}
system:{bind:  }3;
_mi_m _mi_id _mi_miss
{p_end}

{p 17 12 1}
(there are 3 unregistered variables;
m subject a)
{p_end}


	. {cmd:mi varying}
	{txt}
                     Possible problem   variable names
          {hline}
{p 19 32 2}
imputed nonvarying:
(none)
{p_end}
{p 19 32 2}
passive nonvarying:
(none)
{p_end}
{p 17 32 2}
unregistered varying:
(none)
{p_end}
{p 10 32 2}
*unregistered super/varying:
(none)
{p_end}
{p 11 32 2}
unregistered super varying:
{res}m
{txt}{p_end}
          {hline}
{p 10 12 2}
* super/varying means super varying but would be
varying if registered as imputed; variables vary
only where equal to soft missing in {it:m}=0.
{p_end}
{* -----------------------------------------------------junk4.smcl ---}{...}

{p 4 4 2}
We discover that unregistered variable {cmd:m} 
is {help mi_glossary##def_varying:super varying}
(see {bf:{help mi_glossary:[MI] Glossary}}).
Here we no longer need {cmd:m}, so we will drop the variable
and rerun {cmd:mi} {cmd:varying}.
We will find that there are no remaining problems, so 
we will convert our data to our preferred wide style:

{* -----------------------------------------------------junk5.smcl ---}{...}
	. {cmd:drop m}

	. {cmd:mi varying}
	{txt}
                     Possible problem   variable names
          {hline}
{p 19 32 2}
imputed nonvarying:
(none)
{p_end}
{p 19 32 2}
passive nonvarying:
(none)
{p_end}
{p 17 32 2}
unregistered varying:
(none)
{p_end}
{p 10 32 2}
*unregistered super/varying:
(none)
{p_end}
{p 11 32 2}
unregistered super varying:
(none)
{p_end}
          {hline}
{p 10 12 2}
* super/varying means super varying but would be
varying if registered as imputed; variables vary
only where equal to soft missing in {it:m}=0.
{p_end}

	. {cmd:mi convert wide, clear}

	. {cmd:list}
        {txt}
             {c TLC}{hline 9}{c -}{hline 3}{c -}{hline 3}{c -}{hline 3}{c -}{hline 10}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c TRC}
             {c |} {res}subject   a   b   c   _mi_miss   _1_b   _1_c   _2_b   _2_c {txt}{c |}
             {c LT}{hline 9}{c -}{hline 3}{c -}{hline 3}{c -}{hline 3}{c -}{hline 10}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c RT}
          1. {c |} {res}    101   1   2   3          0      2      3      2      3 {txt}{c |}
          2. {c |} {res}    102   4   .   .          1    4.5    8.5    5.5    9.5 {txt}{c |}
             {c BLC}{hline 9}{c -}{hline 3}{c -}{hline 3}{c -}{hline 3}{c -}{hline 10}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c BRC}
{* -----------------------------------------------------junk5.smcl ---}{...}

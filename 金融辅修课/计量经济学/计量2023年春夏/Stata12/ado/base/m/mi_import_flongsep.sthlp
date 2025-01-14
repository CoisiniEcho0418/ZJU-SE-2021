{smcl}
{* *! version 1.0.10  31mar2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] mi import flongsep" "mansection MI miimportflongsep"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] intro" "help mi"}{...}
{vieweralsosee "[MI] mi import" "help mi_import"}{...}
{viewerjumpto "Syntax" "mi_import_flongsep##syntax"}{...}
{viewerjumpto "Description" "mi_import_flongsep##description"}{...}
{viewerjumpto "Options" "mi_import_flongsep##options"}{...}
{viewerjumpto "Remarks" "mi_import_flongsep##remarks"}{...}
{title:Title}

{p2colset 5 32 34 2}{...}
{p2col :{manlink MI mi import flongsep} {hline 2}}Import flongsep-like data
    into mi{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:mi import flongsep} {it:name}{cmd:,}
{it:required_options}
[{it:true_options}]

{p 4 4 2}
where {it:name} is the name of the flongsep data to be created. 

{synoptset 20}{...}
{synopthdr:required_options}
{synoptline}
{synopt:{cmd:using(}{it:filenamelist}{cmd:)}}input filenames for {it:m}=1,
   {it:m}=2, ...{p_end}
{synopt:{cmd:id(}{varlist}{cmd:)}}identifying variable(s){p_end}
{synoptline}
{p 4 6 2}
Note: {cmd:use} the input file for {it:m}=0 before 
issuing {cmd:mi} {cmd:import} {cmd:flongsep}.

{synopthdr:true_options}
{synoptline}
{synopt:{cmdab:imp:uted(}{varlist}{cmd:)}}imputed variables to be registered
{p_end}
{synopt:{cmdab:pas:sive(}{varlist}{cmd:)}}passive variables to
  be registered{p_end}
{synopt:{cmd:clear}}okay to replace unsaved data in memory{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Multiple imputation}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mi} {cmd:import} {cmd:flongsep} imports flongsep-like data,
that is, data in which {it:m}=0, {it:m}=1, ..., {it:m}={it:M} are each 
recorded in separate {cmd:.dta} datasets.  

{p 4 4 2}
{cmd:mi} {cmd:import} {cmd:flongsep} 
converts the data to {cmd:mi} flongsep and 
{cmd:mi} {cmd:set}s the data.


{marker options}{...}
{title:Options}

{p 4 8 2}
{cmd:using(}{it:filenamelist}{cmd:)} is required; it specifies the 
    names of the {cmd:.dta} datasets containing {it:m}=1, {it:m}=2, ...,
    {it:m}={it:M}.  The dataset corresponding to {it:m}=0 is not specified; it
    is to be in memory at the time the {cmd:mi} {cmd:import} {cmd:flongsep}
    command is given.

{p 8 8 2}
    The filenames might be specified as 

{p 12 12 2}
	{cmd:using(ds1 ds2 ds3 ds4 ds5)}

{p 8 8 2}
    which states that {it:m}=1 is in file {cmd:ds1.dta}, 
    {it:m}=2 is in file {cmd:ds2.dta}, ..., and 
    {it:m}=5 is in file {cmd:ds5.dta}.
    Also, {cmd:{c -(}}{it:#}{cmd:-}{it:#}{cmd:{c )-}} is understood, so
    the above could just as well be specified as

{p 12 12 2}
	{cmd:using(ds{c -(}1-5{c )-})}

{p 8 8 2}
    The braced numeric range may appear anywhere in the name, and thus 

{p 12 12 2}
	{cmd:using(ds{c -(}1-5{c )-}imp)}

{p 8 8 2}
    would mean that {cmd:ds1imp.dta}, {cmd:ds2imp.dta}, ..., {cmd:ds5imp.dta}
    contain {it:m}=1, {it:m}=2, ..., {it:m}=5.

{p 8 8 2}
    Alternatively, a comma-separated list can appear inside the braces.
    Filenames {cmd:dsfirstm.dta}, {cmd:dssecondm.dta}, ..., {cmd:dsfifthm.dta}
    can be specified as

{p 12 12 2}
	{cmd:using(ds{c -(}first,second,third,fourth,fifth{c )-}m)}

{p 8 8 2}
    Filenames can be specified with or without the {cmd:.dta} suffix and may
    be enclosed in quotes if they contain special characters.

{p 4 8 2}
{cmd:id(}{varlist}{cmd:)} is required; it specifies the variable 
    or variables that uniquely identify the observations in each dataset.
    The coding must be the same across datasets.

{p 4 8 2}
{cmd:imputed(}{varlist}{cmd:)} and {cmd:passive(}{it:varlist}{cmd:)}
    are truly optional options, although it would be unusual if {cmd:imputed()} 
    were not specified.

{p 8 8 2}
    {cmd:imputed(}{it:varlist}{cmd:)} specifies the names of the imputed 
    variables.
    
{p 8 8 2}
    {cmd:passive(}{it:varlist}{cmd:)} specifies the names of the passive 
    variables.

{p 4 8 2}
{cmd:clear}
    specifies that it is okay to replace the data in memory even if they 
    have changed since they were saved to disk.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
The procedure to convert flongsep-like data to {cmd:mi} flongsep is this:

{p 8 12 2}
    1.  {cmd:use} the dataset corresponding to {it:m}=0.

{p 8 12 2}
    2.  Issue the {cmd:mi} {cmd:import} {cmd:flongsep} {it:name} command,
        where {it:name} is the name of the {cmd:mi} flongsep data
        to be created.

{p 8 12 2}
    3.  Perform the checks outlined in 
        {it:{help mi_import##warning:Using mi import nhanes1, ice, flong, and flongsep}}
	of {bf:{help mi_import:[MI] mi import}}.

{p 8 12 2}
    4.  Use {bf:{help mi_convert:mi convert}} to convert the data to a
        more convenient style such as wide, mlong, or flong.

{p 4 4 2}
For instance, 
you have been given the unset datasets {cmd:imorig.dta}, {cmd:im1.dta}, and 
{cmd:im2.dta}.  You are told that these datasets contain the original 
data and two imputations, that variable {cmd:b} is imputed, and 
that variable {cmd:c} is passive and in fact equal to {cmd:a}+{cmd:b}.
Here are the datasets:

{* -------------------------------------------------- junk1.smcl ---}{...}
	. {cmd:use imorig}

	. {cmd:list}
        {txt}
             {c TLC}{hline 9}{c -}{hline 3}{c -}{hline 3}{c -}{hline 3}{c TRC}
             {c |} {res}subject   a   b   c {txt}{c |}
             {c LT}{hline 9}{c -}{hline 3}{c -}{hline 3}{c -}{hline 3}{c RT}
          1. {c |} {res}    101   1   2   3 {txt}{c |}
          2. {c |} {res}    102   4   .   . {txt}{c |}
             {c BLC}{hline 9}{c -}{hline 3}{c -}{hline 3}{c -}{hline 3}{c BRC}


	. {cmd:use im1}

	. {cmd:list}
        {txt}
             {c TLC}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c TRC}
             {c |} {res}subject   a     b     c {txt}{c |}
             {c LT}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c RT}
          1. {c |} {res}    101   1     2     3 {txt}{c |}
          2. {c |} {res}    102   4   4.5   8.5 {txt}{c |}
             {c BLC}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c BRC}


	. {cmd:use im2}

	. {cmd:list}
        {txt}
             {c TLC}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c TRC}
             {c |} {res}subject   a     b     c {txt}{c |}
             {c LT}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c RT}
          1. {c |} {res}    101   1     2     3 {txt}{c |}
          2. {c |} {res}    102   4   5.5   9.5 {txt}{c |}
             {c BLC}{hline 9}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c BRC}
{* -------------------------------------------------- junk1.smcl ---}{...}

{p 4 4 2}
These are the same data discussed in {bf:{help mi_styles:[MI] styles}}
but in unset form.

{p 4 4 2}
The fact that these datasets are nicely sorted is irrelevant.
To import these datasets, you type

{* -------------------------------------------------- junk2.smcl ---}{...}
{* edited for line break}{...}
	. {cmd:use imorig}

	. {cmd:mi import flongsep mymi, using(im1 im2) id(subject)}
	                           {cmd:imputed(b) passive(c)}
{* -------------------------------------------------- junk2.smcl ---}{...}

{p 4 4 2}
We will now perform the checks outlined in 
{it:{help mi_import##warning:Using mi import nhanes1, ice, flong, and flongsep}}
of {bf:{help mi_import:[MI] mi import}}, 
which are to run 
{cmd:mi} {cmd:describe} 
and 
{cmd:mi} {cmd:varying}
to verify that variables are registered correctly:

{* -----------------------------------------------------junk3.smcl ---}{...}
	. {cmd:mi describe}

{txt}{p 10 18 1}
Style:
{res:flongsep mymi}
{break}last {bf:mi update} 25jan2011 13:21:08,
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
system:{bind:  }2;
_mi_id _mi_miss
{p_end}

{p 17 12 1}
(there are 2 unregistered variables;
subject a)
{p_end}


	. {cmd:mi varying}
	{res}{txt}
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
{* -----------------------------------------------------junk3.smcl ---}{...}

{p 4 4 2}
{cmd:mi} {cmd:varying} reported no problems.
We finally convert to our preferred wide style:

{* -----------------------------------------------------junk4.smcl ---}{...}
	. {cmd:mi convert wide, clear}

	. {cmd:list}
        {txt}
             {c TLC}{hline 9}{c -}{hline 3}{c -}{hline 3}{c -}{hline 3}{c -}{hline 10}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c TRC}
             {c |} {res}subject   a   b   c   _mi_miss   _1_b   _1_c   _2_b   _2_c {txt}{c |}
             {c LT}{hline 9}{c -}{hline 3}{c -}{hline 3}{c -}{hline 3}{c -}{hline 10}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c RT}
          1. {c |} {res}    101   1   2   3          0      2      3      2      3 {txt}{c |}
          2. {c |} {res}    102   4   .   .          1    4.5    8.5    5.5    9.5 {txt}{c |}
             {c BLC}{hline 9}{c -}{hline 3}{c -}{hline 3}{c -}{hline 3}{c -}{hline 10}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c -}{hline 6}{c BRC}
{* -----------------------------------------------------junk4.smcl ---}{...}

{p 4 4 2}
We are done with the converted data in flongsep format, so we will 
erase the files:

{* -----------------------------------------------------junk5.smcl ---}{...}
	. {cmd:mi erase mymi}
{res}{txt}{p 8 8}(files
mymi.dta
_1_mymi.dta
_2_mymi.dta
erased)
{p_end}
{* -----------------------------------------------------junk5.smcl ---}{...}

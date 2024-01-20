{smcl}
{* *! version 1.0.11  11feb2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] mi import nhanes1" "mansection MI miimportnhanes1"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] intro" "help mi"}{...}
{vieweralsosee "[MI] mi import" "help mi_import"}{...}
{viewerjumpto "Syntax" "mi_import_nhanes1##syntax"}{...}
{viewerjumpto "Description" "mi_import_nhanes1##description"}{...}
{viewerjumpto "Options" "mi_import_nhanes1##options"}{...}
{viewerjumpto "Remarks" "mi_import_nhanes1##remarks"}{...}
{title:Title}

{p2colset 5 31 33 2}{...}
{p2col :{manlink MI mi import nhanes1} {hline 2}}Import NHANES-format data
     into mi{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:mi import nhanes1} {it:name}{cmd:,}
{it:required_options}
[{it:true_options}
{it:odd_options}]

{p 4 4 2}
where {it:name} is the name of the flongsep data to be created. 

{synoptset 28}{...}
{synopthdr:required_options}
{synoptline}
{synopt:{cmd:using(}{it:filenamelist}{cmd:)}}input filenames for {it:m}=1,
    {it:m}=2, ...{p_end}
{synopt:{cmd:id(}{varlist}{cmd:)}}identifying variable(s){p_end}
{synoptline}
{p 4 6 2}
Note: {cmd:use} the input file for {it:m}=0 before
issuing {cmd:mi} {cmd:import} {cmd:nhanes1}.

{synopthdr:true_options}
{synoptline}
{synopt:{cmdab:upper:case}}prefix and suffix in uppercase{p_end}
{synopt:{cmd:clear}}okay to replace unsaved data in memory{p_end}
{synoptline}

{synopthdr:odd_options}
{synoptline}
{synopt:{cmd:nacode(}{it:#}{cmd:)}}not applicable code; default {cmd:0}{p_end}
{synopt:{cmd:obscode(}{it:#}{cmd:)}}observed code; default {cmd:1}{p_end}
{synopt:{cmd:impcode(}{it:#}{cmd:)}}imputed code; default {cmd:2}{p_end}

{synopt:{cmdab:imppre:fix("}{it:string}{cmd:" "}{it:string}{cmd:")}}variable
     prefix; default {cmd:"" ""}{p_end}
{synopt:{cmdab:impsuf:fix("}{it:string}{cmd:" "}{it:string}{cmd:")}}variable
    suffix; default {cmd:"if" "mi"}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
Note: The {it:odd_options} are not specified unless
you need to import data that are 
nhanes1-like but not really nhanes1 format.


{title:Menu}

{phang}
{bf:Statistics > Multiple imputation}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mi} {cmd:import} {cmd:nhanes1} imports data recorded in the format used
by the National Health and Nutrition Examination Survey (NHANES) produced by
the National Center for Health Statistics (NCHS) of the U.S. Centers for Disease
Control and Prevention (CDC); 
see {browse "http://www.cdc.gov/nchs/nhanes/nh3data.htm"}.


{marker options}{...}
{title:Options}

{p 4 8 2}
{cmd:using(}{it:filenamelist}{cmd:)} 
    is required; it specifies the 
    names of the {cmd:.dta} datasets containing {it:m}=1, {it:m}=2, ...,
    {it:m}={it:M}.  The dataset corresponding to {it:m}=0 is not specified; it
    is to be in memory at the time the {cmd:mi} {cmd:import} {cmd:nhanes1}
    command is given.

{p 8 8 2}
    The filenames might be specified as

{p 12 12 2}
	{cmd:using(nh1 nh2 nh3 nh4 nh5)}

{p 8 8 2}
    which states that {it:m}=1 is in file {cmd:nh1.dta}, 
    {it:m}=2 is in file {cmd:nh2.dta}, ..., and 
    {it:m}=5 is in file {cmd:nh5.dta}.
    Also, {cmd:{c -(}}{it:#}{cmd:-}{it:#}{cmd:{c )-}} is understood, so
    the files could just as well be specified as

{p 12 12 2}
	{cmd:using(nh{c -(}1-5{c )-})}

{p 8 8 2}
    The braced numeric range may appear anywhere in the name, and thus 

{p 12 12 2}
	{cmd:using(nh{c -(}1-5{c )-}imp)}

{p 8 8 2}
    would mean that {cmd:nh1imp.dta}, {cmd:nh2imp.dta}, ..., {cmd:nh5imp.dta}
    contain {it:m}=1, {it:m}=2, ..., {it:m}=5.

{p 8 8 2}
    Alternatively, a comma-separated list can appear inside the braces.
    Filenames {cmd:nhfirstm.dta}, {cmd:nhsecondm.dta}, ..., {cmd:nhfifthm.dta}
    can be specified as

{p 12 12 2}
	{cmd:using(nh{c -(}first,second,third,fourth,fifth{c )-}m)}

{p 8 8 2}
    Filenames can be specified with or without the {cmd:.dta} suffix and must 
    be enclosed in quotes if they contain special characters.

{p 4 8 2}
{cmd:id(}{varlist}{cmd:)} is required
    and is usually specified as {cmd:id(seqn)} or {cmd:id(SEQN)} depending on
    whether your variable names are in lowercase or uppercase.
    {cmd:id()} specifies the variable or variables that uniquely identify
    the observations in each dataset.  Per the nhanes1 standard, 
    the variable should be named {cmd:seqn} or {cmd:SEQN}.

{p 4 8 2}
{cmd:uppercase} is optional; it 
    specifies that the variable suffixes {cmd:IF} and {cmd:MI} 
    of the nhanes1 standard are 
    in uppercase.  The default is lowercase.  (More correctly, when 
    generalizing beyond nhanes1 format, the {cmd:uppercase} option
    specifies that all prefixes and suffixes are in uppercase.)

{p 4 8 2}
{cmd:nacode(}{it:#}{cmd:)}, {cmd:obscode(}{it:#}{cmd:)}, and
    {cmd:impcode(}{it:#}{cmd:)} are optional and are never specified
    when reading true nhanes1 data.  
    The defaults {cmd:nacode(0)}, {cmd:obscode(1)}, and {cmd:impcode(2)}
    correspond to the nhanes1 definition.
    These options allow changing the codes for not applicable, 
    observed, and imputed.
     
{p 4 8 2}
{cmd:impprefix("}{it:string}{cmd:"} {cmd:"}{it:string}{cmd:")} and 
{cmd:impsuffix("}{it:string}{cmd:"} {cmd:"}{it:string}{cmd:")}
    are optional and are never specified when reading true nhanes1 data.
    The defaults {cmd:impprefix(""} {cmd:"")} and
    {cmd:impsuffix("if"} {cmd:"mi")}
    correspond to the nhanes1 definition.
    These options allow setting different prefixes and suffixes.

{p 4 8 2}
{cmd:clear} specifies that it is okay to replace the data in memory even 
    if they have changed since they were saved to disk.  Remember, 
    {cmd:mi} {cmd:import} {cmd:nhanes1} starts with the first of the 
    NHANES data in memory and ends with {cmd:mi} data in memory.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Remarks are presented under the following headings:

	{help mi_import_nhanes1##format:Description of the nhanes1 format}
	{help mi_import_nhanes1##example:Importing nhanes1 data}


{marker format}{...}
{title:Description of the nhanes1 format}

{p 4 4 2}
Nhanes1 is not really an official format; it is the format used for a
particular dataset distributed by NCHS.  Because there currently are no
official or even informal standards for multiple-imputation data, perhaps the
method used by the NCHS for NHANES will catch on, so we named it nhanes1.  We
included the 1 on the end of the name in case the format is modified.

{p 4 4 2}
Data in nhanes1 format consist of a collection of {it:M}+1 separate 
files.  The first file contains the original data.  The remaining 
{it:M} files contain the imputed values for {it:m}=1, {it:m}=2, ..., 
{it:m}={it:M}.  

{p 4 4 2}
The first file contains a variable named {cmd:seqn} containing a 
sequence number.  The file also contains other variables
that comprise the nonimputed variables. 
Imputed variables, however, have their names suffixed 
with {cmd:IF}, standing for imputation flag, and those variables 
contain 1s, 2s, and 0s.
1 means that the value of the variable in that observation
was observed, 2 means that the value was missing, and 0 
means not applicable.  Think of 0 as
being equivalent to hard missing.  The value is not observed for good 
reason and therefore was not imputed.

{p 4 4 2}
The remaining {it:M} files contain {cmd:seqn} and the imputed variables 
themselves.  In these files, unobserved values are imputed.
This time, imputed variable names are suffixed with {cmd:MI}.

{p 4 4 2}
Here is an example:

{* ------------------------------------------------- junk1.smcl ---}{...}
	. {cmd:use nhorig}

	. {cmd:list}
        {txt}
             {c TLC}{hline 6}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c TRC}
             {c |} {res}seqn   a   bIF   cIF {txt}{c |}
             {c LT}{hline 6}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c RT}
          1. {c |} {res}   1  11     1     1 {txt}{c |}
          2. {c |} {res}   2  14     2     2 {txt}{c |}
             {c BLC}{hline 6}{c -}{hline 3}{c -}{hline 5}{c -}{hline 5}{c BRC}
{* ------------------------------------------------- junk1.smcl ---}{...}

{p 4 4 2}
The above is the first of the {it:M}+1 datasets.  
The {cmd:seqn} variable is the sequence number.
The {cmd:a} variable is a regular variable; we know that because the name
does not end in {cmd:IF}.  The {cmd:b} and {cmd:c} variables are 
imputed, and this dataset contains their imputation flags.  
Both variables are observed in the first observation and unobserved 
in the second.

{p 4 4 2}
Here is the corresponding dataset for {it:m}=1:

{* ------------------------------------------------- junk2.smcl ---}{...}
	. {cmd:use nh1}

	. {cmd:list}
        {txt}
             {c TLC}{hline 6}{c -}{hline 5}{c -}{hline 5}{c TRC}
             {c |} {res}seqn   bMI   cMI {txt}{c |}
             {c LT}{hline 6}{c -}{hline 5}{c -}{hline 5}{c RT}
          1. {c |} {res}   1     2     3 {txt}{c |}
          2. {c |} {res}   2   4.5   8.5 {txt}{c |}
             {c BLC}{hline 6}{c -}{hline 5}{c -}{hline 5}{c BRC}
{* ------------------------------------------------- junk2.smcl ---}{...}

{p 4 4 2}
This dataset states that in {it:m}=1, {cmd:b} is equal to 2 and 4.5 and
{cmd:c} is equal to 3 and 8.5.

{p 4 4 2}
We are about to show you the dataset for {it:m}=2.
Even before looking at it, however,
we know that 1) it will have two observations; 2) it will have the
{cmd:seqn} variable containing 1 and 2; 3) it will have two more variables 
named {cmd:bMI} and {cmd:cMI}; and 4) {cmd:bMI} will be equal to 2 and 
{cmd:cMI} will be equal to 3 in observations corresponding to {cmd:seqn}=1.
We know the last because in the first dataset, we learned that {cmd:b} 
and {cmd:c} were observed in {cmd:seqn}=1.

{* ------------------------------------------------- junk3.smcl ---}{...}
        . {cmd:use nh2}

        . {cmd:list}
        {txt}
             {c TLC}{hline 6}{c -}{hline 4}{c -}{hline 5}{c -}{hline 5}{c TRC}
             {c |} {res}seqn    a   bMI   cMI {txt}{c |}
             {c LT}{hline 6}{c -}{hline 4}{c -}{hline 5}{c -}{hline 5}{c RT}
          1. {c |} {res}   1   11     2     3 {txt}{c |}
          2. {c |} {res}   2   14   5.5   9.5 {txt}{c |}
             {c BLC}{hline 6}{c -}{hline 4}{c -}{hline 5}{c -}{hline 5}{c BRC}
{* ------------------------------------------------- junk3.smcl ---}{...}


{marker example}{...}
{title:Importing nhanes1 data}

{p 4 4 2}
The procedure to import nhanes1 data is this:

{p 8 12 2}
1.  {bf:{help use}} the dataset corresponding to {it:m}=0.

{p 8 12 2}
2.  Issue {cmd:mi} {cmd:import} {cmd:nhanes1} {it:name} ..., 
    where {it:name} is the name of the {cmd:mi} flongsep datasets to 
    be created.

{p 8 12 2}
    3.  Perform the checks outlined in 
        {it:{help mi_import##warning:Using mi import nhanes1, ice, flong, and flongsep}}
	of {bf:{help mi_import:[MI] mi import}}.

{p 8 12 2}
    4.  Use {bf:{help mi_convert:mi convert}} to convert the data to a
        more convenient style such as wide, mlong, or flong.

{p 4 4 2}
To import the {cmd:nhorig.dta}, {cmd:nh1.dta}, and 
{cmd:nh2.dta} datasets described in the section above, we will specify 
{cmd:mi} {cmd:import} {cmd:nhanes1}'s {cmd:uppercase} option because 
the suffixes were in uppercase.
We type 

{* ------------------------------------------------- junk4.smcl ---}{...}
	. {cmd:use nhorig}

	. {cmd:mi import nhanes1 mymi, using(nh1 nh2) id(seqn) uppercase}
{* ------------------------------------------------- junk4.smcl ---}{...}

{p 4 4 2}
The lack of any error message means that
we have successfully converted
nhanes1-format files {cmd:nhorig.dta}, {cmd:nh1.dta}, and {cmd:nh2.dta}
to {cmd:mi} flongsep files {cmd:mymi.dta}, {cmd:_1_mymi.dta}, and 
{cmd:_2_mymi.dta}.

{p 4 4 2}
We will now perform the checks outlined in 
{it:{help mi_import##warning:Using mi import nhanes1, ice, flong, and flongsep}}
of {bf:{help mi_import:[MI] mi import}}, 
which are to run {cmd:mi} {cmd:describe} 
and 
{cmd:mi} {cmd:varying} (see {bf:{help mi_describe:[MI] mi describe}} and
{bf:{help mi_varying:[MI] mi varying}})
to verify that variables are registered correctly:

{* ------------------------------------------------- junk5.smcl ---}{...}
	. {cmd:mi describe}

{txt}{p 12 18 1}
Style:
{res:flongsep mymi}
{break}last {bf:mi update} 25jan2011 12:58:46,
0 seconds ago

          Obs.:   complete  {res}          1
{txt}{col 19}incomplete{res}          1{txt}  ({it:M} = {res:2} imputations)
{col 19}{hline 21}
{col 19}total     {res}          2

{txt}{p 10 28 1}
Vars.:  imputed:  2;
b({res:1})
c({res:1})
{p_end}

{p 18 28 1}
passive: 0
{p_end}

{p 18 28 1}
regular: 0
{p_end}

{p 18 28 1}
system:{bind:  }2;
_mi_id _mi_miss
{p_end}

{p 17 4 1}
(there are 2 unregistered variables;
seqn a)
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
{* ------------------------------------------------- junk5.smcl ---}{...}

{p 4 4 2}
{cmd:mi varying} reported no problems.  

{p 4 4 2}
We finally convert to style flong, although in real life we would 
choose styles mlong or wide.  We are choosing flong because it is 
more readable:

{* ------------------------------------------------- junk6.smcl ---}{...}
	. {cmd:mi convert flong, clear}

	. {cmd:list, separator(2)}
        {txt}
             {c TLC}{hline 6}{c -}{hline 4}{c -}{hline 5}{c -}{hline 5}{c -}{hline 8}{c -}{hline 10}{c -}{hline 7}{c TRC}
             {c |} {res}seqn    a     b     c   _mi_id   _mi_miss   _mi_m {txt}{c |}
             {c LT}{hline 6}{c -}{hline 4}{c -}{hline 5}{c -}{hline 5}{c -}{hline 8}{c -}{hline 10}{c -}{hline 7}{c RT}
          1. {c |} {res}   1   11     2     3        1          0       0 {txt}{c |}
          2. {c |} {res}   2   14     .     .        2          1       0 {txt}{c |}
             {c LT}{hline 6}{c -}{hline 4}{c -}{hline 5}{c -}{hline 5}{c -}{hline 8}{c -}{hline 10}{c -}{hline 7}{c RT}
          3. {c |} {res}   1   11     2     3        1          .       1 {txt}{c |}
          4. {c |} {res}   2   14   4.5   8.5        2          .       1 {txt}{c |}
             {c LT}{hline 6}{c -}{hline 4}{c -}{hline 5}{c -}{hline 5}{c -}{hline 8}{c -}{hline 10}{c -}{hline 7}{c RT}
          5. {c |} {res}   1   11     2     3        1          .       2 {txt}{c |}
          6. {c |} {res}   2   14   5.5   9.5        2          .       2 {txt}{c |}
             {c BLC}{hline 6}{c -}{hline 4}{c -}{hline 5}{c -}{hline 5}{c -}{hline 8}{c -}{hline 10}{c -}{hline 7}{c BRC}
{* ------------------------------------------------- junk6.smcl ---}{...}

{p 4 4 2}
The flong data are in memory.
We are done with the converted data in flongsep format, so we
erase the files:

{* ------------------------------------------------- junk7.smcl ---}{...}
	. {cmd:mi erase mymi}
        (files mymi.dta _1_mymi.dta _2_mymi.dta erased)
{* ------------------------------------------------- junk7.smcl ---}{...}

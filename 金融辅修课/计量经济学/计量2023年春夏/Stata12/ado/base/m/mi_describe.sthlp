{smcl}
{* *! version 1.0.10  31mar2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] mi describe" "mansection MI midescribe"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] intro" "help mi"}{...}
{viewerjumpto "Syntax" "mi describe##syntax"}{...}
{viewerjumpto "Description" "mi describe##description"}{...}
{viewerjumpto "Options" "mi describe##options"}{...}
{viewerjumpto "Remarks" "mi describe##remarks"}{...}
{viewerjumpto "Saved results" "mi describe##saved_results"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col :{manlink MI mi describe} {hline 2}}Describe mi data{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:mi}
{cmdab:q:uery}

{p 8 12 2}
{cmd:mi}
{cmdab:d:escribe}
[{cmd:,}
{it:describe_options}]


{synoptset 18}{...}
{synopthdr:describe_options}
{synoptline}
{synopt:{cmdab:d:etail}}show missing-value counts for {it:m}=1, {it:m}=2, ...
{p_end}

{synopt:{cmdab:noup:date}}see {bf:{help mi_noupdate_option:[MI] noupdate option}}{p_end}
{synoptline}
{p2colreset}{...}


{title:Menu}

{phang}
{bf:Statistics > Multiple imputation}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mi} {cmd:query} reports whether the data in memory are {cmd:mi} data
and, if they are, reports the style in which they are set.

{p 4 4 2}
{cmd:mi} {cmd:describe} provides a more detailed report on {cmd:mi} data.


{marker options}{...}
{title:Options}

{p 4 8 2}
{cmd:detail} reports the number of missing values in {it:m}=1, {it:m}=2, ...,
    {it:m}={it:M} in the imputed and passive variables, along with the number
    of missing values in {it:m}=0.

{p 4 8 2}
{cmd:noupdate}
    in some cases suppresses the automatic {cmd:mi} {cmd:update} this 
    command might perform; 
    see {bf:{help mi_noupdate_option:[MI] noupdate option}}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Remarks are presented under the following headings:

	{help mi_describe##query:mi query}
	{help mi_describe##describe:mi describe}


{marker query}{...}
{title:mi query}

{p 4 4 2}
{cmd:mi query} without {cmd:mi} data in memory reports

	. {cmd:mi query}
	(data not {res:mi set})

{p 4 4 2}
With {cmd:mi} data in memory, you see something like

	. {cmd:mi query}
	data {res:mi set wide}, {it:M} = 15
	last {res:mi update} 25jan2011 09:57:53, approximately 5 minutes ago

{p 4 4 2}
{cmd:mi} {cmd:query} does not burden you with unnecessary information.  It
mentions when {bf:{help mi_update:mi update}} was last run because you
should run it periodically.


{marker describe}{...}
{title:mi describe}

{p 4 4 2}
{cmd:mi} {cmd:describe} more fully describes {cmd:mi} data:

{* -------------------------------------------- junk1.smcl ---}{...}
{* edit log to make 2 minutes ago}{...}
	. {cmd:mi describe}

{txt}{p 10 18 1}
Style:
{res:mlong}{break}
{break}last {bf:mi update} 25jan2011 10:21:07,
approximately 2 minutes ago

          Obs.:   complete  {res}         90
{txt}{col 19}incomplete{res}         10{txt}  ({it:M} = {res:20} imputations)
{col 19}{hline 21}
{col 19}total     {res}        100

{txt}{p 10 28 1}
Vars.:  imputed:  2;
smokes({res:10})
age({res:5})
{p_end}

{p 18 28 1}
passive: 1;
agesq({res:5})
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
gender race chd)
{p_end}
{* -------------------------------------------- junk1.smcl ---}{...}

{p 4 4 2}
{cmd:mi} {cmd:describe} lists the style of the data, the number of complete
and incomplete observations, {it:M} (the number of imputations), the
registered variables, and the number of missing values in {it:m}=0 of the
imputed and passive variables.  In the output, the line

{txt}{p 10 28 1}
Vars.:  imputed:  2;
smokes({res:10})
age({res:5})
{p_end}

{p 4 4 2} 
means that the {cmd:smokes} variable contains 10 missing values in {it:m}=0 and
that {cmd:age} contains 5.  Those values are 
{help mi_glossary##def_hardmissing:soft missings} and
thus eligible to be imputed.  If one of {cmd:smokes}' missing values in
{it:m}=0 were hard, the line would read

{txt}{p 10 28 1}
Vars.:  imputed:  2;
smokes({res:9}+{res:1})
age({res:5})
{p_end}

{p 4 4 2}
{cmd:mi} {cmd:describe} reports information about {it:m}=0.  To obtain
information about all {it:m}'s, use {cmd:mi} {cmd:describe,} {cmd:detail}:

{* -------------------------------------------- junk2.smcl ---}{...}
{* edit log to make 3 minutes ago}{...}
	. {cmd:mi describe, detail}

{txt}{p 10 18 1}
Style:
{res:mlong}{break}
{break}last {bf:mi update} 25jan2011 10:36:50,
approximately 3 minutes ago

          Obs.:   complete  {res}         90
{txt}{col 19}incomplete{res}         10{txt}  ({it:M} = {res:20} imputations)
{col 19}{hline 21}
{col 19}total     {res}        100

{txt}{p 10 28 1}
Vars.:  imputed:  2;
smokes({res:10}; 20*{res:0})
age({res:5}; 20*{res:0})
{p_end}

{p 18 28 1}
passive: 1;
agesq({res:5}; 20*{res:0})
{p_end}

{p 18 28 1}
regular: 0
{p_end}

{p 18 28 1}
system:{bind:  }3;
_mi_m _mi_id _mi_miss
{p_end}

{p 17 4 1}
(there are 3 unregistered variables;
gender race chd)
{p_end}
{* -------------------------------------------- junk2.smcl ---}{...}

{p 4 4 2}
In this example, all imputed values are nonmissing.  We can see that 
from

{txt}{p 10 28 1}
Vars.:  imputed:  2;
smokes({res:10}; 20*{res:0})
age({res:5}; 20*{res:0})
{p_end}

{p 4 4 2}
Note the {cmd:20*0} after the semicolons.
That is the number of missing values in {it:m}=1, {it:m}=2, ..., {it:m}=20.
In the {cmd:smokes} variable, there are 10 missing values in {it:m}=0, then 
0 in {it:m}=1, then 0 in {it:m}=2, and so on.
If {it:m}=17 had two missing imputed values, the line would read

{txt}{p 10 28 1}
Vars.:  imputed:  2;
smokes({res:10}; 16*{res:0}, {res:2}, 3*{res:0})
age({res:5}; 20*{res:0})
{p_end}

{p 4 4 2}
{cmd:16*0, 2, 3*0} means that for {it:m}=1, {it:m}=2, ..., {it:m}=20, 
the first 16 have 0 missing values, the next has 2,
and the last 3 have 0.

{p 4 4 2}
If {cmd:smokes} had 9+1 missing values rather than 10 -- that is, 
9 soft missing values plus 1 hard missing rather than all 10 being 
soft missing -- and all 9 soft missings were filled in, the line would read

{txt}{p 10 28 1}
Vars.:  imputed:  2;
smokes({res:9}+{res:1}; 20*{res:0})
age({res:5}; 20*{res:0})
{p_end}

{p 4 4 2}
The 20 imputations are shown as having no soft missing values.
It goes without saying that they have 1 hard missing.
Think of {cmd:20*0} as meaning {cmd:20*(0+1)}.

{p 4 4 2}
If {cmd:smokes} had 9+1 missing values and two of the 
soft missings in {it:m}=18 were still missing, the line would read

{txt}{p 10 28 1}
Vars.:  imputed:  2;
smokes({res:9}+{res:1}; 16*{res:0}, {res:2}, 3*{res:0})
age({res:5}; 20*{res:0})
{p_end}


{marker saved_results}{...}
{title:Saved results}

{p 4 4 2}
{cmd:mi query} saves the following in {cmd:r()}:

{col 9}Scalars
{col 13}{cmd:r(update)}{col 30}seconds since last {cmd:mi update}
{col 13}{cmd:r(m)}{col 30}{it:m} if {cmd:r(style)=="flongsep"}
{col 13}{cmd:r(M)}{col 30}{it:M} if {cmd:r(style)!="flongsep"}

{col 9}Macros
{col 13}{cmd:r(style)}{col 30}{it:style}
{col 13}{cmd:r(name)}{col 30}{it:name} if {cmd:r(style)=="flongsep"}


{p 8 8 2}
Note that {cmd:mi query} issues a return code of 0 even if the data 
are not {cmd:mi}.  In that case, {cmd:r(style)} is "".

{p 4 4 2}
{cmd:mi describe} saves the following in {cmd:r()}:

{col 9}Scalars
{col 13}{cmd:r(update)}{col 30}seconds since last {cmd:mi update}
{col 13}{cmd:r(N)}{col 30}{it:#} of obs. in {it:m}=0
{col 13}{cmd:r(N_incomplete)}{col 30}{it:#} of incomplete obs. in {it:m}=0
{col 13}{cmd:r(N_complete)}{col 30}{it:#} of complete obs. in {it:m}=0
{col 13}{cmd:r(M)}{col 30}{it:M}

{col 9}Macros
{col 13}{cmd:r(style)}{col 30}{it:style}

{col 13}{cmd:r(ivars)}{col 30}names of imputed variables
{col 13}{cmd:r(_0_miss_ivars)}{col 30}{it:#} == {cmd:.} in each {cmd:r(ivars)} in {it:m}=0
{col 13}{cmd:r(_0_hard_ivars)}{col 30}{it:#} >  {cmd:.} in each {cmd:r(ivars)} in {it:m}=0

{col 13}{cmd:r(pvars)}{col 30}names of passive variables
{col 13}{cmd:r(_0_miss_pvars)}{col 30}{it:#} >= {cmd:.} in each {cmd:r(pvars)} in {it:m}=0

{col 13}{cmd:r(rvars)}{col 30}names of regular variables

{p 8 8 2}
If the {cmd:detail} option is specified, for each {it:m}, {it:m}=1, 2, ...,
{it:M}, also saved are

{col 9}Macros
{col 13}{cmd:r(_}{it:m}{cmd:_miss_ivars)}{col 30}{it:#} == {cmd:.} in each {cmd:r(ivars)} in {it:m}
{col 13}{cmd:r(_}{it:m}{cmd:_miss_pvars)}{col 30}{it:#} >= {cmd:.} in each {cmd:r(pvars)} in {it:m}

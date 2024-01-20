{smcl}
{* *! version 1.0.7  07jun2011}{...}
{viewerdialog mi "dialog mi"}{...}
{vieweralsosee "[MI] mi export ice" "mansection MI miexportice"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] intro" "help mi"}{...}
{vieweralsosee "[MI] mi export" "help mi_export"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[MI] mi import ice" "help mi_import_ice"}{...}
{viewerjumpto "Syntax" "mi_export_ice##syntax"}{...}
{viewerjumpto "Description" "mi_export_ice##description"}{...}
{viewerjumpto "Option" "mi_export_ice##option"}{...}
{viewerjumpto "Remarks" "mi_export_ice##remarks"}{...}
{viewerjumpto "References" "mi_export_ice##references"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col :{manlink MI mi export ice} {hline 2}}Export mi data to ice format{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:mi export ice} 
[{cmd:,}
{cmd:clear}]


{title:Menu}

{phang}
{bf:Statistics > Multiple imputation}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mi} {cmd:export} {cmd:ice} 
converts the {cmd:mi} data in memory to {cmd:ice} format.
See Royston
({help mi export ice##R2004:2004},
 {help mi export ice##R2005a:2005a},
 {help mi export ice##R2005b:2005b},
 {help mi import ice##R2007a:2007},
 {help mi import ice##R2009a:2009}) for a description of {cmd:ice}.


{marker option}{...}
{title:Option}

{p 4 8 2}
{cmd:clear}
    specifies that it is okay to replace the data in memory even if they
    have changed since they were last saved to disk.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{cmd:mi} {cmd:export} {cmd:ice} is the inverse of 
{bf:{help mi_import_ice:mi import ice}}.
Below we use {cmd:mi} {cmd:export} {cmd:ice} to convert 
{cmd:miproto.dta} to {cmd:ice} format.  {cmd:miproto.dta} happens 
to be in wide form, but that is irrelevant.

{* ------------------------------------------------ junk1.smcl ---}{...}

	. {cmd:webuse miproto}
	{txt}(mi prototype)

	. {cmd:mi describe}

{txt}{p 10 18 1}
Style:
{res:wide}{break}
{break}last {bf:mi update} 30mar2011 12:46:49,
1 day ago

          Obs.:   complete  {res}          1
{txt}{col 19}incomplete{res}          1{txt}  ({it:M} = {res:2} imputations)
{col 19}{hline 21}
{col 19}total     {res}          2

{txt}{p 10 28 1}
Vars.:  imputed:  1;
b({res:1})
{p_end}

{p 18 28 1}
passive:  1;
c({res:1})
{p_end}

{p 18 28 1}
regular:  1;
a
{p_end}

{p 18 28 1}
system:{bind:   }1;
_mi_miss
{p_end}

{p 17 4 1}
(there are no unregistered variables)
{p_end}

	. {cmd:list}
        {txt}
             {c TLC}{hline 50}{c TRC}
             {c |} {res}a   b   c   _1_b   _2_b   _1_c   _2_c   _mi_miss {txt}{c |}
             {c LT}{hline 50}{c RT}
          1. {c |} 1   2   3      2      2      3      3          0 {c |}
          2. {c |} 4   .   .    4.5    5.5    8.5    9.5          1 {c |}
             {c BLC}{hline 50}{c BRC}

	. {cmd:mi export ice}

	. {cmd:list, separator(2)}
        {txt}
             {c TLC}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c TRC}
             {c |} {res}a     b     c   _mj   _mi {txt}{c |}
             {c LT}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c RT}
          1. {c |} {res}1     2     3     0     1 {txt}{c |}
          2. {c |} {res}4     .     .     0     2 {txt}{c |}
             {c LT}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c RT}
          3. {c |} {res}1     2     3     1     1 {txt}{c |}
          4. {c |} {res}4   4.5   8.5     1     2 {txt}{c |}
             {c LT}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c RT}
          5. {c |} {res}1     2     3     2     1 {txt}{c |}
          6. {c |} {res}4   5.5   9.5     2     2 {txt}{c |}
             {c BLC}{hline 3}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c -}{hline 5}{c BRC}
{* ------------------------------------------------ junk1.smcl ---}{...}


{marker references}{...}
{title:References}

{marker R2004}{...}
{p 4 8 2}
Royston, P. 2004.
    {browse "http://www.stata-journal.com/sjpdf.html?articlenum=st0067":Multiple imputation of missing values.}
    {it:Stata Journal} 4: 227-241.

{marker R2005a}{...}
{p 4 8 2}
------. 2005a.
    {browse "http://www.stata-journal.com/sjpdf.html?articlenum=st0067_1":Multiple imputation of missing values:  Update.}
    {it:Stata Journal} 5: 188-201.

{marker R2005b}{...}
{p 4 8 2}
------. 2005b.
    {browse "http://www.stata-journal.com/sjpdf.html?articlenum=st0067_2":Multiple imputation of missing values:  Update of ice.}
    {it:Stata Journal} 5: 527-536.

{marker R2007a}{...}
{p 4 8 2}
------. 2007.
    {browse "http://www.stata-journal.com/sjpdf.html?articlenum=st0067_3":Multiple imputation of missing values:  Further update of ice, with an emphasis on interval censoring.}
    {it:Stata Journal} 7: 445-464.

{marker R2009a}{...}
{p 4 8 2}
------. 2009.
    {browse "http://www.stata-journal.com/article.html?article=st0067_4":Multiple imputation of missing values:  Further update of ice, with an emphasis on categorical variables.}
    {it:Stata Journal} 9: 466-477.
{p_end}

{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-0] intro" "mansection M-0 intro"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-1] first" "help m1_first"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-6] Glossary" "help m6_glossary"}{...}
{viewerjumpto "Contents" "mata##contents"}{...}
{viewerjumpto "Description" "mata##description"}{...}
{viewerjumpto "Remarks" "mata##remarks"}{...}
{title:Title}

{phang}
{manlink M-0 intro} {hline 2} Introduction to the Mata manual


{marker contents}{...}
{title:Contents}

{col 14}Section{col 31}Description
{col 14}{hline 46}
{col 14}{bf:{help m1_intro:[M-1]}}{...}
{col 31}{bf:Introduction and advice}

{col 14}{bf:{help m2_intro:[M-2]}}{...}
{col 31}{bf:Language definition}

{col 14}{bf:{help m3_intro:[M-3]}}{...}
{col 31}{bf:Commands for controlling Mata}

{col 14}{bf:{help m4_intro:[M-4]}}{...}
{col 31}{bf:Index and guide to functions}

{col 14}{bf:{help m5_intro:[M-5]}}{...}
{col 31}{bf:Functions}

{col 14}{bf:{help m6_glossary:[M-6]}}{...}
{col 31}{bf:Mata glossary of common terms}
{col 14}{hline 46}


{marker description}{...}
{title:Description}

{p 4 4 2}
Mata is a matrix programming language that can be used by those who want to
perform matrix calculations interactively and by those who
want to add new features to Stata.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
This manual is divided into six sections.  Each section is organized
alphabetically, but there is an introduction in front that will help you get
around.

{p 4 4 2}
If you are new to Mata, here is a helpful reading list:
start by reading 

{col 9}{hline 61}
{col 9}{...}
{bf:{help m1_first:[M-1] first}}{...}
{col 31}{...}
Introduction and first session
{col 9}{...}
{bf:{help m1_interactive:[M-1] interactive}}{...}
{col 31}{...}
Using Mata interactively
{col 9}{...}
{bf:{help m1_how:[M-1] how}}{...}
{col 31}{...}
How Mata works
{col 9}{hline 61}

{p 4 4 2}
You may find other things in section {bf:[M-1]} that interest you.  
For a table of contents, see 

{col 9}{hline 61}
{col 9}{...}
{bf:{help m1_intro:[M-1] intro}}{...}
{col 31}{...}
Introduction and advice
{col 9}{hline 61}

{p 4 4 2}
Whenever you see a term that you are unfamiliar with, see

{col 9}{hline 61}
{col 9}{...}
{bf:{help m6_glossary:[M-6] Glossary}}{...}
{col 31}{...}
Mata glossary of common terms
{col 9}{hline 61}

{p 4 4 2}
Now that you know the basics, if you are interested, you can look deeper into
Mata's programming features:

{col 9}{hline 61}
{col 9}{...}
{bf:{help m2_syntax:[M-2] syntax}}{...}
{col 31}{...}
Mata language grammar and syntax
{col 9}{hline 61}

{p 4 4 2}
{bf:[M-2] syntax} is pretty dense reading, but it summarizes nearly
everything.  The other entries in [M-2] repeat what is said there but with
more explanation; see

{col 9}{hline 61}
{col 9}{...}
{bf:{help m2_intro:[M-2] intro}}{...}
{col 31}{...}
Language definition
{col 9}{hline 61}

{p 4 4 2}
because other entries in [M-2] will interest you.  If you are
interested in object-oriented programming, be sure to see 
{bf:{help m2_class:[M-2] class}}.

{p 4 4 2}
Along the way, you will eventually be guided to sections [M-4] and [M-5].
[M-5] documents Mata's functions; the alphabetical order 
makes it easy to find a function if you know its name but makes learning 
what functions there are hopeless.  That is the purpose of [M-4] -- to
present the functions in logical order.  See

{col 9}{hline 61}
{col 11}{...}
{bf:{help m4_intro:[M-4] intro}}{...}
{col 31}{...}
Index and guide to functions

{col 9}{...}
Mathematical
{col 11}{...}
{bf:{help m4_matrix:[M-4] matrix}}{...}
{col 31}{...}
Matrix functions{...}

{col 11}{...}
{bf:{help m4_solvers:[M-4] solvers}}{...}
{col 31}{...}
Matrix solvers and inverters{...}

{col 11}{...}
{bf:{help m4_scalar:[M-4] scalar}}{...}
{col 31}{...}
Scalar functions{...}

{col 11}{...}
{bf:{help m4_statistical:[M-4] statistical}}{...}
{col 31}{...}
Statistical functions{...}

{col 11}{...}
{bf:{help m4_mathematical:[M-4] mathematical}}{...}
{col 31}{...}
Other important functions

{col 9}{...}
Utility and manipulation{...}

{col 11}{...}
{bf:{help m4_standard:[M-4] standard}}{...}
{col 31}{...}
Functions to create standard matrices{...}

{col 11}{...}
{bf:{help m4_utility:[M-4] utility}}{...}
{col 31}{...}
Matrix utility functions{...}

{col 11}{...}
{bf:{help m4_manipulation:[M-4] manipulation}}{...}
{col 31}{...}
Matrix manipulation functions

{col 9}{...}
Stata interface{...}

{col 11}{...}
{bf:{help m4_stata:[M-4] stata}}{...}
{col 31}{...}
Stata interface functions

{col 9}{...}
String, I/O, and programming{...}

{col 11}{...}
{bf:{help m4_string:[M-4] string}}{...}
{col 31}{...}
String functions{...}

{col 11}{...}
{bf:{help m4_io:[M-4] io}}{...}
{col 31}{...}
I/O functions{...}

{col 11}{...}
{bf:{help m4_programming:[M-4] programming}}{...}
{col 31}{...}
Programming functions{...}

{col 9}{hline 61}

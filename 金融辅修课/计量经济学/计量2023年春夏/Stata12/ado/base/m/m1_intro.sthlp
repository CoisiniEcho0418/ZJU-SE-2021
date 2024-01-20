{smcl}
{* *! version 1.1.5  14apr2011}{...}
{vieweralsosee "[M-1] intro" "mansection M-1 intro"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-0] intro" "help mata"}{...}
{vieweralsosee "[D] putmata" "help putmata"}{...}
{viewerjumpto "Contents" "m1_intro##contents"}{...}
{viewerjumpto "Description" "m1_intro##description"}{...}
{viewerjumpto "Remarks" "m1_intro##remarks"}{...}
{viewerjumpto "Reference" "m1_intro##reference"}{...}
{title:Title}

{phang}
{manlink M-1 intro} {hline 2} Introduction and advice


{marker contents}{...}
{title:Contents}

{col 8}[M-1] entry{col 28}Description
{col 8}{hline 64}

{col 8}   {c TLC}{hline 23}{c TRC}
{col 8}{hline 3}{c RT}{it: Introductory material }{c LT}{hline}
{col 8}   {c BLC}{hline 23}{c BRC}

{col 8}{bf:{help m1_first:first}}{...}
{col 28}{bf:Introduction and first session}

{col 8}{bf:{help m1_interactive:interactive}}{...}
{col 28}{bf:Using Mata interactively}

{col 8}{bf:{help m1_ado:ado}}{...}
{col 28}{bf:Using Mata with ado-files}

{col 8}{bf:{help m1_help:help}}{...}
{col 28}{bf:Obtaining online help}

{col 8}   {c TLC}{hline 35}{c TRC}
{col 8}{hline 3}{c RT}{it: How Mata works & finding examples }{c LT}{hline}
{col 8}   {c BLC}{hline 35}{c BRC}

{col 8}{bf:{help m1_how:how}}{...}
{col 28}{bf:How Mata works}

{col 8}{bf:{help m1_source:source}}{...}
{col 28}{bf:Viewing the source code}

{col 8}   {c TLC}{hline 16}{c TRC}
{col 8}{hline 3}{c RT}{it: Special topics }{c LT}{hline}
{col 8}   {c BLC}{hline 16}{c BRC}

{col 8}{bf:{help m1_returnedargs:returnedargs}}{...}
{col 28}{bf:Function arguments used to return results}

{col 8}{bf:{help m1_naming:naming}}{...}
{col 28}{bf:Advice on naming functions and variables}

{col 8}{bf:{help m1_limits:limits}}{...}
{col 28}{bf:Limits and memory utilization}

{col 8}{bf:{help m1_tolerance:tolerance}}{...}
{col 28}{bf:Use and specification of tolerances}

{col 8}{bf:{help m1_permutation:permutation}}{...}
{col 28}{bf:An aside on permutation matrices and vectors}

{col 8}{bf:{help m1_lapack:LAPACK}}{...}
{col 28}{bf:The LAPACK linear-algebra routines}
{col 8}{hline 64}


{marker description}{...}
{title:Description}

{p 4 4 2}
This section provides an introduction to Mata along with reference 
material common to all sections.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
The most important entry in this section is
{bf:{help m1_first:[M-1] first}}.
Also see 
{bf:{help m6_glossary:[M-6] Glossary}}.

{p 4 4 2}
The Stata commands 
{cmd:putmata} and {cmd:getmata} are useful 
for moving data from Stata to Mata and back again; 
see 
{bf:{help putmata:[D] putmata}}.

{pstd}
Those looking for a textbook-like introduction to Mata may want to 
consider {help m1_intro##B2009:Baum (2009)}, particularly chapters 13 and 14.


{marker reference}{...}
{title:Reference}

{marker B2009}{...}
{phang}
Baum, C. F. 2009.
{browse "http://www.stata-press.com/books/isp.html":{it:An Introduction to Stata Programming}}.
College Station, TX: Stata Press.
{p_end}

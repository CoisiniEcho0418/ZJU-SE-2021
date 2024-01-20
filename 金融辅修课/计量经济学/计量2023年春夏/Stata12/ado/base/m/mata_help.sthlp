{smcl}
{* *! version 1.1.2  21apr2011}{...}
{vieweralsosee "[M-3] mata help" "mansection M-3 matahelp"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-1] help" "help m1_help"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] intro" "help m3_intro"}{...}
{viewerjumpto "Syntax" "mata_help##syntax"}{...}
{viewerjumpto "Description" "mata_help##description"}{...}
{viewerjumpto "Remarks" "mata_help##remarks"}{...}
{title:Title}

{phang}
{manlink M-3 mata help} {hline 2} Obtain online help


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
: {cmd:mata} {cmd:help} ...

{p 8 16 2}
: {cmd:help} ...


{p 4 4 2}
{cmd:help} need not be preceded by {cmd:mata}.


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:mata help} 
is Stata's {cmd:help} command.  Thus you do not have to exit Mata to 
use {cmd:help}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
See {bf:{help m1_help:[M-1] help}}.

{p 4 4 2}
You need not type the Mata prefix:

	: {cmd:mata help mata}
	  {it:(output appears in Stata's Viewer)}

	: {cmd:help mata}
	  {it:(same result)}

{p 4 4 2}
{cmd:help} can be used to obtain help for Mata or Stata:

	: {cmd:help mata missing()}

	: {cmd:help missing()}

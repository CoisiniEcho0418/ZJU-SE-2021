{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-3] end" "mansection M-3 end"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] intro" "help m3_intro"}{...}
{viewerjumpto "Syntax" "m3_end##syntax"}{...}
{viewerjumpto "Description" "m3_end##description"}{...}
{viewerjumpto "Remarks" "m3_end##remarks"}{...}
{title:Title}

{phang}
{manlink M-3 end} {hline 2} Exit Mata and return to Stata


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
	: {cmd:end}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:end} exits Mata and returns to Stata.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
When you exit from Mata back into Stata, Mata does not clear itself; so 
if you later return to Mata, you will be right back where you were.        
See {bf:{help m3_mata:[M-3] mata}}.
{p_end}

{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-2] continue" "mansection M-2 continue"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] break" "help m2_break"}{...}
{vieweralsosee "[M-2] do" "help m2_do"}{...}
{vieweralsosee "[M-2] for" "help m2_for"}{...}
{vieweralsosee "[M-2] while" "help m2_while"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] intro" "help m2_intro"}{...}
{viewerjumpto "Syntax" "m2_continue##syntax"}{...}
{viewerjumpto "Description" "m2_continue##description"}{...}
{viewerjumpto "Remarks" "m2_continue##remarks"}{...}
{title:Title}

{phang}
{manlink M-2 continue} {hline 2} Continue with next iteration of for, while, or do loop


{marker syntax}{...}
{title:Syntax}

	{cmd:for}, {cmd:while}, {it:or} {cmd:do {c -(}}
		...
		{cmd:if (}...{cmd:) {c -(}}
			...
			{cmd:continue}
		{cmd:{c )-}}
		...
	{cmd:{c )-}}
	...


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:continue} restarts the innermost {cmd:for}, {cmd:while}, or {cmd:do}
loop.  Execution continues just as if the loop had reached its logical end.

{p 4 4 2}
{cmd:continue} nearly always occurs following an {cmd:if}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
The following two code fragments are equivalent:

	{cmd}for (i=1; i<=rows(A); i++) {
		for (j=1; j<=cols(A); j++) {
			if (i==j) continue
			{txt}... action to be performed on A[i,j] ...{cmd}
		}
	}{txt}

{p 4 4 2}
and

	{cmd}for (i=1; i<=rows(A); i++) {
		for (j=1; j<=cols(A); j++) {
			if (i!=j) {
				{txt}... action to be performed on A[i,j] ...{cmd}
			}
		}
	}{txt}

{p 4 4 2}
{cmd:continue} operates on the innermost {cmd:for} or {cmd:while} 
loop, and even when the {cmd:continue} action is taken, standard 
end-of-loop processing takes place (which is {cmd:j++} here).
{p_end}

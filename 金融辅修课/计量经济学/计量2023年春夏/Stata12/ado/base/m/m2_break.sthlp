{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[M-2] break" "mansection M-2 break"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] continue" "help m2_continue"}{...}
{vieweralsosee "[M-2] do" "help m2_do"}{...}
{vieweralsosee "[M-2] for" "help m2_for"}{...}
{vieweralsosee "[M-2] while" "help m2_while"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] intro" "help m2_intro"}{...}
{viewerjumpto "Syntax" "m2_break##syntax"}{...}
{viewerjumpto "Description" "m2_break##description"}{...}
{viewerjumpto "Remarks" "m2_break##remarks"}{...}
{title:Title}

{phang}
{manlink M-2 break} {hline 2} Break out of for, while, or do loop


{marker syntax}{...}
{title:Syntax}

	{cmd:for}, {cmd:while}, {it:or} {cmd:do {c -(}}
		...
		{cmd:if (}...{cmd:) {c -(}}
			...
			{cmd:break}
		{cmd:{c )-}}
	{cmd:{c )-}}
	{it:stmt}                        <- {cmd:break} {it:jumps here}
	...


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:break} exits the innermost {cmd:for}, {cmd:while}, or {cmd:do} loop.
Execution continues with the statement immediately following the close of the
loop, just as if the loop had terminated normally.

{p 4 4 2}
{cmd:break} nearly always occurs following an {cmd:if}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
In the following code, 

	{cmd}for (i=1; i<=rows(A); i++) {
		for (j=1; j<=cols(A); j++) {
			{txt}...{cmd}
			if (A[i,j]==0) break
		}
		printf("j = %g\n", j)
	}{txt}

{p 4 4 2}
the {cmd:break} statement will be executed if any element of {cmd:A[i,j]} is
zero.  Assume that the statement is executed for {cmd:i}=2 and {cmd:j}=3.
Execution will continue with the {cmd:printf()} statement, which is to say,
the {cmd:j} loop will be canceled but the {cmd:i} loop will continue.
The value of {it:j} upon exiting the loop will be 3; when you break out 
of the loop, the {cmd:j++} is not executed.
{p_end}

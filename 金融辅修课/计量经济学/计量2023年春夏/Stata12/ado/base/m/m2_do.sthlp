{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-2] do" "mansection M-2 do"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] break" "help m2_break"}{...}
{vieweralsosee "[M-2] continue" "help m2_continue"}{...}
{vieweralsosee "[M-2] for" "help m2_for"}{...}
{vieweralsosee "[M-2] while" "help m2_while"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] intro" "help m2_intro"}{...}
{viewerjumpto "Syntax" "m2_do##syntax"}{...}
{viewerjumpto "Description" "m2_do##description"}{...}
{viewerjumpto "Remarks" "m2_do##remarks"}{...}
{title:Title}

{phang}
{manlink M-2 do} {hline 2} do ... while (exp)


{marker syntax}{...}
{title:Syntax}

	{cmd:do} {it:stmt} {cmd:while (}{it:exp}{cmd:)}


	{cmd:do} {cmd:{c -(}}
		{it:stmts}
	{cmd:{c )-} while (}{it:exp}{cmd:)}


{p 4 4 2}
where {it:exp} must evaluate to a real scalar.


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:do} executes {it:stmt} or {it:stmts} one or more times, until {it:exp} is
zero.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
One common use of {cmd:do} is to loop until convergence:


	{cmd}do {
		lasta = a
		a = get_new_a(lasta)
	} while (mreldif(a, lasta)>1e-10){txt}

{p 4 4 2}
The loop is executed at least once, and the conditioning 
expression is not executed until the loop's body has been executed.
{p_end}

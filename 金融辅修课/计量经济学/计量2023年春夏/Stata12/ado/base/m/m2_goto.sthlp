{smcl}
{* *! version 1.1.2  21apr2011}{...}
{vieweralsosee "[M-2] goto" "mansection M-2 goto"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] break" "help m2_break"}{...}
{vieweralsosee "[M-2] continue" "help m2_continue"}{...}
{vieweralsosee "[M-2] do" "help m2_do"}{...}
{vieweralsosee "[M-2] for" "help m2_for"}{...}
{vieweralsosee "[M-2] while" "help m2_while"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] intro" "help m2_intro"}{...}
{viewerjumpto "Syntax" "m2_goto##syntax"}{...}
{viewerjumpto "Description" "m2_goto##description"}{...}
{viewerjumpto "Remarks" "m2_goto##remarks"}{...}
{viewerjumpto "Reference" "m2_goto##reference"}{...}
{title:Title}

{phang}
{manlink M-2 goto} {hline 2} goto label


{marker syntax}{...}
{title:Syntax}

	{it:label}{cmd::}  ...
		...
		{cmd:goto} {it:label}
		 

{p 4 4 2}
where {it:label}{cmd::} may occur before or after the {cmd:goto}.


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:goto} {it:label} causes control to pass to the statement following
{it:label}{cmd::}.  {it:label} may be any name up to eight characters long.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
These days, good style is to avoid using {cmd:goto}.  

{p 4 4 2}
{cmd:goto} is useful when translating a FORTRAN program, such as


		{cmd}A = 4.0e0/3.0e0
	     10 B = A - 1.0e0
		C = B + B + B
		EPS = DABS(C - 1.0e0)
		if (EPS.EQ.0.0e0) GOTO 10{txt}

{p 4 4 2}
The Mata translation is 

		{cmd}a = 4/3
	s10:    b = a - 1
		c = b + b + b
		eps = abs(c-1)
		if (eps==0) goto s10{txt}

{p 4 4 2}
although

		{cmd}a = 4/3
		do {
			b = a - 1
			c = b + b + b
			eps = abs(c - 1)
		} while (eps==0){txt}

{p 4 4 2}
is more readable.
{p_end}


{marker reference}{...}
{title:Reference}

{phang}
Gould, W. W. 2005.
{browse "http://www.stata-journal.com/sjpdf.html?articlenum=pr0017":Mata Matters: Translating Fortran}.
{it:Stata Journal} 5: 421-441.
{p_end}

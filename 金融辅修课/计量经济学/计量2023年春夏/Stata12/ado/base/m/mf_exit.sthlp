{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] exit()" "mansection M-5 exit()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] error()" "help mf_error"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] programming" "help m4_programming"}{...}
{viewerjumpto "Syntax" "mf_exit##syntax"}{...}
{viewerjumpto "Description" "mf_exit##description"}{...}
{viewerjumpto "Remarks" "mf_exit##remarks"}{...}
{viewerjumpto "Conformability" "mf_exit##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_exit##diagnostics"}{...}
{viewerjumpto "Source code" "mf_exit##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 exit()} {hline 2} Terminate execution


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:exit(}{it:real scalar rc}{cmd:)}

{p 8 12 2}
{cmd:exit()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:exit(}{it:rc}{cmd:)} terminates execution and sets the overall 
return code to {it:rc}.

{p 4 4 2}
{cmd:exit()} with no argument specified is equivalent to {cmd:exit(0)}.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
Do not confuse {cmd:exit()} and {cmd:return}.  {cmd:return} stops 
execution of the current function and returns to the caller, whereupon 
execution continues.  {cmd:exit()} terminates execution.  
For instance, consider


	{cmd}function first()
	{
		"begin execution"
		second()
		"this message will never be seen"
	}

	function second()
	{
		"hello from second()"
		exit(0)
	}{txt}

{p 4 4 2}
The result of running this would be

	: {cmd:first}
	  begin execution
	  hello from second()

{p 4 4 2}
If we changed the {cmd:exit(0)} to be {cmd:exit(198)} in {cmd:second()}, the 
result would be 

	: {cmd:first}
	  begin execution
	  hello from second()
	r(198);

{p 4 4 2}
No error message is presented.  If you want to present an error
message and exit, you should code {cmd:exit(error(198))}; see 
{bf:{help mf_error:[M-5] error()}}.


{marker conformability}{...}
{title:Conformability}

    {cmd:exit(}{it:rc}{cmd:)}:
	       {it:rc}:  1 {it:x} 1    (optional)


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:exit(}{it:rc}{cmd:)} 
and 
{cmd:exit()} 
do not return.


{marker source}{...}
{title:Source code}

{p 4 4 2}
Functions are built in.
{p_end}

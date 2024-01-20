{smcl}
{* *! version 1.1.3  11feb2011}{...}
{vieweralsosee "[M-1] limits" "mansection M-1 limits"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-3] mata memory" "help mata_memory"}{...}
{vieweralsosee "[M-5] mindouble()" "help mf_mindouble"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-1] intro" "help m1_intro"}{...}
{viewerjumpto "Summary" "m1_limits##summary"}{...}
{viewerjumpto "Description" "m1_limits##description"}{...}
{viewerjumpto "Remarks" "m1_limits##remarks"}{...}
{title:Title}

{phang}
{manlink M-1 limits} {hline 2} Limits and memory utilization


{marker summary}{...}
{title:Summary}

    Limits:
	                              Minimum          Maximum
	{hline 54}
	Scalars, vectors, matrices
	    rows                         0       2,147,483,647
	    columns                      0       2,147,483,647

        String elements, length          0       2,147,483,647
	{hline 54}
	Stata's {cmd:matsize} plays no role in these limits.


    Size approximations:
				      Memory requirements
	{hline 66}
	real matrices                 {it:oh} + {it:r}*{it:c}*8 
        complex matrices              {it:oh} + {it:r}*{it:c}*16 
        pointer matrices              {it:oh} + {it:r}*{it:c}*8
	string matrices               {it:oh} + {it:r}*{it:c}*8 + {it:total_length_of_strings}
	{hline 66}
	where {it:r} and {it:c} represent the number of rows and columns and where
	{it:oh} is overhead and is approximately 64 bytes
       

{marker description}{...}
{title:Description}

{pstd}
Mata imposes limits, but those limits are of little importance 
compared with the memory requirements.  Mata stores matrices in memory and 
requests the memory for them from the operating system.


{marker remarks}{...}
{title:Remarks}

{pstd}
Mata requests (and returns) memory from the operating system as it needs it,
and if the operating system cannot provide it, Mata issues the following error:

	: {cmd:x = foo(A, B)}
	             {err}foo():  3900  unable to allocate{txt} ...
		   {err}<istmt>:     -  function returned error{txt}
	r(3900);

{pstd}
	
{pstd}
Stata's {cmd:matsize} (see {bf:{help matsize:[R] matsize}}) 
and 
Stata's {cmd:set min_memory} and {cmd:set max_memory} values 
(see {bf:{help memory:[D] memory}}) 
play no role in Mata or, at least, they play no direct role.  
{p_end}

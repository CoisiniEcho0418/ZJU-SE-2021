{smcl}
{* *! version 1.1.2  11feb2011}{...}
{vieweralsosee "[P] timer" "mansection P timer"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] timer()" "help mf_timer"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] profiler" "help profiler"}{...}
{vieweralsosee "[P] rmsg" "help rmsg"}{...}
{viewerjumpto "Syntax" "timer##syntax"}{...}
{viewerjumpto "Description" "timer##description"}{...}
{viewerjumpto "Remarks" "timer##remarks"}{...}
{viewerjumpto "Saved results" "timer##saved_results"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{manlink P timer} {hline 2}}Time sections of code by recording and reporting time spent
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{pstd}Reset timers to zero

	{cmd:timer} {cmd:clear} [{it:#}]


{pstd}Turn a timer on

	{cmd:timer} {cmd:on} {it:#}


{pstd}Turn a timer off

	{cmd:timer} {cmd:off} {it:#}


{pstd}List the timings

	{cmd:timer} {cmd:list} [{it:#}]


{phang}
where {it:#} is an integer, 1 through 100.


{marker description}{...}
{title:Description}

{pstd}
{cmd:timer} starts, stops, and reports up to 100 interval timers.
Results are reported in seconds.

{pstd}
{cmd:timer clear} resets timers to zero.

{pstd}
{cmd:timer on} begins a timing. {cmd:timer off} stops a timing. A timing 
may be turned on and off repeatedly without clearing, which causes the timer
to accumulate.

{pstd}
{cmd:timer list} lists the timings. If {it:#} is not specified, timers that
contain zero are not listed.


{marker remarks}{...}
{title:Remarks}

{pstd}{cmd:timer} can be used to time sections of code. For instance,

        {cmd:program tester}
          {cmd:        version} {it:...}
	  {cmd:        timer clear 1}
	  {cmd:        forvalues repeat=1(1)100 {c -(}}
	  {cmd:	              timer on 1}
	  {cmd:	              mycmd {it:...}}
	  {cmd:	              timer off 1}
	  {cmd:        {c )-}}
	  {cmd:        timer list 1}
	{cmd:end}


{marker saved_results}{...}
{title:Saved results}

{pstd}{cmd:timer list} saves the following in {cmd:r()}:
                                                                                
{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(t1)}}value of first timer{p_end}
{synopt:{cmd:r(nt1)}}{it:#} of times turned on and off{p_end}

{synopt:{cmd:r(t2)}}value of second timer{p_end}
{synopt:{cmd:r(nt2)}}{it:#} of times turned on and off{p_end}

{synopt:.}{p_end}
{synopt:.}{p_end}
{synopt:.}{p_end}

{synopt:{cmd:r(t100)}}value of 100th timer{p_end}
{synopt:{cmd:r(nt100)}}{it:#} of times turned on and off{p_end}
{p2colreset}{...}

{pstd}
Only values for which {cmd:r(nt}{it:#}{cmd:)}!=0 are saved.

{pstd}
{cmd:r()} results produced by other commands are not cleared.
{p_end}

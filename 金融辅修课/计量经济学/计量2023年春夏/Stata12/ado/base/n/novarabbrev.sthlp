{smcl}
{* *! version 1.0.3  11feb2011}{...}
{vieweralsosee "[P] varabbrev" "mansection P varabbrev"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "set varabbrev" "help set_varabbrev"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[P] break" "help break"}{...}
{vieweralsosee "[P] unab" "help unab"}{...}
{viewerjumpto "Syntax" "novarabbrev##syntax"}{...}
{viewerjumpto "Description" "novarabbrev##description"}{...}
{viewerjumpto "Example" "novarabbrev##example"}{...}
{title:Title}

{p2colset 5 22 24 2}{...}
{p2col :{manlink P varabbrev} {hline 2}}Control variable abbreviation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 25 2}{cmd:novarabbrev} {it:stata_command}

{p 8 25 2}{cmd:varabbrev}{bind:   }{it:stata_command}


    Typical usage is

	{cmd:novarabbrev {c -(}}
		{it:...}
	{cmd:{c )-}}


{marker description}{...}
{title:Description}

{pstd}
{cmd:novarabbrev} temporarily turns off variable abbreviation if it is on.
{cmd:varabbrev} temporarily turns on variable abbreviation if it is off.
Also see {helpb set varabbrev}.


{marker example}{...}
{title:Example}

    {cmd:program} {it:...}
            ... /* parse input */ ...
	    {cmd:novarabbrev {c -(}}
                    ... /* perform task */ ... 
	    {cmd:{c )-}}
            ...
    {cmd:end}

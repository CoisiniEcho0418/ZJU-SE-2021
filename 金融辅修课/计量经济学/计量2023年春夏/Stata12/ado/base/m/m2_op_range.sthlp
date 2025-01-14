{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-2] op_range" "mansection M-2 op_range"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] exp" "help m2_exp"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-2] intro" "help m2_intro"}{...}
{viewerjumpto "Syntax" "m2_op_range##syntax"}{...}
{viewerjumpto "Description" "m2_op_range##description"}{...}
{viewerjumpto "Remarks" "m2_op_range##remarks"}{...}
{viewerjumpto "Conformability" "m2_op_range##conformability"}{...}
{viewerjumpto "Diagnostics" "m2_op_range##diagnostics"}{...}
{title:Title}

{phang}
{manlink M-2 op_range} {hline 2} Range operators


{marker syntax}{...}
{title:Syntax}

	{it:a} {cmd:..} {it:b}                  row range 

	{it:a} {cmd:::} {it:b}                  column range


{marker description}{...}
{title:Description}

{p 4 4 2}
The range operators create vectors that count from {it:a} to {it:b}.

{p 4 4 2}
{it:a}{cmd:..}{it:b} returns a row vector.

{p 4 4 2}
{it:a}{cmd:::}{it:b} returns a column vector.


{marker remarks}{...}
{title:Remarks}

{p 4 4 2}
{it:a}{cmd:..}{it:b} and 
{it:a}{cmd:::}{it:b}
count from {it:a} up to but not exceeding {it:b}, incrementing by 
1 if {it:b}>={it:a} and by -1 if {it:b}<{it:a}.

{p 4 4 2}
{cmd:1..4} creates row vector (1,2,3,4).{break}
{cmd:1::4} creates column vector (1\2\3\4).

{p 4 4 2}
{cmd:-1..-4} creates row vector (-1,-2,-3,-4).{break}
{cmd:-1::-4} creates column vector (-1\-2\-3\-4).

{p 4 4 2}
{cmd:1.5..4.5} creates row vector (1.5, 2.5, 3.5, 4.5).{break}
{cmd:1.5::4.5} creates column vector (1.5\ 2.5\ 3.5\ 4.5).

{p 4 4 2}
{cmd:1.5..4.4} creates row vector (1.5, 2.5, 3.5).{break}
{cmd:1.5::4.4} creates column vector (1.5\ 2.5\ 3.5).

{p 4 4 2}
{cmd:-1.5..-4.4} creates row vector (-1.5, -2.5, -3.5).{break}
{cmd:-1.5::-4.4} creates column vector (-1.5\ -2.5\ -3.5).

{p 4 4 2}
{cmd:1..1} and {cmd:1::1} both return (1).


{marker conformability}{...}
{title:Conformability}

    {it:a}{cmd:..}{it:b}
	{it:a}:  1 {it:x} 1
	{it:b}:  1 {it:x} 1
   {it:result}:  1 {it:x} trunc(abs({it:b}-{it:a}))+1

    {it:a}{cmd:::}{it:b}
	{it:a}:  1 {it:x} 1
	{it:b}:  1 {it:x} 1
   {it:result}:  trunc(abs({it:b}-{it:a}))+1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{it:a}{cmd:..}{it:b} and {it:a}{cmd:::}{it:b} return missing if
{it:a}>={cmd:.} or {it:b}>={cmd:.}
{p_end}

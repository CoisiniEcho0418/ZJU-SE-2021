{smcl}
{* *! version 1.1.1  11feb2011}{...}
{vieweralsosee "[M-5] uniqrows()" "mansection M-5 uniqrows()"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-5] sort()" "help mf_sort"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[M-4] manipulation" "help m4_manipulation"}{...}
{viewerjumpto "Syntax" "mf_uniqrows##syntax"}{...}
{viewerjumpto "Description" "mf_uniqrows##description"}{...}
{viewerjumpto "Remarks" "mf_uniqrows##remarks"}{...}
{viewerjumpto "Conformability" "mf_uniqrows##conformability"}{...}
{viewerjumpto "Diagnostics" "mf_uniqrows##diagnostics"}{...}
{viewerjumpto "Source code" "mf_uniqrows##source"}{...}
{title:Title}

{p 4 8 2}
{manlink M-5 uniqrows()} {hline 2} Obtain sorted, unique values


{marker syntax}{...}
{title:Syntax}

{p 8 8 2}
{it:transmorphic matrix}
{cmd:uniqrows(}{it:transmorphic matrix P}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:uniqrows(}{it:P}{cmd:)} 
returns a sorted matrix containing the unique rows of {it:P}.


{marker remarks}{...}
{title:Remarks}

	: {cmd:x}
	{res}       {txt}1   2   3
	    {c TLC}{hline 13}{c TRC}
	  1 {c |}  {res}4   5   7{txt}  {c |}
	  2 {c |}  {res}4   5   6{txt}  {c |}
	  3 {c |}  {res}1   2   3{txt}  {c |}
	  4 {c |}  {res}4   5   6{txt}  {c |}
	    {c BLC}{hline 13}{c BRC}

	: {cmd:uniqrows(x)}
	{res}       {txt}1   2   3
	    {c TLC}{hline 13}{c TRC}
	  1 {c |}  {res}1   2   3{txt}  {c |}
	  2 {c |}  {res}4   5   6{txt}  {c |}
	  3 {c |}  {res}4   5   7{txt}  {c |}
	    {c BLC}{hline 13}{c BRC}


{marker conformability}{...}
{title:Conformability}

    {cmd:uniqrows(}{it:P}{it:)}
		{it:P}:  {it:r1 x c1}
	   {it:result}:  {it:r2 x c1}, {it:r2} <= {it:r1}


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
In {cmd:uniqrows(}{it:P}{it:)}, 
if {cmd:rows(}{it:P}{cmd:)==0}, 
{cmd:J(0, cols(}{it:P}{cmd:), missingof(}{it:P}{cmd:))} is returned.

{p 4 4 2}
If {cmd:rows(}{it:P}{cmd:)}>0 and {cmd:cols(}{it:P}{cmd:)==0}, 
{cmd:J(1, 0, missingof(}{it:P}{cmd:))} is returned.


{marker source}{...}
{title:Source code}

{p 4 4 2}
{view uniqrows.mata, adopath asis:uniqrows.mata}
{p_end}

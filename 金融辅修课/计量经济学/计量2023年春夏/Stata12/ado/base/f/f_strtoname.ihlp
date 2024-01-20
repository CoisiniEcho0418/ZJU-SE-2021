{* *! version 1.0.1  05feb2009}{...}
    {cmd:strtoname(}{it:s}{cmd:,}{it:p}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s}:}strings{p_end}
{p2col: Domain {it:p}:}0 or 1{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns {it:s} translated into a Stata name.  Each
	character in {it:s} that is not allowed in a Stata name is converted
	to an underscore character, {cmd:_}.
	If the first character in {it:s} is a numeric character and {it:p} is
	not 0, then the result is prefixed with an underscore.
	The result is truncated to {ccl namelen} characters.

{p2col 8 26 26 2:}{cmd:strtoname("name",1)} = {cmd:"name"}{break}
                  {cmd:strtoname("a name",1)} = {cmd:"a_name"}{break}
		  {cmd:strtoname("5",1)} = {cmd:"_5"}{break}
		  {cmd:strtoname("5:30",1)} = {cmd:"_5_30"}{break}
		  {cmd:strtoname("5",0)} = {cmd:"5"}{break}
		  {cmd:strtoname("5:30",0)} = {cmd:"5_30"}{break}

    {cmd:strtoname(}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s}:}strings{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns {it:s} translated into a Stata name.  Each
	character in {it:s} that is not allowed in a Stata name is converted
	to an underscore character, {cmd:_}.
	If the first character in {it:s} is a numeric character, then the
	result is prefixed with an underscore.
	The result is truncated to {ccl namelen} characters.

{p2col 8 26 26 2:}{cmd:strtoname("name")} = {cmd:"name"}{break}
                  {cmd:strtoname("a name")} = {cmd:"a_name"}{break}
		  {cmd:strtoname("5")} = {cmd:"_5"}{break}
		  {cmd:strtoname("5:30")} = {cmd:"_5_30"}{break}
{p2colreset}{...}

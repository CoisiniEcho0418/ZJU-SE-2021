{* *! version 1.0.2  02jun2011}{...}
    {cmd:regexm(}{it:s}{cmd:,}{it:re}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s}:}strings{p_end}
{p2col: Domain {it:re}:}regular expression{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}performs a match of a regular 
	expression and evaluates to {cmd:1} if regular expression {it:re} is
	satisfied by the string {it:s}, otherwise returns {cmd:0}.  Regular
	expression syntax is based on Henry Spencer's NFA algorithm, and 
	this is nearly identical to the POSIX.2 standard.{p_end}
{p2colreset}{...}

    {cmd:regexr(}{it:s1}{cmd:,}{it:re}{cmd:,}{it:s2}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:s1}:}strings{p_end}
{p2col: Domain {it:re}:}regular expression{p_end}
{p2col: Domain {it:s2}:}strings{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}replaces the first
	substring within {it:s1} that matches {it:re} with {it:s2} and
	returns the resulting string.  If {it:s1} contains no substring that
	matches {it:re}, the unaltered {it:s1} is returned.{p_end}
{p2colreset}{...}

    {cmd:regexs(}{it:n}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}0 to 9{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns subexpression {it:n} from a previous 
	{cmd:regexm()} match, where {bind:0 {ul:<} {it:n} < 10}.
	Subexpression 0 is reserved for the entire string that satisfied the
	regular expression.{p_end}
{p2colreset}{...}

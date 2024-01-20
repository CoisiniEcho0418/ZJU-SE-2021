{* *! version 1.0.4  30apr2009}{...}
    {cmd:soundex_nara(}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}strings{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns the U.S. Census soundex code for a string, {it:s}.
The soundex code
consists of a letter followed by three numbers: the letter is the first
letter of the name and the numbers encode the remaining consonants.
Similar sounding consonants are encoded by the same number.{break}
			{cmd:soundex_nara("Ashcraft")} = {cmd:"A261"}{p_end} 
{p2colreset}{...}

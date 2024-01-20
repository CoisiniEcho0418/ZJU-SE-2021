{* *! version 1.0.4  30apr2009}{...}
    {cmd:soundex(}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}strings{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns the soundex code for a string, {it:s}.
The soundex code consists of
a letter followed by three numbers: the letter is the first letter of the
name and the numbers encode the remaining consonants. Similar sounding
consonants are encoded by the same number.{break}
		{cmd:soundex("Ashcraft")} = {cmd:"A226"}{break}
                {cmd:soundex("Robert")} = {cmd:"R163"}{break}
                {cmd:soundex("Rupert")} = {cmd:"R163"}{p_end}
{p2colreset}{...}

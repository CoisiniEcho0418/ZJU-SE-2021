{* *! version 1.0.2  11may2007}{...}
    {cmd:proper(}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}strings{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns a string with the first letter capitalized,
	and capitalizes any other letters immediately following characters
	that are not letters; all other letters converted to lowercase.
	{break}
	{cmd:proper("mR. joHn a. sMitH")} = {cmd:"Mr. John A. Smith"}
	{break}
	{cmd:proper("jack o'reilly")} = {cmd:"Jack O'Reilly"}{break}
	{cmd:proper("2-cent's worth")} = {cmd:"2-Cent'S Worth"}{p_end}
{p2colreset}{...}

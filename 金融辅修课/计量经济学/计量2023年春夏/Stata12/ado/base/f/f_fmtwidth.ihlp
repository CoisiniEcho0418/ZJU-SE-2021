{* *! version 1.0.2  30apr2009}{...}
    {cmd:fmtwidth(}{it:fmtstr}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns the output length of the 
    {cmd:%}{it:fmt} contained in {it:fmtstr}.{p_end}
{p2col: }returns {it:missing} if {it:fmtstr} does not contain a valid
    {cmd:%}{it:fmt}.  For example, {cmd:fmtwidth("%9.2f")} returns {cmd:9} and 
    {cmd:fmtwidth("%tc")} returns {cmd:18}.{p_end}
{p2colreset}{...}

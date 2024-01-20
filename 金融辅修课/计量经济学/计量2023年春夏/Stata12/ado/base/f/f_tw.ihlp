{* *! version 1.0.1  02jun2011}{...}
    {cmd:tw(}{it:l}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:l}:}week literal strings 0100w1 to 9999w52{p_end}
{p2col: Range:}{cmd:%tw} dates 0100w1 to 9999w52
                    (integers -96,720 to 418,079){p_end}
{p2col: Description:}convenience function to make typing weekly dates in
               expressions easier; for example, typing {cmd:tw(1960w2)} is
               equivalent to typing {cmd:1}.{p_end}
{p2colreset}{...}

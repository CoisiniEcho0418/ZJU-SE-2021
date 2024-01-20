{* *! version 1.0.1  16mar2007}{...}
    {cmd:string(}{it:n}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns {it:n} converted to a string:{break}
                     {cmd:string(4)+"F"} = {cmd:"4F"}{break}
		     {cmd:string(1234567)} = {cmd:"1234567"}{break}
		     {cmd:string(12345678)} = {cmd:"1.23e+07"}{break}
		     {cmd:string(.)} = {cmd:"."}{p_end}
{p2colreset}{...}

    {cmd:string(}{it:n}{cmd:,}{it:s}{cmd:)}
{p2colset 8 22 26 2}{...}
{p2col: Domain {it:n}:}-8e+307 to 8e+307 and {it:missing}{p_end}
{p2col: Domain {it:s}:}strings containing {cmd:%}{it:fmt} numeric display
                       format{p_end}
{p2col: Range:}strings{p_end}
{p2col: Description:}returns {it:n} converted to a string:{break}
                     {cmd:string(4,"%9.2f")} = {cmd:"4.00"}{break}
		     {cmd:string(123456789,"%11.0g")} = 
		           {cmd:"123456789"}{break}
                     {cmd:string(123456789,"%13.0gc"} =
		           {cmd:"123,456,789"}{break}
                     {cmd:string(0,"%td")} = {cmd:"01jan1960"}{break}
		     {cmd:string(225,"%tq")} = {cmd:"2016q2"}{break}
		     {cmd:string(225,"not a format")} = {cmd:""}{p_end}
{p2colreset}{...}

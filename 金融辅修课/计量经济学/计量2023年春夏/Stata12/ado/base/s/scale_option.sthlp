{smcl}
{* *! version 1.1.6  06jun2011}{...}
{vieweralsosee "[G-3] scale_option" "mansection G-3 scale_option"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph" "help graph"}{...}
{viewerjumpto "Syntax" "scale_option##syntax"}{...}
{viewerjumpto "Description" "scale_option##description"}{...}
{viewerjumpto "Option" "scale_option##option"}{...}
{viewerjumpto "Remarks" "scale_option##remarks"}{...}
{title:Title}

{p2colset 5 27 29 2}{...}
{p2col :{manlinki G-3 scale_option} {hline 2}}Option for resizing text, markers, and line widths{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 20}{...}
{p2col:{it:scale_option}}Description{p_end}
{p2line}
{p2col:{cmd:scale(}{it:#}{cmd:)}}specify scale; default is {cmd:scale(1)}{p_end}
{p2line}
{p2colreset}{...}
{p 4 6 2}{cmd:scale()} is {it:unique}; see {help repeated options}.


{marker description}{...}
{title:Description}

{pstd}
Option {cmd:scale()} makes all the text, markers, and line widths on a graph
larger or smaller.


{marker option}{...}
{title:Option}

{phang}
{cmd:scale(}{it:#}{cmd:)}
    specifies a multiplier that affects the size of all text, markers, and
    line widths on a graph.  {cmd:scale(1)} is the default.

{pmore}
    To increase the size of all text, markers, and line widths on a graph by
    20%, specify {cmd:scale(1.2)}.  To reduce the size of all text, markers,
    and line widths on a graph by 20%, specify {cmd:scale(.8)}.


{marker remarks}{...}
{title:Remarks}

{pstd}
Under {it:{help marker_label_options##remarks3:Advanced use}} in
{manhelpi marker_label_options G-3}, we showed the following graph,

	{cmd}. twoway (scatter lexp gnppc, mlabel(country) mlabv(pos))
		 (line hat gnppc, sort)
		 , xsca(log) xlabel(.5 5 10 15 20 25 30, grid)
		   legend(off)
		   title("Life expectancy vs. GNP per capita")
		   subtitle("North, Central, and South America")
		   note("Data source:  World Bank, 1998")
		   ytitle("Life expectancy at birth (years)"){txt}
	  {it:({stata "gr_example2 markerlabel3":click to run})}{txt}
{* graph markerlabel3}{...}

{pstd}
Here is the same graph with the size of all text, markers, and line widths
increased by 10%:

	{cmd}. twoway (scatter lexp gnppc, mlabel(country) mlabv(pos))
		 (line hat gnppc, sort)
		 , xsca(log) xlabel(.5 5 10 15 20 25 30, grid)
		   legend(off)
		   title("Life expectancy vs. GNP per capita")
		   subtitle("North, Central, and South America")
		   note("Data source:  World Bank, 1998")
		   ytitle("Life expectancy at birth (years)")
		   scale(1.1){txt}{right:<-- {it:new}  }
	  {it:({stata "gr_example2 markerlabel4":click to run})}{txt}
{* graph markerlabel4}{...}

{pstd}
All we did was add the option {cmd:scale(1.1)} to the original command.
{p_end}

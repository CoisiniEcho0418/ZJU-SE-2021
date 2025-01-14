{smcl}
{* *! version 1.1.4  11feb2011}{...}
{vieweralsosee "[G-3] tif_options" "mansection G-3 tif_options"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-2] graph export" "help graph_export"}{...}
{viewerjumpto "Syntax" "tif_options##syntax"}{...}
{viewerjumpto "Description" "tif_options##description"}{...}
{viewerjumpto "Options" "tif_options##options"}{...}
{viewerjumpto "Remarks" "tif_options##remarks"}{...}
{title:Title}

{p2colset 5 26 28 2}{...}
{p2col :{manlinki G-3 tif_options} {hline 2}}Options for exporting to tagged
image file format (TIFF){p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 20}{...}
{p2col:{it:tif_options}}Description{p_end}
{p2line}
{p2col:{cmdab:wid:th:(}{it:#}{cmd:)}}width of graph in pixels{p_end}
{p2col:{cmdab:hei:ght:(}{it:#}{cmd:)}}height of graph in pixels{p_end}
{p2line}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
The {it:tif_options} are used with {cmd:graph} {cmd:export} when creating
TIFF graphs; see {manhelp graph_export G-2:graph export}.


{marker options}{...}
{title:Options}

{phang}
{cmd:width(}{it:#}{cmd:)}
    specifies the width of the graph in pixels.  {cmd:width()} must
    contain an integer between 8 and 16,000.

{phang}
{cmd:height(}{it:#}{cmd:)}
    specifies the height of the graph in pixels.  {cmd:height()} must
    contain an integer between 8 and 16,000.


{marker remarks}{...}
{title:Remarks}

{pstd}
Remarks are presented under the following headings:

	{help tif_options##remarks1:Using tif_options}
	{help tif_options##remarks2:Specifying the width or height}


{marker remarks1}{...}
{title:Using tif_options}

{pstd}
You have drawn a graph and wish to create a TIFF file to include in a
document.  You wish, however, to set the width of the graph to 800 pixels and
the height to 600 pixels:

	{cmd:. graph} ...{col 50}(draw a graph)

{phang2}
	{cmd:. graph export myfile.tif, width(800) height(600)}


{marker remarks2}{...}
{title:Specifying the width or height}

{pstd}
If the width is specified but not the height, Stata determines the appropriate
height from the graph's aspect ratio.  If the height is specified but
not the width, Stata determines the appropriate width from the graph's aspect
ratio.  If neither the width nor the height is specified, Stata
will export the graph on the basis of the current size of the Graph window.
{p_end}

{smcl}
{* *! version 1.1.6  10jun2011}{...}
{vieweralsosee "[G-4] colorstyle" "mansection G-4 colorstyle"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[G-4] schemes intro" "help schemes"}{...}
{viewerjumpto "Syntax" "colorstyle##syntax"}{...}
{viewerjumpto "Description" "colorstyle##description"}{...}
{viewerjumpto "Remarks" "colorstyle##remarks"}{...}
{title:Title}

{p2colset 5 25 27 2}{...}
{p2col :{manlinki G-4 colorstyle} {hline 2}}Choices for color{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{synoptset 20}{...}
{p2col:{it:colorstyle}}Description{p_end}
{p2line}
{p2col:{cmd:black}}{p_end}
{p2col:{cmd:gs0}}gray scale:  0 = {cmd:black}{p_end}
{p2col:{cmd:gs1}}gray scale:  very dark gray{p_end}
{p2col:{cmd:gs2}}{p_end}
{p2col:.}{p_end}
{p2col:.}{p_end}
{p2col:{cmd:gs15}}gray scale:  very light gray{p_end}
{p2col:{cmd:gs16}}gray scale:  16 = {cmd:white}{p_end}
{p2col:{cmd:white}}{p_end}

{p2col:{cmd:blue}}{p_end}
{p2col:{cmd:bluishgray}}{p_end}
{p2col:{cmd:brown}}{p_end}
{p2col:{cmd:cranberry}}{p_end}
{p2col:{cmd:cyan}}{p_end}
{p2col:{cmd:dimgray}}between {cmd:gs14} and {cmd:gs15}{p_end}
{p2col:{cmd:dkgreen}}dark green{p_end}
{p2col:{cmd:dknavy}}dark navy blue{p_end}
{p2col:{cmd:dkorange}}dark orange{p_end}
{p2col:{cmd:eggshell}}{p_end}
{p2col:{cmd:emerald}}{p_end}
{p2col:{cmd:forest_green}}{p_end}
{p2col:{cmd:gold}}{p_end}
{p2col:{cmd:gray}}equivalent to {cmd:gs8}{p_end}
{p2col:{cmd:green}}{p_end}
{p2col:{cmd:khaki}}{p_end}
{p2col:{cmd:lavender}}{p_end}
{p2col:{cmd:lime}}{p_end}
{p2col:{cmd:ltblue}}light blue{p_end}
{p2col:{cmd:ltbluishgray}}light blue-gray, used by scheme {cmd:s2color}{p_end}
{p2col:{cmd:ltkhaki}}light khaki{p_end}
{p2col:{cmd:magenta}}{p_end}
{p2col:{cmd:maroon}}{p_end}
{p2col:{cmd:midblue}}{p_end}
{p2col:{cmd:midgreen}}{p_end}
{p2col:{cmd:mint}}{p_end}
{p2col:{cmd:navy}}{p_end}
{p2col:{cmd:olive}}{p_end}
{p2col:{cmd:olive_teal}}{p_end}
{p2col:{cmd:orange}}{p_end}
{p2col:{cmd:orange_red}}{p_end}
{p2col:{cmd:pink}}{p_end}
{p2col:{cmd:purple}}{p_end}
{p2col:{cmd:red}}{p_end}
{p2col:{cmd:sand}}{p_end}
{p2col:{cmd:sandb}}bright sand{p_end}
{p2col:{cmd:sienna}}{p_end}
{p2col:{cmd:stone}}{p_end}
{p2col:{cmd:teal}}{p_end}
{p2col:{cmd:yellow}}{p_end}

{p2col:}colors used by {it:The Economist} magazine:{p_end}
{p2col 5 35 37 2:{cmd:ebg}}background color{p_end}
{p2col 5 35 37 2:{cmd:ebblue}}bright blue{p_end}
{p2col 5 35 37 2:{cmd:edkblue}}dark blue{p_end}
{p2col 5 35 37 2:{cmd:eltblue}}light blue{p_end}
{p2col 5 35 37 2:{cmd:eltgreen}}light green{p_end}
{p2col 5 35 37 2:{cmd:emidblue}}midblue{p_end}
{p2col 5 35 37 2:{cmd:erose}}rose{p_end}

{p2col:{cmd:none}}no color; invisible; draws nothing{p_end}
{p2col:{cmd:background} or {cmd:bg}}same color as background{p_end}
{p2col:{cmd:foreground} or {cmd:fg}}same color as foreground{p_end}

{p2col:{it:# # #}}RGB value; {cmd:white} = {cmd:"255 255 255"}{p_end}

{p2col:{it:# # # #}}CMYK value; {cmd:yellow} = {cmd:"0 0 255 0"}{p_end}

{p2col:{cmd:hsv} {it:# # #}}HSV value; {cmd:white} = {cmd:"hsv 255 255 255"}{p_end}

{p2col:{it:color}{cmd:*}{it:#}}color with adjusted intensity{p_end}

{p2col:{cmd:*}{it:#}}default color with adjusted intensity{p_end}
{p2line}
{p2colreset}{...}
{p 4 6 2}
When specifying RGB, CMYK, or HSV values, it is best to enclose the values in
quotes; type {cmd:"128} {cmd:128} {cmd:128"} not {cmd:128} {cmd:128}
{cmd:128}.

{pstd}
For a color palette showing an individual color, type

	{cmd:. palette color} {it:colorstyle} {...}
[{cmd:,} {cmdab:sch:eme:(}{it:schemename}{cmd:)}]

{pstd}
and for a palette comparing two colors, type

	{cmd:. palette color} {it:colorstyle} {it:colorstyle}{...}
[{cmd:,} {cmdab:sch:eme:(}{it:schemename}{cmd:)}]

{pstd}
For instance, you might type

	{cmd:.} {bf:{stata palette color red green}}

{pstd}
See {manhelp palette G-2}.

{pstd}
Wherever a {it:colorstyle} appears, you may specify an RGB value by
specifying three numbers in sequence.  Each number should be between 0 and
255, and the triplet indicates the amount of red, green, and blue to be mixed.
Each of the {it:colorstyle}s in the table above is equivalent to an RGB value.

{pstd}
You can also specify a CMYK value wherever {it:colorstyle} appears, but the
four numbers representing a CMYK value must be enclosed in quotes, for example,
{cmd:"100 0 22 50"}.

{pstd}
You can also specify an HSV (hue, saturation, and value) color wherever
{it:colorstyle} appears.  HSV colors measure hue on a circular 360-degree
scale with saturation and hue as proportions between 0 and 1.  You must prefix
HSV colors with {cmd:hsv} and enclose the full HSV specification in quotes,
for example, {cmd:"hsv 180 .5 .5"}.

{pstd}
Other {it:colorstyles} may be available; type

{p 8 8 2}
{cmd:.} {bf:{stata graph query colorstyle}}

{pstd}
to obtain the complete list of {it:colorstyles} installed on your computer.


{marker description}{...}
{title:Description}

{pstd}
{it:colorstyle} specifies the color of a graphical component.  You can specify
{it:colorstyle} with many different {cmd:graph} options; all have the form

	    <{it:object}>{cmd:color(}{it:colorstyle}{cmd:)}

{pstd}
or

	    {cmd:color(}{it:colorstyle}{cmd:)}

{pstd}
For instance, option {cmd:mcolor()} specifies the color of markers, option
{cmd:lcolor()} specifies the colors of connecting lines, and option
{cmd:fcolor()} specifies the colors of the fill area. Option {cmd:color()}
is equivalent to specifying all three of these options. Anywhere you see
{it:colorstyle}, you can choose from the list above.

{pstd}
You will sometimes see that a {it:colorstylelist} is allowed, as in

	    {cmd:. scatter} ...{cmd:, msymbol(}{it:colorstylelist}{cmd:)} ...

{pstd}
A {it:colorstylelist} is a sequence of {it:colorstyles} separated by spaces.
Shorthands are allowed to make specifying the list easier; see
{manhelpi stylelists G-4}.  When specifying RGB, CMYK, or HSV values in
{it:colorstylelists}, remember to enclose the numbers in quotes.


{marker remarks}{...}
{title:Remarks}

{pstd}
Remarks are presented under the following headings:

	{help colorstyle##remarks1:Colors are independent of the background color}
	{help colorstyle##remarks2:White backgrounds and black backgrounds}
	{help colorstyle##remarks3:RGB values}
	{help colorstyle##remarks4:CMYK values}
	{help colorstyle##hsv:HSV values}
	{help colorstyle##remarks5:Adjusting intensity}


{marker remarks1}{...}
{title:Colors are independent of the background color}

{pstd}
Except for the colors {cmd:background} and {cmd:foreground}, colors
do not change because of the background color.  Colors {cmd:background} and
{cmd:foreground} obviously do change, but otherwise, black means black, red
means red, white means white, and so on.  White on a black background has high
visibility; white on a white background is invisible.  Inversely, black on a
white background has high visibility; black on a black background is
invisible.

{pstd}
Color {cmd:foreground} always has high visibility.

{pstd}
Color {cmd:background} is the background color.  If you draw something in this
color, you will erase whatever is underneath it.

{pstd}
Color {cmd:none} is no color at all.  If you draw something in this color,
whatever you draw will be invisible.  Being invisible, it will not hide
whatever is underneath it.


{marker remarks2}{...}
{title:White backgrounds and black backgrounds}

{pstd}
The colors do not change because of the background color, but the colors
that look best depend on the background color.

{pstd}
Graphs on the screen look best against a black background.  With a black
background, light colors stand out, and dark colors blend into the
background.

{pstd}
Graphs on paper are usually presented against a white background.
Dark colors stand out and light colors blend into the background.

{pstd}
Because most users need to make printed copies of their graphs, Stata's
default is to present graphs on a white background, but you can change
that; see {manhelp schemes G-4:schemes intro}.

{pstd}
If you want a dark background, it is better to choose a dark background rather
than attempt to darken the background by using the {it:region_option}
{cmd:graphregion(fcolor())} (see {manhelpi region_options G-3}); everything else
about the graph's scheme will assume a background similar to how it was
originally.

{pstd}
{cmd:graphregion(fcolor())}
(and {cmd:graphregion(ifcolor())}, {cmd:plotregion(fcolor())}, and
{cmd:plotregion(ifcolor())}) are best used for adding a little tint to the
background.


{marker remarks3}{...}
{title:RGB values}

{pstd}
In addition to colors such as {cmd:red}, {cmd:green}, {cmd:blue},
or {cmd:cyan}, you can mix your own colors by specifying RGB values.  An
RGB value is a triplet of numbers, each of which specifies, on a scale of
0--255, the amount of red, green, and blue to be mixed.  That is,

	{cmd:red}     =   {cmd:255    0    0}
	{cmd:green}   =   {cmd:  0  255    0}
	{cmd:blue}    =   {cmd:  0    0  255}

	{cmd:cyan}    =   {cmd:  0  255  255}
	{cmd:magenta} =   {cmd:255    0  255}
	{cmd:yellow}  =   {cmd:255  255    0}
	{cmd:white}   =   {cmd:255  255  255}
	{cmd:black}   =   {cmd:  0    0    0}

{pstd}
The overall scale of the triplet affects intensity; thus, changing 255 to
128 in all of the above would keep the colors the same but make them dimmer.
(Color {cmd:128} {cmd:128} {cmd:128} is what most people call gray.)


{marker remarks4}{...}
{title:CMYK values}

{pstd}
In addition to mixing your own colors by using RGB values, you can mix your own
colors by using CMYK values.  If you have not heard of CMYK values or been
asked to produce CMYK color separations, you can safely skip this section.
CMYK is provided primarily to assist those doing color separations for mass
printings.  Although most inkjet printers use the more common RGB color values,
printing presses almost always require CMYK values for color separation.

{pstd}
RGB values represent a mixing of red, green, and blue light, whereas CMYK
values represent a mixing of pigments -- cyan, magenta, yellow, and black.
Thus, as the numbers get bigger, RGB colors go from dark to bright, whereas 
the CMYK colors go from light to dark.

{pstd}
CMYK values can be specified either as integers from 0 to 255, or as
proportions of ink using real numbers from 0.0 to 1.0.  If all four values are 1
or less, the numbers are taken to be proportions of ink.  Thus,
{cmd:127 0 127 0} and {cmd:0.5 0 0.5 0} specify almost equivalent colors.

{pstd}
Some examples of CMYK colors are

	{cmd:red}     =   {cmd:  0  255  255    0}   or, equivalently,  {cmd: 0 1 1 0}
	{cmd:green}   =   {cmd:255    0  255    0}   or, equivalently,  {cmd: 1 0 1 0}
	{cmd:blue}    =   {cmd:255  255    0    0}   or, equivalently,  {cmd: 1 1 0 0}

	{cmd:cyan}    =   {cmd:255    0    0    0}   or, equivalently,  {cmd: 1 0 0 0}
	{cmd:magenta} =   {cmd:  0  255    0    0}   or, equivalently,  {cmd: 0 1 0 0}
	{cmd:yellow}  =   {cmd:  0    0  255    0}   or, equivalently,  {cmd: 0 0 1 0}
	{cmd:white}   =   {cmd:  0    0    0    0}   or, equivalently,  {cmd: 0 0 0 0}
	{cmd:black}   =   {cmd:  0    0    0  255}   or, equivalently,  {cmd: 0 0 0 1}

{pstd}
For color representation, there is no reason for the K (black) component of
the CMYK values, {cmd: 255 255 255 0} and {cmd:0 0 0 255} both specify the
color black.  With pigments such as printer inks, however, using 100% of cyan,
magenta, and yellow rarely produces a pure black.  For that reason, CMYK
values include a specific black component.

{pstd}
Internally, Stata stores all colors as RGB values, even when CMYK values are
specified.  This allows colors to be easily shown on most display devices.  In
fact, {cmd:graph export} will produce graph files using RGB values, even when
CMYK values were specified as input.  Only a few devices and graphics formats
understand CMYK colors, with PostScript and EPS formats being two of the most
important.  To obtain CMYK colors in these formats, use the {cmd:cmyk(on)}
option of the {cmd:graph export} command.  You can also specify that
all PostScript export files permanently use CMYK colors with the
command {cmd:translator set Graph2ps cmyk on} or 
{cmd:translator set Graph2eps cmyk on} for EPS files.

{pstd}
Stata uses, for lack of a better term, normalized CMYK values.  That simply
means that at least one of the CMY values is normalized to 0 for all CMYK
colors, with the K (black) value "absorbing" all parts of CM and Y where they
are all positive.  An example may help:  {cmd:10 10 5 0} is taken to be the
normalized CMYK value {cmd:5 5 0 5}.  That is, all CMY colors were 5 or
greater, so this component was moved to black ink, and 5 was subtracted from
each of the CMY values.  If you specify your CMYK colors in normalized form,
these will be exactly the values output by {cmd:graph export}, and you should
never be surprised by the resulting colors.


{marker hsv}{...}
{title:HSV values}

{pstd}
You can also mix your own colors by specifying HSV (Hue, Saturation, and
Value) values.  These are also sometimes called HSL (Hue, Saturation, and
Luminance) or HSB (Hue, Saturation, and Brightness).
An HSV value is a triplet of numbers.  The first number specifies the hue and
is specified on a circular 360-degree scale.  Any number can be specified for
the hue, but numbers above 360 are taken as modulo 360.  The second number
specifies the saturation of the color as a proportion between 0 and 1, and the
third number specifies the value (luminance/brightness) between 0 and 1.  HSV
colors must be prefaced with {cmd:hsv}.

{pstd}
Some examples of HSV colors are

	{cmd:red}     =   {cmd:hsv   0    1    1}
	{cmd:green}   =   {cmd:hsv 120    1    1}
	{cmd:blue}    =   {cmd:hsv 240    1    1}

	{cmd:cyan}    =   {cmd:hsv 180    1    1}
	{cmd:magenta} =   {cmd:hsv 300    1    1}
	{cmd:yellow}  =   {cmd:hsv  60    1    1}
	{cmd:white}   =   {cmd:hsv   0    0    1}
	{cmd:black}   =   {cmd:hsv   0    0    0}

Putting the primary colors in their HSV hue order,

	{cmd:red}     =   {cmd:hsv   0    1    1}
	{cmd:yellow}  =   {cmd:hsv  60    1    1}
	{cmd:green}   =   {cmd:hsv 120    1    1}
	{cmd:cyan}    =   {cmd:hsv 180    1    1}
	{cmd:blue}    =   {cmd:hsv 240    1    1}
	{cmd:magenta} =   {cmd:hsv 300    1    1}

With the exception of {cmd:black}, all of the listed colors specify a
saturation and value of {cmd:1}.  This is because these are the primary colors
in the RGB and CMYK spaces and therefore have full saturation and brightness.
Reducing the saturation will reduce the amount of color.  Reducing the
brightness will make the color dimmer.



{marker remarks5}{...}
{title:Adjusting intensity}

{pstd}
To specify a color and modify its intensity (brightness), you might specify
things such as

	{cmd:green*.8}
	{cmd:red*1}
	{cmd:purple*1.2}
	{cmd:0 255 255*.8}

{pstd}
Multiplying a color
by 1 leaves the color unchanged.  Multiplying by a number greater than 1 makes
the color stand out from the background more; multiplying by a number less
than 1 makes the color blend into the background more.  For an example using
the intensity adjustment, see {it:{help twoway kdensity##remarks1:Typical use}}
in {manhelp twoway_kdensity G-2:graph twoway kdensity}.

{pstd}
When modifying intensity, the syntax is

	{it:color}{cmd:*}{it:#}

{pstd}
or the color may be omitted:

	{cmd:*}{it:#}

{pstd}
If the color is omitted, the intensity adjustment is applied to the default
color, given the context.
For instance, you specify {cmd:bcolor(*.7)} with {cmd:graph}
{cmd:twoway} {cmd:bar} -- or any other {cmd:graph} {cmd:twoway} command
that fills an area -- to use the default color at 70% intensity.  Or you
specify {cmd:bcolor(*2)} to use the default color at twice its usual
intensity.

{pstd}
When you specify both the color and the adjustment, you must type the color
first:  {cmd:.8*green} will not be understood.  Also, do not put a space
between the {it:color} and the {cmd:*}, even when the {it:color} is an RGB
or CMYK value.

{pstd}
{it:color}{cmd:*0} makes the color as dim as possible, but it is not equivalent
to color {cmd:none}.  {it:color}{cmd:*255} makes the color as bright as
possible, although values much smaller than 255 usually achieve the
same result.
{p_end}

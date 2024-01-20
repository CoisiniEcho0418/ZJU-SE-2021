{smcl}
{* *! version 1.1.4  03may2011}{...}
{viewerdialog stem "dialog stem"}{...}
{vieweralsosee "[R] stem" "mansection R stem"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] histogram" "help histogram"}{...}
{vieweralsosee "[R] lv" "help lv"}{...}
{viewerjumpto "Syntax" "stem##syntax"}{...}
{viewerjumpto "Description" "stem##description"}{...}
{viewerjumpto "Options" "stem##options"}{...}
{viewerjumpto "Examples" "stem##examples"}{...}
{viewerjumpto "Saved results" "stem##saved_results"}{...}
{title:Title}

{p2colset 5 17 19 2}{...}
{p2col:{manlink R stem} {hline 2}}Stem-and-leaf displays{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 13 2}
{cmd:stem}
{varname}
{ifin}
[{cmd:,} {it:options}]

{synoptset 14 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt p:rune}}do not print stems that have no leaves{p_end}
{synopt:{opt r:ound(#)}}round data to this value; default is {cmd:round(1)}{p_end}
{synopt:{opt d:igits(#)}}digits per leaf; default is {cmd:digits(1)}{p_end}
{synopt:{opt l:ines(#)}}number of stems per interval of 10^{cmd:digits}{p_end}
{synopt:{opt w:idth(#)}}stem width; equal to (10^{cmd:digits})/{opt width}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{opt by} is allowed; see {manhelp by D}.{p_end}


{title:Menu}

{phang}
{bf:Statistics > Summaries, tables, and tests >}
      {bf:Distributional plots and tests > Stem-and-leaf display}


{marker description}{...}
{title:Description}

{pstd}
{opt stem} displays stem-and-leaf plots.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt prune} prevents printing any stems that have no leaves.

{phang}
{opt round(#)} rounds the data to this value and displays the
plot in these units.  If {opt round()} is not specified,
noninteger data will be rounded automatically.

{phang}
{opt digits(#)} sets the number of digits per leaf.  The default is 1.

{phang}
{opt lines(#)} sets the number of stems per every data
interval of 10^{cmd:digits}.  The value of {opt lines()} must divide
10^{cmd:digits}; that is, if {cmd:digits(1)} is specified, then {opt lines()}
must divide 10.  If {cmd:digits(2)} is specified, then {opt lines()}
must divide 100, etc.  Only one of {opt lines()} or {opt width()} may be specified.
If neither is specified, an appropriate value will be set automatically.

{phang}
{opt width(#)} sets the width of a stem.  {opt lines()} is equal to 
(10^{cmd:digits})/{opt width}, and this option is merely an alternative way of
setting {opt lines()}.  The value of {opt width()} must divide 10^{cmd:digits}.
Only one of {opt width()} or {opt lines()} may be specified.
If neither is specified, an appropriate value will be set automatically.

{pstd}
Note:  If {opt lines()} or {opt width()} is not specified, {opt digits()} may be
decreased in some circumstances to make a better-looking plot.  If {opt lines()}
or {opt width()} is set, the user-specified value of {opt digits()} will not be
altered.


{marker examples}{...}
{title:Examples}

	{cmd:. webuse stemxmpl}
	{cmd:. stem x}

	{txt}Stem-and-leaf plot for x

	  {res}2* | 11111
	  2t | 22222333
	  2f | 444455555
	  2s | 666
	  2. | 8889
	  3* | 001{txt}

{pstd}
Note:  the above plot is a five-line plot ({hi:lines} = 5 and {hi:width} = 2).

	{cmd:. stem x, lines(2)}

	{txt}Stem-and-leaf plot for x

	  {res}2* | 11111222223334444
	  2. | 555556668889
	  3* | 001{txt}

{pstd}
Note:  {hi:stem x, width(5)} will produce the same plot as above.

	{cmd:. sysuse auto}
	{cmd:. stem weight, lines(1) digits(2)}

	{txt}Stem-and-leaf plot for weight (Weight (lbs.))

	  {res}17** | 60
          18** | 00,00,30
	  19** | 30,80,90
	  20** | 20,40,50,70
	  21** | 10,20,30,60
	  22** | 00,00,30,40,80
	  23** | 70
	  24** | 10
	  25** | 20,80
	  26** | 40,50,50,70,90
	  27** | 30,50,50
	  28** | 30,30
	  29** | 30
	  30** | 
	  31** | 70,80
	  32** | 00,10,20,50,60,80
	  33** | 00,10,30,50,70,70
	  34** | 00,20,20,30,70
	  35** | 
	  36** | 00,00,70,90,90
	  37** | 00,20,40
	  38** | 30,80
	  39** | 00
	  40** | 30,60,60,80
	  41** | 30
	  42** | 90
	  43** | 30
	  44** | 
	  45** | 
	  46** | 
	  47** | 20
	  48** | 40{txt}

	{cmd:. stem weight, lines(1) digits(2) prune}

	{txt}Stem-and-leaf plot for weight (Weight (lbs.))

	  {res}17** | 60
 	  18** | 00,00,30
	  19** | 30,80,90
	  20** | 20,40,50,70
	  21** | 10,20,30,60
	  22** | 00,00,30,40,80
	  23** | 70
	  24** | 10
	  25** | 20,80
	  26** | 40,50,50,70,90
	  27** | 30,50,50
	  28** | 30,30
	  29** | 30
	  31** | 70,80
	  32** | 00,10,20,50,60,80
	  33** | 00,10,30,50,70,70
	  34** | 00,20,20,30,70
	  36** | 00,00,70,90,90
	  37** | 00,20,40
	  38** | 30,80
	  39** | 00
	  40** | 30,60,60,80
	  41** | 30
	  42** | 90
	  43** | 30
	  47** | 20
	  48** | 40{txt}

	{cmd:. stem weight, round(100)}

	{txt}Stem-and-leaf plot for weight (Weight (lbs.))

	price rounded to nearest multiple of {res:100}
	plot in units of {res:100}

	   {res}1. | 88889
	   2* | 000011111
	   2t | 222223
	   2f | 445
	   2s | 6677777
	   2. | 88889
	   3* | 
	   3t | 22222333333
	   3f | 44444445
	   3s | 66777777
	   3. | 899
	   4* | 01111
	   4t | 33
	   4f | 
	   4s | 7
	   4. | 8{txt}


{marker saved_results}{...}
{title:Saved results}

{pstd}
{cmd:stem} saves the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(width)}}width of a stem{p_end}
{synopt:{cmd:r(digits)}}number of digits per leaf; default is 1{p_end}

{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(round)}}number specified in {cmd:round()}{p_end}
{p2colreset}{...}

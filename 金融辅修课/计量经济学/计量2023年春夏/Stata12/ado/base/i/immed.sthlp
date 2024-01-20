{smcl}
{* *! version 1.1.3  17mar2011}{...}
{findalias asfrimmediate}{...}
{title:Title}

{pstd}
{findalias frimmediate}


{title:Remarks}

{pstd}
An immediate command is a command that obtains data not from the data
stored in memory but from numbers typed as arguments.  Immediate commands, in
effect, turn Stata into a glorified hand calculator.

{pstd}
Sometimes you may not have the data, but you know something
about the data and what you do know is adequate to perform the statistical
test.

{pstd}
Immediate commands have the following properties:

{phang2}1.  They never disturb the data in memory.

{phang2}2.  The syntax for all is the same: the command name followed by
numbers that are the summary statistics from which the statistic is
calculated.

{phang2}3.  Immediate commands end in the letter i, although the converse is
not true.

{phang2}4.  Immediate commands are documented along with their nonimmediate
cousins.

{pstd}
Immediate commands include the following:

{p2colset 9 25 27 2}{...}
{p2col :Command}Description{p_end}
{p2line}
{p2col :{helpb bitesti}}Binomial probability test{p_end}
{p2col :{helpb cci}}Tables for epidemiologists; see {manhelp epitab ST}{p_end}
{p2col :{helpb csi}}{p_end}
{p2col :{helpb iri}}{p_end}
{p2col :{helpb mcci}}{p_end}
{p2col :{helpb cii}}Confidence intervals for means, proportions, counts{p_end}
{p2col :{helpb prtesti}}One- and two-sample tests of proportions{p_end}
{p2col :{helpb sampsi}}Sample size and power for means and proportions{p_end}
{p2col :{helpb sdtesti}}Variance comparison tests{p_end}
{p2col :{helpb symmi}}Symmetry and marginal homogeneity tests{p_end}
{p2col :{helpb tabi}}One- and two-way tables of frequencies{p_end}
{p2col :{helpb ttesti}}Mean comparison tests{p_end}
{p2col :{helpb twoway scatteri}}Scatterplot{p_end}
{p2col :{helpb twoway pci}}Paired-coordinate plot with spikes or lines{p_end}
{p2col :{helpb twoway pcarrowi}}Paired-coordinate plot with arrows{p_end}
{p2line}

{pstd}
The {cmd:display} command is not really an immediate command, but it can be
used to perform as a hand calculator; see {manhelp display P}.
{p_end}

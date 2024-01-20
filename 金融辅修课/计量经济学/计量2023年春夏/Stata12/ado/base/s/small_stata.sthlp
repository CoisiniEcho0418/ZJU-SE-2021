{smcl}
{* *! version 1.2.4  21jun2011}{...}
{vieweralsosee "[R] about" "help about"}{...}
{vieweralsosee "[D] data types" "help data_types"}{...}
{vieweralsosee "[R] matsize" "help matsize"}{...}
{vieweralsosee "[D] memory" "help memory"}{...}
{vieweralsosee "[R] set" "help set"}{...}
{vieweralsosee "[U] 5 Flavors of Stata" "help flavors"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "limits" "help limits"}{...}
{vieweralsosee "Stata/IC" "help stataic"}{...}
{vieweralsosee "Stata/MP" "help statamp"}{...}
{vieweralsosee "Stata/SE" "help statase"}{...}
{viewerjumpto "Using Small Stata" "small_stata##use"}{...}
{viewerjumpto "Contents" "small_stata##contents"}{...}
{marker use}{...}
{title:Using Small Stata}

{pstd}
There are four flavors of Stata:

{col 13}Flavor{col 29}Description
{col 13}{hline 47}
{col 10}-> {bf:Small Stata}{col 29}for undergraduate students
{col 13}{bf:Stata/IC}{col 29}standard version 
{col 13}{bf:Stata/SE}{col 29}Stata/IC + large datasets
{col 13}{bf:Stata/MP}{col 29}Stata/SE + parallel processing
{col 13}{hline 47}
{col 13}See {bf:{help flavors:[U] 5 Flavors of Stata}} for descriptions

{pstd}
To determine which flavor of Stata you are running, type

	    {cmd:. about}

{pstd}
If you are using a different flavor of Stata, click on the appropriate
link:  

{col 13}{hline 47}
{col 13}{bf:{help stataic:Stata/IC}}{col 29}Using Stata/IC
{col 13}{bf:{help statase:Stata/SE}}{col 29}Using Stata/SE
{col 13}{bf:{help statamp:Stata/MP}}{col 29}Using Stata/MP
{col 13}{hline 47}

{pstd}
For information on upgrading to Stata/IC, Stata/SE or Stata/MP, point your
browser to {browse "http://www.stata.com"}.


{marker contents}{...}
{title:Contents}

	1.  {help small_stata##starting:Starting Small Stata}
	2.  {help small_stata##setting:Small Stata's limits}
	3.  {help small_stata##dta:Sharing .dta datasets with other users}
	4.  {help small_stata##programming:Advice to programmers:  Determining flavor}


{marker starting}{...}
{title:1.  Starting Small Stata}

{pstd}
You start Small Stata as follows:

{p 8 12 4}
    Windows:{break}
	Select {bf:Start > Programs > Stata > Small Stata {ccl stata_version}}

{p 8 12 4}
    Mac:{break}
        Double-click the file {hi:Stata.do} from the {hi:data} folder, or
        double-click the {hi:smStata} icon from the {hi:Stata} folder.

{p 8 12 4}
    Unix:{break}
	At the Unix command prompt, type {cmd:xstata-sm} to invoke the GUI
	version of Small Stata or type {cmd:stata-sm} to invoke the console
        version.


{marker setting}{...}
{title:2.  Small Stata's limits}

{pstd}
Small Stata is the special version of Stata for student use, and allows 
datasets of 99 variables and 1,200 observations.
The maximum number of variables in a model is 40.
These limits may not be reset.


{marker dta}{...}
{title:3.  Sharing .dta datasets with other users}

{pstd}
Datasets created by Small Stata may be used with any flavor of Stata.


{marker programming}{...}
{title:4.  Advice to programmers:  Determining flavor}

{pstd}
Programmers can determine which flavor of Stata is running by 
examining the {help creturn} values

		                 creturn values
                        {c |} {cmd:c(flavor)   c(SE)     c(MP)}
	    {hline 12}{c +}{hline 30}
	    Small Stata {c |}  "{cmd:Small}"      0         0
	    Stata/IC    {c |}  "{cmd:IC}"         0         0
	    Stata/SE    {c |}  "{cmd:IC}"         1         0
	    Stata/MP    {c |}  "{cmd:IC}"         1         1
	    {hline 12}{c BT}{hline 30}
